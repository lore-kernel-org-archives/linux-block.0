Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EEBC433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9616054F
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhJYJt3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 05:49:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30788 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232755AbhJYJr3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 05:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635155106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EyFirPMayDHzwLGGiRTyeQ0weH3h+eslLCxAu78O9JI=;
        b=AmGg/ijE/L2vBOui5CnHpCUP3WdeVeGzVDSui+gZfsqAEm3hN5QcakY9j8GsuHYc0NZelq
        FTPPbSAj8L5ENjKfH4LlFCs967xQQqMQaXQ+E4UwcCThVfTdF50t+9o7m+yl7IbGCVeOsx
        Rfl/oi4l0NWPNAb4ACLAOwVietYCJhk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-y2xOzSXzMlKNpppbwYCI-w-1; Mon, 25 Oct 2021 05:45:05 -0400
X-MC-Unique: y2xOzSXzMlKNpppbwYCI-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74646814263;
        Mon, 25 Oct 2021 09:44:49 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A436A1948C;
        Mon, 25 Oct 2021 09:44:48 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/8] loop: move flush_dcache_page to ->complete of request
Date:   Mon, 25 Oct 2021 17:44:30 +0800
Message-Id: <20211025094437.2837701-2-ming.lei@redhat.com>
In-Reply-To: <20211025094437.2837701-1-ming.lei@redhat.com>
References: <20211025094437.2837701-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for unifying backing buffered IO code, so move
flush_dcache_page() into ->complete() of read request.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7bf4686af774..8f140d637435 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -405,8 +405,6 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
 		if (len < 0)
 			return len;
 
-		flush_dcache_page(bvec.bv_page);
-
 		if (len != bvec.bv_len) {
 			struct bio *bio;
 
@@ -507,11 +505,24 @@ static int lo_req_flush(struct loop_device *lo, struct request *rq)
 	return ret;
 }
 
+static void lo_flush_dcache_for_read(struct request *rq)
+{
+	struct bio_vec bvec;
+	struct req_iterator iter;
+
+	rq_for_each_segment(bvec, rq, iter)
+		flush_dcache_page(bvec.bv_page);
+}
+
 static void lo_complete_rq(struct request *rq)
 {
 	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
 	blk_status_t ret = BLK_STS_OK;
 
+	/* Kernel wrote to our pages, call flush_dcache_page */
+	if (req_op(rq) == REQ_OP_READ && !cmd->use_aio && cmd->ret >= 0)
+		lo_flush_dcache_for_read(rq);
+
 	if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
 	    req_op(rq) != REQ_OP_READ) {
 		if (cmd->ret < 0)
-- 
2.31.1

