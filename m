Return-Path: <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <lvivier@redhat.com>,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org,
    linux-block@vger.kernel.org,
    stable@vger.kernel.org
Message-Id: <ed5a2015ecd360746ab52e8d3f5e8b6f5e1568fa.1523493475.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1523493475.git.fthain@telegraphics.com.au>
References: <cover.1523493475.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 02/10] m68k/mac: Fix SWIM memory resource end address
Date: Wed, 11 Apr 2018 20:50:14 -0400 (EDT)
List-ID: <linux-block@vger.kernel.org>

The resource size is 0x2000 == end - start + 1.
Therefore end == start + 0x2000 - 1.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: stable@vger.kernel.org # v4.14+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/mac/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 84bd9161bf23..4a544a6c72dd 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -1011,7 +1011,7 @@ int __init mac_platform_init(void)
 		struct resource swim_rsrc = {
 			.flags = IORESOURCE_MEM,
 			.start = (resource_size_t)swim_base,
-			.end   = (resource_size_t)swim_base + 0x2000,
+			.end   = (resource_size_t)swim_base + 0x1FFF,
 		};
 
 		platform_device_register_simple("swim", -1, &swim_rsrc, 1);
-- 
2.16.1
