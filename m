Return-Path: <SRS0=yWXY=D3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA1BC433E7
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 08:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945CC222C8
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 08:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgE6JxV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbgJTIQi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Oct 2020 04:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388340AbgJTIQi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 04:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603181797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=+NDRN1egFUf+3Gupcs3ezBLr6XEOFAxaXme8LXJmSwc=;
        b=SgE6JxV51Ndc9kqauLvo/27EEtWRcxT8ujFcuDEGy6soPyTNG9V4y+bICsahud4I4t6Mh3
        nV63A8fFNAn/1LXdYb2pL+ZDcwjygWad1XUgrQ8trfqyAqPTGEW+jeorBn2jxjiyzSO6nv
        JlGjwmDBOoQ2n+QssLYYb/AUfyyRU5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-qVbfwBTpOpO_DoRrUsMNUw-1; Tue, 20 Oct 2020 04:16:35 -0400
X-MC-Unique: qVbfwBTpOpO_DoRrUsMNUw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3463C1006C8C;
        Tue, 20 Oct 2020 08:16:34 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (vm37-120.gsslab.pek2.redhat.com [10.72.37.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF0B15D9D2;
        Tue, 20 Oct 2020 08:16:31 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     nbd@other.debian.org, linux-block@vger.kernel.org,
        jdillama@redhat.com, mgolub@suse.de, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH 2/2] nbd: fix double lock for nbd->config_lock
Date:   Tue, 20 Oct 2020 04:16:15 -0400
Message-Id: <20201020081615.240305-3-xiubli@redhat.com>
In-Reply-To: <20201020081615.240305-1-xiubli@redhat.com>
References: <20201020081615.240305-1-xiubli@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

When NBD_CLEAR_SOCK with ioctl method, it will double lock the
config_lock.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 drivers/block/nbd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3d3f4255e495..b21abf134e34 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1358,9 +1358,7 @@ static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
 	sock_shutdown(nbd);
 	__invalidate_device(bdev, true);
 	nbd_bdev_reset(bdev);
-	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
-			       &nbd->config->runtime_flags))
-		nbd_config_put(nbd);
+	nbd_config_clear_rt_ref_and_put(nbd);
 }
 
 static bool nbd_is_valid_blksize(unsigned long blksize)
-- 
2.18.4

