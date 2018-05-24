Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 32/33] block: always define BIO_MAX_PAGES as 256
Date: Thu, 24 May 2018 17:01:37 +0800
Message-Id: <20180524090139.2150-33-ming.lei@redhat.com>
In-Reply-To: <20180524090139.2150-1-ming.lei@redhat.com>
References: <20180524090139.2150-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Now multipage bvec can cover CONFIG_THP_SWAP, so we don't need to
increase BIO_MAX_PAGES for it.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bio.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index fc8a8238805e..839dddf81d09 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -38,15 +38,7 @@
 #define BIO_BUG_ON
 #endif
 
-#ifdef CONFIG_THP_SWAP
-#if HPAGE_PMD_NR > 256
-#define BIO_MAX_PAGES		HPAGE_PMD_NR
-#else
 #define BIO_MAX_PAGES		256
-#endif
-#else
-#define BIO_MAX_PAGES		256
-#endif
 
 #define bio_prio(bio)			(bio)->bi_ioprio
 #define bio_set_prio(bio, prio)		((bio)->bi_ioprio = prio)
-- 
2.9.5
