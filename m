Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 29/30] block: always define BIO_MAX_PAGES as 256
Date: Sat,  9 Jun 2018 20:30:13 +0800
Message-Id: <20180609123014.8861-30-ming.lei@redhat.com>
In-Reply-To: <20180609123014.8861-1-ming.lei@redhat.com>
References: <20180609123014.8861-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Now multipage bvec can cover CONFIG_THP_SWAP, so we don't need to
increase BIO_MAX_PAGES for it.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bio.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 69ef05dc7019..58838dc12d69 100644
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
