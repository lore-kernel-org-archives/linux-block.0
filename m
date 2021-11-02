Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4512EC433EF
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 15:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F08660F58
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 15:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhKBPjW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:39:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231920AbhKBPjV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Nov 2021 11:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635867405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Qdb0D3NXhHj3HQ68vUrigdROAaKGkDa24aCwKPMpms=;
        b=bASrz2gbtE6wwausHSWhxFc3beiDsP5q8T/jJMY9X0Bua9feCj7zjEpEiUx+ODNgx9VHsP
        dHr5qyAdjylNn2Jeh6cY83ht66roNwph9J3L3SmUxrk51tM+IzNCkaVDy8oFqP6ghcY2mH
        uuHfUxTzXd+wTWTS3m1NiQrLiTvI6eQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-e9faGxsqMuyxa0Lv1IsATw-1; Tue, 02 Nov 2021 11:36:42 -0400
X-MC-Unique: e9faGxsqMuyxa0Lv1IsATw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2705100D689;
        Tue,  2 Nov 2021 15:36:41 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 529635BAE3;
        Tue,  2 Nov 2021 15:36:37 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/3] blk-mq: add RQF_ELV debug entry
Date:   Tue,  2 Nov 2021 23:36:18 +0800
Message-Id: <20211102153619.3627505-3-ming.lei@redhat.com>
In-Reply-To: <20211102153619.3627505-1-ming.lei@redhat.com>
References: <20211102153619.3627505-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks it is missed so add it.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index f5076c173477..4f2cf8399f3d 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -308,6 +308,7 @@ static const char *const rqf_name[] = {
 	RQF_NAME(SPECIAL_PAYLOAD),
 	RQF_NAME(ZONE_WRITE_LOCKED),
 	RQF_NAME(MQ_POLL_SLEPT),
+	RQF_NAME(ELV),
 };
 #undef RQF_NAME
 
-- 
2.31.1

