Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19073C433E3
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 16:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D6420719
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 16:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juLbmz0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgG0QVB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgG0QVA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 12:21:00 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEBCC061794;
        Mon, 27 Jul 2020 09:21:00 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l64so8967284qkb.8;
        Mon, 27 Jul 2020 09:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aSoHQvLtd5ehDIvkD8A1Zun/yggItMDxrrpLUadcTAw=;
        b=juLbmz0+JADoY8hY7mPFfnPgqKsiLXa0/ZgsIsQPxwvBK+1zwoDSgnIwXFJhYAR+gC
         DJHq2rzYTmyPErBh5QLZHYnbsZpKTjOogHny+MBb3CWI982UcI2cTMaYevepp+WCpbwX
         bbAzsBezBxuV4ay8eJK8XSkYU8EHHTI4hAdStJF8ke/Zl75p5VXt0/uIfeltJCK+1PvZ
         f2rv+5YAtO+RdeduZ7zZASG2RVdhv1kO4ZJFOmBQzOinPd15qZz+mW/p/SJjkd1R7cJO
         buFIg6mybDExlZ2tynfPs7QG33RdRIEFrs3ZQzsV5mOJ8lP4u9OhypU8LVxSduhBipAC
         YFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aSoHQvLtd5ehDIvkD8A1Zun/yggItMDxrrpLUadcTAw=;
        b=EfeeER53SGYmgzVo2juW2p18oYNL7kHTJ2Uj9HTtaZMBX19pfrPTbjgSpSqpvH8nif
         uXdHtuFMm5Bx65huyRT4vSdsVR/cYC5XnCjbtGPtgsKDlI1GRwsNkQ5949jH8qTVNA3z
         UbxNI0w1rEuQ/ZfuA3A7G8qgIbQPh97bZGP0YevaNaFIQsCXIBLjevrI4eHYo/ZOHivs
         OSM5Ylh3bH+5jvEPjTrCyQ20CVBELwdzP+owvkt4hhyvolfem0iGPTv82UABdSXj4fkp
         vKLcx0Zf/ez0hYxs9CSLBszi+LNCkQrUKU9wwbYRoxq1RYBl6RL3QLY1fFSX1pQoj8g2
         CyaA==
X-Gm-Message-State: AOAM5314Wn+dGmfVumzFnoQK7DAwZI6rb+q3+gnyHVYppV0/gEEegIKi
        Mq7NP9YL1qWBTBnufPuokA==
X-Google-Smtp-Source: ABdhPJymMFQ2ThC0j3BgCcKt/GLFsB37J7SQMX+TN/oVIkqpTBpZ57IPOEMMqcpXXWsqB/0S9Ax25g==
X-Received: by 2002:a37:ad0a:: with SMTP id f10mr16945474qkm.154.1595866859791;
        Mon, 27 Jul 2020 09:20:59 -0700 (PDT)
Received: from localhost.localdomain ([209.94.141.207])
        by smtp.gmail.com with ESMTPSA id b186sm19081811qkd.28.2020.07.27.09.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 09:20:59 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH] block/scsi-ioctl: Prevent kernel-infoleak in scsi_put_cdrom_generic_arg()
Date:   Mon, 27 Jul 2020 12:19:32 -0400
Message-Id: <20200727161932.322955-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

scsi_put_cdrom_generic_arg() is copying uninitialized stack memory to
userspace due to the compiler not initializing holes in statically
allocated structures. Fix it by initializing `cgc32` using memset().

Cc: stable@vger.kernel.org
Fixes: f3ee6e63a9df ("compat_ioctl: move CDROM_SEND_PACKET handling into scsi")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 block/scsi_ioctl.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index ef722f04f88a..1b7f85634751 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -692,16 +692,19 @@ static int scsi_put_cdrom_generic_arg(const struct cdrom_generic_command *cgc,
 {
 #ifdef CONFIG_COMPAT
 	if (in_compat_syscall()) {
-		struct compat_cdrom_generic_command cgc32 = {
-			.buffer		= (uintptr_t)(cgc->buffer),
-			.buflen		= cgc->buflen,
-			.stat		= cgc->stat,
-			.sense		= (uintptr_t)(cgc->sense),
-			.data_direction	= cgc->data_direction,
-			.quiet		= cgc->quiet,
-			.timeout	= cgc->timeout,
-			.reserved[0]	= (uintptr_t)(cgc->reserved[0]),
-		};
+		struct compat_cdrom_generic_command cgc32;
+
+		memset(&cgc32, 0, sizeof(cgc32));
+
+		cgc32.buffer	= (uintptr_t)(cgc->buffer);
+		cgc32.buflen	= cgc->buflen;
+		cgc32.stat	= cgc->stat;
+		cgc32.sense	= (uintptr_t)(cgc->sense);
+		cgc32.data_direction	= cgc->data_direction;
+		cgc32.quiet	= cgc->quiet;
+		cgc32.timeout	= cgc->timeout;
+		cgc32.reserved[0]	= (uintptr_t)(cgc->reserved[0]);
+
 		memcpy(&cgc32.cmd, &cgc->cmd, CDROM_PACKET_SIZE);
 
 		if (copy_to_user(arg, &cgc32, sizeof(cgc32)))
-- 
2.25.1

