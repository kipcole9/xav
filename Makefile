# Env vars provided by elixir_make
# see https://hexdocs.pm/elixir_make/Mix.Tasks.Compile.ElixirMake.html#module-default-environment-variables
# ERTS_INCLUDE_DIR
# MIX_APP_PATH

XAV_DIR = c_src/xav
PRIV_DIR = $(MIX_APP_PATH)/priv
XAV_SO = $(PRIV_DIR)/libxav.so

# uncomment to compile with debug logs
# XAV_DEBUG_LOGS = -DXAV_DEBUG=1

CFLAGS = -fPIC -I$(ERTS_INCLUDE_DIR) -I${XAV_DIR} -shared $(XAV_DEBUG_LOGS)
LDFLAGS = -lavcodec -lswscale -lavutil -lavformat

$(XAV_SO): Makefile $(XAV_DIR)/xav_nif.c $(XAV_DIR)/utils.h $(XAV_DIR)/utils.c
	mkdir -p $(PRIV_DIR)
	$(CC) $(CFLAGS) $(XAV_DIR)/xav_nif.c $(XAV_DIR)/utils.c -o $(XAV_SO) $(LDFLAGS)

format:
	clang-format -i $(XAV_DIR)/*

.PHONY: format