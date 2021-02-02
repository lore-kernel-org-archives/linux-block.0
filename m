Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE38C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF3664EDE
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhBBFjQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:39:16 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:8116 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhBBFjJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244349; x=1643780349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3RBDbYn543ZOL7s6ZUD1kK+SJdSkbPKc01sGuIleXx0=;
  b=i1eCB+j5LVPDsABmYG5sKlR65dNuRjTkNk06sI0sk6YaY4DnxVwiavwF
   cijo1Hb5bD/8aMsqPPm/C3leqOx8oD+YarZQ6uSIug9jy4V5oKYiOQV3f
   9tlpo027toP6Sx/uTjKU2tHN0qKXsi6SZpn5gnJKQBz879iDmoRh8NEyL
   Q2btBrkR0K8H6T455sdpsIqRYRg4bRnI33eTw8g92o0ZNxDqDkAs3/C1m
   n9UAomzEQyEkjEQ1Xna3JnXUCMm2t+0gZGDlHhxsixnq/McXVjWujQMaB
   fXyIZsADuCD4/VKUsP8bEkCfiepL681lgX1Vu6qFBVQvfNy/Yp81E6WM+
   w==;
IronPort-SDR: hJHsq1DxKBtcfP2RC7bH113ob2zeNuNKl8nN8ptsWzGTLVlQBSZSiugDBVgHmPDnFc/+KkkWWf
 kPROHz2Pk/GxcMLQiA6ZDCwGCbBQ84SOPchhyZsaF3xXDU0V/cIh1wStFeMizSVxT2qg6aEQUv
 ssNuUhBZKvtsz1YlOgvBqHJGp5OW9CUcjEWx8vYMewXiTb/c/E1mPX1KatVu2pQ5Nvv9P8f8RP
 bGSUKtBZ6CRLHJmfwmAtu8wIPIX0stQzn5otDu93V0SvW3jszi6S0hKNn/4GiCIyuLzHxDIDoj
 D+s=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="160067286"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:38:20 +0800
IronPort-SDR: sVbGT3N3AxDFBH9jQA4MWoLvLaFpXyVs7WbpG/N93TqTnw6UHJaGH3NpDnZlbFGCF+8Prx10NM
 s+XlsGeEu1f9Z0wB1Ptj0oCpsE4jvO1e0/yHUKRY1sd48grlK4Z8Crku+rYwRtlkeMDmgYmw8s
 l65+LzJPkl/pIQCfRAHkezC5H1aaZVHI+5SRuq5TLyGFfS60VIinsaSgC2nUjwkHAB5EJp6jvu
 S/iuQedy+svrQhsPCFxVTcztfiQUAywU0oxpLBHmj0j3pYV3K+5Pu7i55Kmi0XS74NFCaIMCSu
 bKKxjN/yyXH2ZkP0uGEL2S+L
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:22:29 -0800
IronPort-SDR: 1i8xr1R2g4aEPYzFHu7lKcGcS8I3TgEajL/ed2c0JC6KeJ0mTpHktFUZEtGhLPpOraBlEmhvCs
 rhLPYuvIBMpJ6I9zVrMVlocTKDUGNlgx99CzzCxpgrTYwhITaDPSKuzns+ppSuijejM7u4NCzg
 QuSIFFdV+zko+zkheekYiNktT42QXi4dFpb4BQ2HBqM+RQ4CFWPJtw3Qwh8nz9TWV6QB8zoqJW
 5cY0mSN758Wj/UZ95S6YTq7dnlaJMCXDG2uLJLKwk4dtAxxUtq5raNNbFNE7BpfeZjbGH8Ere9
 xXQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:38:20 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 18/20] loop: configure set err at actual error condition
Date:   Mon,  1 Feb 2021 21:35:50 -0800
Message-Id: <20210202053552.4844-19-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function loop_configure() set error = -EBADF before calling fget(),
error = -EBUSY before checking the state. None of these error values are
reused for the above conditions.

Conditionally set the error after we actually know that error condition
is true instead of setting it before the if check.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 89f9c73bb2af..d99ae348e4e2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1076,10 +1076,11 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
 
-	error = -EBADF;
 	file = fget(config->fd);
-	if (!file)
+	if (!file) {
+		error = -EBADF;
 		goto out;
+	}
 
 	/*
 	 * If we don't hold exclusive handle for the device, upgrade to it
@@ -1095,9 +1096,10 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	if (error)
 		goto out_bdev;
 
-	error = -EBUSY;
-	if (lo->lo_state != Lo_unbound)
+	if (lo->lo_state != Lo_unbound) {
+		error = -EBUSY;
 		goto out_unlock;
+	}
 
 	error = loop_validate_file(file, bdev);
 	if (error)
-- 
2.22.1

