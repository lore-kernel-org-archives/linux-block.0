Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771D7C433E6
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B2B164EDC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhBBFij (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:38:39 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:57154 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhBBFig (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244376; x=1643780376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ca4BtS6m9c3hxquO+nIemXua1oS2Hi6c1Fi0pcfSFNQ=;
  b=cXgxoEyLKWMN9xtHB0xRdBKGDRiGFpa0qCbcQJTUHljVKUU3gbhsVbHp
   MU01EKMtY5DsmT/dQ56SRHtmr82C5PI+TVLbWMWqIPp/eQ5k1gICtywQP
   lwPV2O5gdEL/BtGdbw7XrcgJmXoHPmaJGZ2pBcl+ADlD/GeaQc6V/Z/CO
   YaJ2ExVuPg5k2vnfvBnWd+p5oNwmQP4irRftXEC21d6MPK22nrrVadFS3
   1/OgEV76QeE4hD/jumrfjGGmheA+tkD8JfeOye5oEClLQla81a55oDeSl
   99KpvSz5FFm5R62m3A3Wsit85Max9wUBG+/vr//GFNgItIJVB1P6oX/gW
   Q==;
IronPort-SDR: G4QAA02N2NVedITNwiYb9Wl5kPDtzQJgIorPZh+DcWaNe174J5aMQysrWtKX8Xb2NUdnRJvEhQ
 UBZdn9UBB7KVr/sOqryIsxrulwhylgVeUSiGZ1J6SDstHRXschvjSHCPd8djdJ8aBScWeBbI52
 PaXoYxWeMI5OlPwtfxzcX/vQ6M45gGZ77wPSthj8P2P8wyrmz98pT4HT9ugj6Jn1mbWcFLRIKf
 AGXJcIcI0S/mDc+Eoivw4rO22VxhHdeQ9pnsIM3+DtS1wJP+1GWwNGn2lAp1v9ARK0EAlyAre6
 WRo=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="262961968"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:37:57 +0800
IronPort-SDR: YxNqbQoaIXCXCV5G8X4AXIEtIyKCGURwV7veYVbs9A/vxTN9d+VBLScGwehjswH3OJ4wMAXQYW
 ugFMHMnVtvUhUkpO+Wpw3Sav6M5IWrhWgKEGVHiYz3czkuI3455puTlzMXE1NA9V6CMOf1SXiy
 CjL+ZVSyKkdUQ/vyokRFHpWtgGwI2Lo3k8rTmqafQNkITDE01lymh67SjH4G4RVH7V/4zQ9oKU
 QfKbYOdwaMPWNxKu1KdxIP5RvinuFp9a7L3xSMcHzAgxu1HEeVONcnOP2GImlECjwR5wXoUANJ
 OXbf/4AcchwoBtzvC3Ilq+D0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:19:38 -0800
IronPort-SDR: tjijzQnVTCpda5knOfgUMlI3nOnqdIWXqmNywZ9AmjC8s6ZbnVEjKbRxrXllsd++joWDCYoyRx
 r2TpgtHbd4VJLGNmvWCQB9df4LwzTQoRj27KH8TJDtJYSlPKz4Fsf6AX2lnxbrKfeK9NJG1F2F
 gig9fXf48Bc391ZNRFSRocrSguJTAUBVkxcWSMNsDipQpk2IYAyou2xjFjBf9BYGlEOXgJClgs
 uweSJPw7tnM4dACWskhwYUyWtL5vhaGQl5v8A1taGGO/cfg0LTuiNMd2ObIYv2S0vvMOSiFCQG
 EWg=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:37:29 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 12/20] loop: cleanup lo_ioctl()
Date:   Mon,  1 Feb 2021 21:35:44 -0800
Message-Id: <20210202053552.4844-13-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of storing the return values into the err variable just return
the err from switch cases, since we don't do anything after switch with
that error but return. This also removes the need for the local
variable err in lo_ioctl(). Instead of declaring config variable twice
in the set_fd and configire switch cases declare and initialize the loop
config variabel that removes the need for memset. Also, move status64
switch case near to set status case.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 38 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d9cd0ac3d947..bc074ad00eaf 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1660,48 +1660,35 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
 {
 	struct loop_device *lo = bdev->bd_disk->private_data;
 	void __user *argp = (void __user *) arg;
-	int err;
+	struct loop_config config = { };
 
 	switch (cmd) {
-	case LOOP_SET_FD: {
+	case LOOP_SET_FD:
 		/*
 		 * Legacy case - pass in a zeroed out struct loop_config with
 		 * only the file descriptor set , which corresponds with the
 		 * default parameters we'd have used otherwise.
 		 */
-		struct loop_config config;
-
-		memset(&config, 0, sizeof(config));
 		config.fd = arg;
-
 		return loop_configure(lo, mode, bdev, &config);
-	}
-	case LOOP_CONFIGURE: {
-		struct loop_config config;
-
+	case LOOP_CONFIGURE:
 		if (copy_from_user(&config, argp, sizeof(config)))
 			return -EFAULT;
-
 		return loop_configure(lo, mode, bdev, &config);
-	}
 	case LOOP_CHANGE_FD:
 		return loop_change_fd(lo, bdev, arg);
 	case LOOP_CLR_FD:
 		return loop_clr_fd(lo);
 	case LOOP_SET_STATUS:
-		err = -EPERM;
-		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
-			err = loop_set_status_old(lo, argp);
-		}
-		break;
+		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
+			return loop_set_status_old(lo, argp);
+		return -EPERM;
+	case LOOP_SET_STATUS64:
+		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
+			return loop_set_status64(lo, argp);
+		return -EPERM;
 	case LOOP_GET_STATUS:
 		return loop_get_status_old(lo, argp);
-	case LOOP_SET_STATUS64:
-		err = -EPERM;
-		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
-			err = loop_set_status64(lo, argp);
-		}
-		break;
 	case LOOP_GET_STATUS64:
 		return loop_get_status64(lo, argp);
 	case LOOP_SET_CAPACITY:
@@ -1711,11 +1698,8 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
 			return -EPERM;
 		fallthrough;
 	default:
-		err = lo_simple_ioctl(lo, cmd, arg);
-		break;
+		return lo_simple_ioctl(lo, cmd, arg);
 	}
-
-	return err;
 }
 
 #ifdef CONFIG_COMPAT
-- 
2.22.1

