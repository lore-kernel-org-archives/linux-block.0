Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81A7C433FE
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 08:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB73061106
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 08:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhJZIZy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 04:25:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233897AbhJZIZx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 04:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635236609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+oz6iMexA5HW9aZZnRgNBDgftbDjl783CHggO8Dnsec=;
        b=iFJ+GHHxYOoR6MDLnOCSKyXw22BjyRdod8JFqie0xBa/bL2kZMRvV/2P66Z4ixjLm6a68/
        Hdv7QHW52SD7QnPRXhwIngbh4bIDjMBvsWqQrLDahTMgJQSXSE63IZvmvO98XiXuf2TC0h
        QhBim4AUaGfwgPptLeBfOo/uppHBjSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-JpNAk9SaMSiM0Lhi8MKc9Q-1; Tue, 26 Oct 2021 04:23:27 -0400
X-MC-Unique: JpNAk9SaMSiM0Lhi8MKc9Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC4F2806694;
        Tue, 26 Oct 2021 08:23:26 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01A145DF21;
        Tue, 26 Oct 2021 08:23:13 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] blk-mq: don't issue request directly in case that current is to be blocked
Date:   Tue, 26 Oct 2021 16:22:57 +0800
Message-Id: <20211026082257.2889890-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When flushing plug list in case that current will be blocked, we can't
issue request directly because ->queue_rq() may sleep, otherwise scheduler
may complain.

Fixes: dc5fc361d891 ("block: attempt direct issue of plug list")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c19dfa8ea65e..9840b15f505b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2223,7 +2223,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		return;
 	plug->rq_count = 0;
 
-	if (!plug->multiple_queues && !plug->has_elevator) {
+	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
 		blk_mq_plug_issue_direct(plug, from_schedule);
 		if (rq_list_empty(plug->mq_list))
 			return;
-- 
2.31.1

