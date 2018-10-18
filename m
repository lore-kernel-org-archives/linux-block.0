Return-Path: <axboe@kernel.dk>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Ondrej Zary <linux@rainbow-software.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: setup bounce bio_sets properly
Message-ID: <34e24d47-12e4-230c-4088-1d3f2ffa6b79@kernel.dk>
Date: Thu, 18 Oct 2018 15:24:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

We're only setting up the bounce bio sets if we happen
to need bouncing for regular HIGHMEM, not if we only need
it for ISA devices.

Reported-by: Ondrej Zary <linux@rainbow-software.org>
Tested-by: Ondrej Zary <linux@rainbow-software.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/bounce.c b/block/bounce.c
index b30071ac4ec6..1356a2f4aae2 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -31,6 +31,24 @@
 static struct bio_set bounce_bio_set, bounce_bio_split;
 static mempool_t page_pool, isa_page_pool;
 
+static void init_bounce_bioset(void)
+{
+	static bool bounce_bs_setup;
+	int ret;
+
+	if (bounce_bs_setup)
+		return;
+
+	ret = bioset_init(&bounce_bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
+	BUG_ON(ret);
+	if (bioset_integrity_create(&bounce_bio_set, BIO_POOL_SIZE))
+		BUG_ON(1);
+
+	ret = bioset_init(&bounce_bio_split, BIO_POOL_SIZE, 0, 0);
+	BUG_ON(ret);
+	bounce_bs_setup = true;
+}
+
 #if defined(CONFIG_HIGHMEM)
 static __init int init_emergency_pool(void)
 {
@@ -44,14 +62,7 @@ static __init int init_emergency_pool(void)
 	BUG_ON(ret);
 	pr_info("pool size: %d pages\n", POOL_SIZE);
 
-	ret = bioset_init(&bounce_bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
-	BUG_ON(ret);
-	if (bioset_integrity_create(&bounce_bio_set, BIO_POOL_SIZE))
-		BUG_ON(1);
-
-	ret = bioset_init(&bounce_bio_split, BIO_POOL_SIZE, 0, 0);
-	BUG_ON(ret);
-
+	init_bounce_bioset();
 	return 0;
 }
 
@@ -102,6 +113,7 @@ int init_emergency_isa_pool(void)
 	BUG_ON(ret);
 
 	pr_info("isa pool size: %d pages\n", ISA_POOL_SIZE);
+	init_bounce_bioset();
 	return 0;
 }
 
-- 
Jens Axboe
