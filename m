Return-Path: <SRS0=+EVs=26=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D846C32771
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 08:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011132072A
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 08:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H64pkTLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgAII45 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:56:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25628 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728782AbgAII44 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Jan 2020 03:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578560215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uLsze3kKjBA0ECELZdOw+89RvWDM/gRkVl333vOkw1U=;
        b=H64pkTLWSQr0T/8KJOZlP/QjfEX2j+9j7t0k5z28cLKWd7lU0cVtG0gofnrhfaaXH5vreN
        pCLp/fB87DclkW1XnXRkk0IHM6c9iGYfdIbN03cpuu+aHHoCp6e3giwwrVKOa6MIsFbbjB
        TzY4QFPLIja6+Afmzd1Fa7aH8wTYh6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-9SZsSij1Nke1XaAZH6E-1A-1; Thu, 09 Jan 2020 03:56:52 -0500
X-MC-Unique: 9SZsSij1Nke1XaAZH6E-1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63F1E1902EA0;
        Thu,  9 Jan 2020 08:56:51 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EFBF5DA2C;
        Thu,  9 Jan 2020 08:56:48 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] block: only zero page for bio of REQ_OP_READ in bio_truncate
Date:   Thu,  9 Jan 2020 16:56:40 +0800
Message-Id: <20200109085640.14589-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 85a8ce62c2ea ("block: add bio_truncate to fix guard_bio_eod") adds
bio_truncate() which changes to zero the truncated pages for any bio whic=
h
direction is READ. This way may change the behavior of guard_bio_eod(), s=
o
change back to orginal behavior of just zeroing bio of REQ_OP_READ.

Meantime add kerneldoc for bio_truncate() as suggested by Christoph.

Fixes: 85a8ce62c2ea ("block: add bio_truncate to fix guard_bio_eod")
Reported-by: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 006bcc52a77e..94d697217887 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -538,6 +538,16 @@ void zero_fill_bio_iter(struct bio *bio, struct bvec=
_iter start)
 }
 EXPORT_SYMBOL(zero_fill_bio_iter);
=20
+/**
+ * bio_truncate - truncate the bio to small size of @new_size
+ * @bio:	the bio to be truncated
+ * @new_size:	new size for truncating the bio
+ *
+ * Description:
+ *   Truncate the bio to new size of @new_size. If bio_op(bio) is
+ *   REQ_OP_READ, zero the truncated part. This function should only
+ *   be used for handling corner cases, such as bio eod.
+ */
 void bio_truncate(struct bio *bio, unsigned new_size)
 {
 	struct bio_vec bv;
@@ -548,7 +558,7 @@ void bio_truncate(struct bio *bio, unsigned new_size)
 	if (new_size >=3D bio->bi_iter.bi_size)
 		return;
=20
-	if (bio_data_dir(bio) !=3D READ)
+	if (bio_op(bio) !=3D REQ_OP_READ)
 		goto exit;
=20
 	bio_for_each_segment(bv, bio, iter) {
--=20
2.20.1

