Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8DDC282DA
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 21:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7526820850
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 21:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfDKVJQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:09:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbfDKVJL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 17:09:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C86FA0C5C;
        Thu, 11 Apr 2019 21:09:11 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB5D95C21E;
        Thu, 11 Apr 2019 21:09:09 +0000 (UTC)
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
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v1 13/15] fs/splice: use put_user_page() when appropriate
Date:   Thu, 11 Apr 2019 17:08:32 -0400
Message-Id: <20190411210834.4105-14-jglisse@redhat.com>
In-Reply-To: <20190411210834.4105-1-jglisse@redhat.com>
References: <20190411210834.4105-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 11 Apr 2019 21:09:11 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Use put_user_page() when page reference was taken through GUP.

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
---
 fs/splice.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 4a0b522a0cb4..c9c350d37912 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -371,6 +371,7 @@ static ssize_t default_file_splice_read(struct file *in, loff_t *ppos,
 	unsigned int nr_pages;
 	size_t offset, base, copied = 0;
 	ssize_t res;
+	bool gup;
 	int i;
 
 	if (pipe->nrbufs == pipe->buffers)
@@ -383,7 +384,7 @@ static ssize_t default_file_splice_read(struct file *in, loff_t *ppos,
 	offset = *ppos & ~PAGE_MASK;
 
 	iov_iter_pipe(&to, READ, pipe, len + offset);
-
+	gup = iov_iter_get_pages_use_gup(&to);
 	res = iov_iter_get_pages_alloc(&to, &pages, len + offset, &base);
 	if (res <= 0)
 		return -ENOMEM;
@@ -419,8 +420,12 @@ static ssize_t default_file_splice_read(struct file *in, loff_t *ppos,
 	if (vec != __vec)
 		kfree(vec);
 out:
-	for (i = 0; i < nr_pages; i++)
-		put_page(pages[i]);
+	for (i = 0; i < nr_pages; i++) {
+		if (gup)
+			put_user_page(pages[i]);
+		else
+			put_page(pages[i]);
+	}
 	kvfree(pages);
 	iov_iter_advance(&to, copied);	/* truncates and discards */
 	return res;
-- 
2.20.1

