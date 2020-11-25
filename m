Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B1BC6379D
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 07:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06F320857
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 07:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggYwHH6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgKYHcl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 02:32:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28066 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727219AbgKYHck (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 02:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606289559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h27fAXdGuV6wrMdtw8W1ctw5U/mIM8/bS3+3KYoWkS4=;
        b=ggYwHH6tT89mT6gp3bgigFaSNVz1qks0xsCyqWIkxC0lcBxzlZfDG4XF7oU2FJLt/44edT
        K5of8dGiBBftrR5IrAw7ky2vp1RIZnr8/rnC2JYTbLhR+WR21E/kNM9iASLk9ala6SsKCr
        zSgwsvpDKgFLk7cawzKytikIf+YskeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-X_2anpEKPm-jCkno9Sk0Gg-1; Wed, 25 Nov 2020 02:32:35 -0500
X-MC-Unique: X_2anpEKPm-jCkno9Sk0Gg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14A2D809DE0;
        Wed, 25 Nov 2020 07:32:34 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AB3519C46;
        Wed, 25 Nov 2020 07:32:31 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@osandov.com, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
Subject: [PATCH V2 blktests 2/5] tests/nvmeof-mp/rc: run nvmeof-mp tests if we set multipath=N
Date:   Wed, 25 Nov 2020 15:32:02 +0800
Message-Id: <20201125073205.8788-3-yi.zhang@redhat.com>
In-Reply-To: <20201125073205.8788-1-yi.zhang@redhat.com>
References: <20201125073205.8788-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To enable it, just do bellow step before we run it:
$ echo "options nvme_core multipath=N" >/etc/modprobe.d/nvme.conf

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvmeof-mp/rc | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index d7a7c87..fc06856 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -16,9 +16,11 @@ group_requires() {
 
 	# Since the nvmeof-mp tests are based on the dm-mpath driver, these
 	# tests are incompatible with the NVME_MULTIPATH kernel configuration
-	# option.
-	if _have_kernel_option NVME_MULTIPATH; then
-		SKIP_REASON="CONFIG_NVME_MULTIPATH has been set in .config"
+	# option with multipathing enabled in the nvme_core kernel module.
+	if _have_kernel_option NVME_MULTIPATH && \
+		_have_module_param_value nvme_core multipath Y; then
+		SKIP_REASON="CONFIG_NVME_MULTIPATH has been set in .config \
+	and multipathing has been enabled in the nvme_core kernel module"
 		return
 	fi
 
-- 
2.21.0

