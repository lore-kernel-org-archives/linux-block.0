Return-Path: <christophe.leroy@c-s.fr>
Message-Id: <841b980a6f1b3e9a9d3c20c5da39a88292033dbe.1539092111.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539092111.git.christophe.leroy@c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 04/24] soc/fsl/qbman: use ioremap_cache() instead of
 ioremap_prot(0)
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>, Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date: Tue,  9 Oct 2018 13:51:39 +0000 (UTC)
List-ID: <linux-block@vger.kernel.org>

ioremap_prot() with flag set to 0 relies on a hack in
__ioremap_caller() which adds PAGE_KERNEL flags when the
handed flags don't look like a valid set of flags
(ie don't include _PAGE_PRESENT)

The intention being to map cached memory, use ioremap_cache() instead.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/soc/fsl/qbman/qman_ccsr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index 79cba58387a5..0fbb201346c7 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -418,7 +418,7 @@ static size_t fqd_sz, pfdr_sz;
 static int zero_priv_mem(phys_addr_t addr, size_t sz)
 {
 	/* map as cacheable, non-guarded */
-	void __iomem *tmpp = ioremap_prot(addr, sz, 0);
+	void __iomem *tmpp = ioremap_cache(addr, sz);
 
 	if (!tmpp)
 		return -ENOMEM;
-- 
2.13.3
