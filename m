Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F20AC282CE
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 21:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C4720850
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 21:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfDKVKo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:10:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbfDKVIq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 17:08:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 27B22307D910;
        Thu, 11 Apr 2019 21:08:46 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99D0A5C219;
        Thu, 11 Apr 2019 21:08:44 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?q?Ernesto=20A=20=2E=20Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
Subject: [PATCH v1 01/15] fs/direct-io: fix trailing whitespace issues
Date:   Thu, 11 Apr 2019 17:08:20 -0400
Message-Id: <20190411210834.4105-2-jglisse@redhat.com>
In-Reply-To: <20190411210834.4105-1-jglisse@redhat.com>
References: <20190411210834.4105-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 11 Apr 2019 21:08:46 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Remove bunch of trailing whitespace. Just hurts my eyes.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
---
 fs/direct-io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 9bb015bc4a83..52a18858e3e7 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -196,7 +196,7 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 		sdio->to = ((ret - 1) & (PAGE_SIZE - 1)) + 1;
 		return 0;
 	}
-	return ret;	
+	return ret;
 }
 
 /*
@@ -344,7 +344,7 @@ static void dio_aio_complete_work(struct work_struct *work)
 static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio);
 
 /*
- * Asynchronous IO callback. 
+ * Asynchronous IO callback.
  */
 static void dio_bio_end_aio(struct bio *bio)
 {
@@ -777,7 +777,7 @@ static inline int dio_bio_add_page(struct dio_submit *sdio)
 	}
 	return ret;
 }
-		
+
 /*
  * Put cur_page under IO.  The section of cur_page which is described by
  * cur_page_offset,cur_page_len is put into a BIO.  The section of cur_page
@@ -839,7 +839,7 @@ static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
  * An autonomous function to put a chunk of a page under deferred IO.
  *
  * The caller doesn't actually know (or care) whether this piece of page is in
- * a BIO, or is under IO or whatever.  We just take care of all possible 
+ * a BIO, or is under IO or whatever.  We just take care of all possible
  * situations here.  The separation between the logic of do_direct_IO() and
  * that of submit_page_section() is important for clarity.  Please don't break.
  *
@@ -940,7 +940,7 @@ static inline void dio_zero_block(struct dio *dio, struct dio_submit *sdio,
 	 * We need to zero out part of an fs block.  It is either at the
 	 * beginning or the end of the fs block.
 	 */
-	if (end) 
+	if (end)
 		this_chunk_blocks = dio_blocks_per_fs_block - this_chunk_blocks;
 
 	this_chunk_bytes = this_chunk_blocks << sdio->blkbits;
-- 
2.20.1

