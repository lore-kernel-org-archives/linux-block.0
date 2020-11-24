Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5513C2D0E4
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 01:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88DDB2073C
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 01:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNCilkFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725308AbgKXBFB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Nov 2020 20:05:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54283 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728149AbgKXBFA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 20:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606179900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TXFfxOeYIvUbAbfjUJzMCqc9JxfDv2qeYc14F4EoUAs=;
        b=jNCilkFLrGHgO2EDmLQb0LL2/d2I8Vcf8DwrqhssiLHnK7BsAXYsUQ80xkV3sDhh6Ktj2M
        X4+aKsZX6M5kFGgyWGIeEM7cJdAqIwpjO/UqHpc5H4dcYy8gqZhQVWLxG8anx8GUjvWQ+Z
        MUa63y3B8TyizhPh3+p0s34Kt6tO7e8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-krNF9nNgO6euzu4gblZpXg-1; Mon, 23 Nov 2020 20:04:57 -0500
X-MC-Unique: krNF9nNgO6euzu4gblZpXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B285B18C43C8;
        Tue, 24 Nov 2020 01:04:56 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC2B56062F;
        Tue, 24 Nov 2020 01:04:54 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@osandov.com, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
Subject: [PATCH blktests 2/5] tests/nvmeof-mp/rc: run nvmeof-mp tests if we set multipath=N
Date:   Tue, 24 Nov 2020 09:04:24 +0800
Message-Id: <20201124010427.18595-3-yi.zhang@redhat.com>
In-Reply-To: <20201124010427.18595-1-yi.zhang@redhat.com>
References: <20201124010427.18595-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To enable it, just do bellow step before we run it:
$ echo "options nvme_core multipath=N" >/etc/modprobe.d/nvme.conf

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvmeof-mp/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index d7a7c87..bc78f14 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -17,7 +17,7 @@ group_requires() {
 	# Since the nvmeof-mp tests are based on the dm-mpath driver, these
 	# tests are incompatible with the NVME_MULTIPATH kernel configuration
 	# option.
-	if _have_kernel_option NVME_MULTIPATH; then
+	if _have_kernel_option NVME_MULTIPATH && _have_module_param_value nvme_core multipath Y; then
 		SKIP_REASON="CONFIG_NVME_MULTIPATH has been set in .config"
 		return
 	fi
-- 
2.21.0

