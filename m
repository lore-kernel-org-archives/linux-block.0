Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A90C48BE6
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 13:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10ADE6024A
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 13:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhFPNJJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 09:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233228AbhFPNJH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 09:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623848820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LxN8jIHyhdhyntZFjGmGbaw2e17fq9m2ICTyCfnEP5g=;
        b=e96S/exCucnlR028EjCVes3q4j5aEQjCWcLQlw0YooY1c0b+5KvIqfoIEtxvoV+ps/36mR
        7w5yGhfxbS714qiYltlYleCqikhv1iiYnhW51K20sWG/8zuQbYrqFotJtuCDb1OdqcPt04
        s1k+J0eUHLxF0hLX/XWcrZXLFcA7y4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-PxR36WMWO06s-oeKDJg6Tw-1; Wed, 16 Jun 2021 09:06:59 -0400
X-MC-Unique: PxR36WMWO06s-oeKDJg6Tw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 418251926DAB;
        Wed, 16 Jun 2021 13:06:58 +0000 (UTC)
Received: from localhost (ovpn-12-48.pek2.redhat.com [10.72.12.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7159160C13;
        Wed, 16 Jun 2021 13:06:57 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 2/4] block: add field of .bi_bio_drv_data to bio
Date:   Wed, 16 Jun 2021 21:05:31 +0800
Message-Id: <20210616130533.754248-3-ming.lei@redhat.com>
In-Reply-To: <20210616130533.754248-1-ming.lei@redhat.com>
References: <20210616130533.754248-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After bio is submitted, bio->bi_next is used for IO merge for request
based queue only.

Reuse the filed for bio based driver for storing driver data, and name
it as .bi_bio_drv_data.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blk_types.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 6e6c2af48d74..acb45213338c 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -220,7 +220,16 @@ typedef unsigned int blk_qc_t;
  * stacking drivers)
  */
 struct bio {
-	struct bio		*bi_next;	/* request queue link */
+	union {
+		/* request queue link */
+		struct bio		*bi_next;
+
+		/*
+		 * once bio is submitted to bio based queue, driver can use
+		 * this field to store its own data
+		 */
+		void			*bi_bio_drv_data;
+	};
 	struct block_device	*bi_bdev;
 	unsigned int		bi_opf;		/* bottom bits req flags,
 						 * top bits REQ_OP. Use
-- 
2.31.1

