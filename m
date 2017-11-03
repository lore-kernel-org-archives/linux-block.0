Return-Path: <prvs=473169c3e=Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Ard
 Biesheuvel" <ard.biesheuvel@linaro.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v3 2/8] crypto: scompress - use sgl_alloc() and sgl_free()
Date: Fri, 3 Nov 2017 15:23:33 -0700
Message-ID: <20171103222339.26540-3-bart.vanassche@wdc.com>
In-Reply-To: <20171103222339.26540-1-bart.vanassche@wdc.com>
References: <20171103222339.26540-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

Use the sgl_alloc() and sgl_free() functions instead of open coding
these functions.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/Kconfig     |  1 +
 crypto/scompress.c | 51 ++-------------------------------------------------
 2 files changed, 3 insertions(+), 49 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 0a121f9ddf8e..a0667dd284ff 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -105,6 +105,7 @@ config CRYPTO_KPP
 config CRYPTO_ACOMP2
 	tristate
 	select CRYPTO_ALGAPI2
+	select SGL_ALLOC
 
 config CRYPTO_ACOMP
 	tristate
diff --git a/crypto/scompress.c b/crypto/scompress.c
index 2075e2c4e7df..968bbcf65c94 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -140,53 +140,6 @@ static int crypto_scomp_init_tfm(struct crypto_tfm *tfm)
 	return ret;
 }
 
-static void crypto_scomp_sg_free(struct scatterlist *sgl)
-{
-	int i, n;
-	struct page *page;
-
-	if (!sgl)
-		return;
-
-	n = sg_nents(sgl);
-	for_each_sg(sgl, sgl, n, i) {
-		page = sg_page(sgl);
-		if (page)
-			__free_page(page);
-	}
-
-	kfree(sgl);
-}
-
-static struct scatterlist *crypto_scomp_sg_alloc(size_t size, gfp_t gfp)
-{
-	struct scatterlist *sgl;
-	struct page *page;
-	int i, n;
-
-	n = ((size - 1) >> PAGE_SHIFT) + 1;
-
-	sgl = kmalloc_array(n, sizeof(struct scatterlist), gfp);
-	if (!sgl)
-		return NULL;
-
-	sg_init_table(sgl, n);
-
-	for (i = 0; i < n; i++) {
-		page = alloc_page(gfp);
-		if (!page)
-			goto err;
-		sg_set_page(sgl + i, page, PAGE_SIZE, 0);
-	}
-
-	return sgl;
-
-err:
-	sg_mark_end(sgl + i);
-	crypto_scomp_sg_free(sgl);
-	return NULL;
-}
-
 static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 {
 	struct crypto_acomp *tfm = crypto_acomp_reqtfm(req);
@@ -220,7 +173,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 					      scratch_dst, &req->dlen, *ctx);
 	if (!ret) {
 		if (!req->dst) {
-			req->dst = crypto_scomp_sg_alloc(req->dlen, GFP_ATOMIC);
+			req->dst = sgl_alloc(req->dlen, GFP_ATOMIC, NULL);
 			if (!req->dst)
 				goto out;
 		}
@@ -274,7 +227,7 @@ int crypto_init_scomp_ops_async(struct crypto_tfm *tfm)
 
 	crt->compress = scomp_acomp_compress;
 	crt->decompress = scomp_acomp_decompress;
-	crt->dst_free = crypto_scomp_sg_free;
+	crt->dst_free = sgl_free;
 	crt->reqsize = sizeof(void *);
 
 	return 0;
-- 
2.14.3
