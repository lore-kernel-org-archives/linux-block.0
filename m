Return-Path: <SRS0=i0oD=EB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1A6C2D0A3
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 16:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B380322404
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 16:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HosoySqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784911AbgJZQFW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Oct 2020 12:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1784902AbgJZQFV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Oct 2020 12:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603728319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=q/E5giN4xsgMxXjTZFdev6gu+e6AnHn6XMpyLORpD5M=;
        b=HosoySqcJsWuTLNLEqJNhBZAZ0YtrnC1WgfSuUi5x1T20P+oerZKjEyqvnpfkOXOYtoE4G
        9bC+Be5Yx3euYQPEwrvNNz/I9SKql1LriMY4UNELN1PQd/nGu2EV3XDp5NRrp7QP7lEPlB
        093/isoAZn5B04kBfrU4ZcS24ZYIXcU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-EEeJnoIoOfCC7NgIavbLYQ-1; Mon, 26 Oct 2020 12:05:17 -0400
X-MC-Unique: EEeJnoIoOfCC7NgIavbLYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EFA5EC500;
        Mon, 26 Oct 2020 16:05:16 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-112-242.rdu2.redhat.com [10.10.112.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1566A5C1BB;
        Mon, 26 Oct 2020 16:05:15 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] print_req_error: Use dev_err_ratelimited
Date:   Mon, 26 Oct 2020 11:05:15 -0500
Message-Id: <20201026160515.542586-1-tasleson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace printk_ratelimited with dev_err_ratelimited which
adds dev_printk meta data. This is used by journald to
add disk ID information to the journal entry.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 block/blk-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 10c08ac50697..ee5d63e54a11 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -216,16 +216,18 @@ EXPORT_SYMBOL_GPL(blk_status_to_errno);
 static void print_req_error(struct request *req, blk_status_t status,
 		const char *caller)
 {
+	struct device *dev;
 	int idx = (__force int)status;
 
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
 		return;
 
-	printk_ratelimited(KERN_ERR
-		"%s: %s error, dev %s, sector %llu op 0x%x:(%s) flags 0x%x "
+	dev = req->rq_disk ? disk_to_dev(req->rq_disk) : NULL;
+
+	dev_err_ratelimited(dev,
+		"%s: %s error, sector %llu op 0x%x:(%s) flags 0x%x "
 		"phys_seg %u prio class %u\n",
 		caller, blk_errors[idx].name,
-		req->rq_disk ? req->rq_disk->disk_name : "?",
 		blk_rq_pos(req), req_op(req), blk_op_str(req_op(req)),
 		req->cmd_flags & ~REQ_OP_MASK,
 		req->nr_phys_segments,

base-commit: bbf5c979011a099af5dc76498918ed7df445635b
-- 
2.26.2

