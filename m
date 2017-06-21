Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@wdc.com>, Neil Brown <neilb@suse.com>, "Hannes
 Reinecke" <hare@suse.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/3] block: Declare local symbols static
Date: Wed, 21 Jun 2017 10:55:45 -0700
Message-ID: <20170621175547.21692-2-bart.vanassche@wdc.com>
In-Reply-To: <20170621175547.21692-1-bart.vanassche@wdc.com>
References: <20170621175547.21692-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@wdc.com
List-ID: <linux-block@vger.kernel.org>

Avoid that building with W=1 causes the compiler to complain that
a declaration for bounce_bio_set and bounce_bio_split is missing.

References: commit a8821f3f32be ("block: Improvements to bounce-buffer handling")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Neil Brown <neilb@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/bounce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bounce.c b/block/bounce.c
index 17d77613c471..916ee9a9a216 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -26,7 +26,7 @@
 #define POOL_SIZE	64
 #define ISA_POOL_SIZE	16
 
-struct bio_set *bounce_bio_set, *bounce_bio_split;
+static struct bio_set *bounce_bio_set, *bounce_bio_split;
 static mempool_t *page_pool, *isa_page_pool;
 
 #if defined(CONFIG_HIGHMEM) || defined(CONFIG_NEED_BOUNCE_POOL)
-- 
2.13.1
