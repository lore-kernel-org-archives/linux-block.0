Return-Path: <SRS0=cbU1=EJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27303C2D0A3
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 06:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD1E52227F
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 06:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFLvq0SX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgKCGwU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Nov 2020 01:52:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727770AbgKCGwU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Nov 2020 01:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604386338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=lhC4UEZxNtoCxbWx27q2JVPsdwNAlzcW9YBk2FW9WZE=;
        b=HFLvq0SXGQxLb80P0MkpF9QGwAFGz343LNhJUZRtZqZcdbSHRr2wYRqKI3ienVTwHhlwtz
        erUYJQSf1Gu75t68S0mUrULgI+VEMDknygKSWcfvAkR0M1MD7QDBnUxlc55WwEjUkTuUjE
        r3HnU9vDLebxrNnx+lSHe0Giw676Uic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-B3Ss80omNwWdBbOgivJ_Bg-1; Tue, 03 Nov 2020 01:52:17 -0500
X-MC-Unique: B3Ss80omNwWdBbOgivJ_Bg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA85E1084D64;
        Tue,  3 Nov 2020 06:52:15 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (vm37-120.gsslab.pek2.redhat.com [10.72.37.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 463AB5D9DD;
        Tue,  3 Nov 2020 06:52:10 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk, ming.lei@redhat.com
Cc:     nbd@other.debian.org, linux-block@vger.kernel.org,
        jdillama@redhat.com, mgolub@suse.de, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v3 2/2] nbd: add comments about double lock for config_lock confusion
Date:   Tue,  3 Nov 2020 01:51:56 -0500
Message-Id: <20201103065156.342756-3-xiubli@redhat.com>
In-Reply-To: <20201103065156.342756-1-xiubli@redhat.com>
References: <20201103065156.342756-1-xiubli@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 drivers/block/nbd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index e4c37677f3df..55466534cde6 100644
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

