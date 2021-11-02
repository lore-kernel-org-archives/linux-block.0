Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFB7C433F5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 13:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76AC5610E5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 13:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhKBNjG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 09:39:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229530AbhKBNjE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Nov 2021 09:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635860189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Qdb0D3NXhHj3HQ68vUrigdROAaKGkDa24aCwKPMpms=;
        b=Ymzx+EZFWThs8Jym0JxCp4u451sfa5dESmb37CwLHKiOL8dKkUJbuoo74GWPCipdaiAyoL
        sLKjNUBC6ZI/7R8C3btF2ftdjHwL0YkDJaqcyMbvI++GQ3rZQayi083enQrD4o+gN5Sv5t
        zgZXQ1NT1XKdlYAa5A6qXAD5R5SY9l8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-ykIYuwBGNDyEKegw17R84A-1; Tue, 02 Nov 2021 09:36:26 -0400
X-MC-Unique: ykIYuwBGNDyEKegw17R84A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A57F580A5C4;
        Tue,  2 Nov 2021 13:36:25 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8AD06A905;
        Tue,  2 Nov 2021 13:36:24 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/3] blk-mq: add RQF_ELV debug entry
Date:   Tue,  2 Nov 2021 21:35:01 +0800
Message-Id: <20211102133502.3619184-3-ming.lei@redhat.com>
In-Reply-To: <20211102133502.3619184-1-ming.lei@redhat.com>
References: <20211102133502.3619184-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

