Return-Path: <SRS0=cbU1=EJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49892C4742C
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 03:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E42892227F
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 03:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwQ/LxJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgKCDI1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Nov 2020 22:08:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35997 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbgKCDI1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Nov 2020 22:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604372906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=7d8NLKQ39hOXdWATpr3kMEgdUtKNQ0LPQV//tVnVdDw=;
        b=HwQ/LxJlxA0CNM001VCic11yFVLSYFp871ffOgYYbAJvmmQiCaL7L+jNS+YY6ZSGnnehbJ
        TMZ0LHCY0h8QzWp3TQcuYM/eW00WdiZFZz3Vt14w4p1Dw49Jy9RVVebWVCf0TZZR6mNjby
        vKZkZNh4rAdI+1jNpSVX23KKUSiVoVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-D1O5DemgO5eH4TqFoRx-9A-1; Mon, 02 Nov 2020 22:08:24 -0500
X-MC-Unique: D1O5DemgO5eH4TqFoRx-9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1320B1868406;
        Tue,  3 Nov 2020 03:08:23 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (vm37-120.gsslab.pek2.redhat.com [10.72.37.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 738BA5576E;
        Tue,  3 Nov 2020 03:08:20 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk, ming.lei@redhat.com
Cc:     nbd@other.debian.org, linux-block@vger.kernel.org,
        jdillama@redhat.com, mgolub@suse.de, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v2 2/2] nbd: add comments about double lock for config_lock confusion
Date:   Mon,  2 Nov 2020 22:07:58 -0500
Message-Id: <20201103030758.317781-3-xiubli@redhat.com>
In-Reply-To: <20201103030758.317781-1-xiubli@redhat.com>
References: <20201103030758.317781-1-xiubli@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

When calling the ioctl(), fget() will be called on this fd, and
nbd_release() is only called when the fd's refcount drops to zero.
With this we can make sure that the nbd_release() won't be called
before the ioctl() finished.

So there won't have the double lock issue for the "config_lock",
which has already been held by nbd_ioctl().

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 drivers/block/nbd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3bb8281bb753..48f36b003bf5 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1345,6 +1345,17 @@ static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
 	sock_shutdown(nbd);
 	__invalidate_device(bdev, true);
 	nbd_bdev_reset(bdev);
+
+	/*
+	 * When calling the ioctl(), fget() will be called on this
+	 * fd, and nbd_release() is only called when the fd's refcount
+	 * drops to zero. With this we can make sure that the
+	 * nbd_release() won't be called before the ioctl() finished.
+	 *
+	 * So there won't have the double lock issue if it will
+	 * call the nbd_config_put() here for the "config_lock", which
+	 * has already been held by nbd_ioctl().
+	 */
 	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
 			       &nbd->config->runtime_flags))
 		nbd_config_put(nbd);
-- 
2.18.4

