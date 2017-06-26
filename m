Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752887AbdFZMTR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 08:19:17 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH v2 37/51] dm-crypt: don't clear bvec->bv_page in crypt_free_buffer_pages()
Date: Mon, 26 Jun 2017 20:10:20 +0800
Message-Id: <20170626121034.3051-38-ming.lei@redhat.com>
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
References: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The bio is always freed after running crypt_free_buffer_pages(),
so it isn't necessary to clear the bv->bv_page.

Cc: Mike Snitzer <snitzer@redhat.com>
Cc:dm-devel@redhat.com
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/dm-crypt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index cdf6b1e12460..664ba3504f48 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1450,7 +1450,6 @@ static void crypt_free_buffer_pages(struct crypt_config *cc, struct bio *clone)
 	bio_for_each_segment_all(bv, clone, i) {
 		BUG_ON(!bv->bv_page);
 		mempool_free(bv->bv_page, cc->page_pool);
-		bv->bv_page = NULL;
 	}
 }
 
-- 
2.9.4
