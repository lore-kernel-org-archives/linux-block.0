Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E02C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4628320866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Jj8YYblF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfEAEds (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:33:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63464 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfEAEds (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685229; x=1588221229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kRppu7CzSdqlkfpjN8o9Q3i+LO99pJ88s3K2xdIAM8o=;
  b=Jj8YYblF3d/9fD0tddnWz/ec8vcKxJYN7J57bKlfy/5m2eWsiI8WZX+Q
   C57BQfLlNHYv4FcfiWL+Fk+GmwPXVi9u/bEGdtf5vnuml9uJKg84APzUj
   Cye4o49KEBmFzuZoDRZvmUsSAB7CXgDBxDWd18zwMK5owYaDsj3cy7dVM
   0Zqxef8yJ7h8U99FLSmF17ecFyTtNebYTwxU8+RHZ/Rav7lrRXDW2E8Rg
   RvM/yCzG9SuEaXXpdHALNMrCFU3ED+zLmGyZ+DLwgCwtYvIBbxFUQ4imm
   mvnq5OgmiZO/9zmvlwKXGrk1PSEuzPtdJu4PCgsIRzWE31hihMYm9OVIH
   w==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="107229740"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:33:49 +0800
IronPort-SDR: gNBhH/ayMf4VVghMQJPxm0cDEhXTYfU4z1Fs38wz+BBc8x7IetjkmhZJTgRFgArsDvM7UXGBCn
 EPYODEhX7cfS1gyislJkVvLbsf509dSTvlzKY7CeXGdfiM2oM+mooWvFKHAZhLK/LJo9vtMNHb
 RYMHG9ktWmFTB7m/6CG1C+vHl3z/0rtmzWzSMSi8MI4eIgv1BYr2DxbX8QnHS5iDjSd6aqokeB
 7K+qY2lOVxR5r5DhZpsjtFdienJibXe15KOTrc6fMVE1uN0zs9FOCMF6DgBDWsB/GE+USvH19o
 uv1RgEwH9vofgt+5I6aZuiTQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:12:17 -0700
IronPort-SDR: 5noH9955gFs6/YkQHMiA5KjzM+RH1NO2vE2zGuG3QKrU5kOJ3i6HdSj4YVTVw0bEott8vdo9uV
 aR024As1EZFWZ2ucDg4PVZa2nrLx12AaekKb6TIKS1Hgl3A12ygVHokF2mCrFZ5a16dyawnhbz
 3SoGdW+C4aW4g8TxjuOGq2FIoMhkhDHxUeNSbJPzQ4Uoq2jfMCtRCvwTg/vRRnuCtEdx2MUI2G
 ywS4ZsmH+2LP8mA7OmbuTa2K0IHxHsEWyZ5d9lAWEpaL6w9cY9iNkHAju0ajYJh+tOXyAXiu4+
 1Z0=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:33:49 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH blktrace-tools 10/10] blktrace-tools: add extension support
Date:   Tue, 30 Apr 2019 21:33:17 -0700
Message-Id: <20190501043317.5507-11-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
References: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 5917814..d784b64 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,7 @@
 CC	= gcc
 CFLAGS	= -Wall -O2 -g -W
-ALL_CFLAGS = $(CFLAGS) -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64
+ALL_CFLAGS = $(CFLAGS) -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 \
+	     -DCONFIG_BLKTRACE_EXT
 PROGS	= blkparse blktrace verify_blkparse blkrawverify blkiomon
 LIBS	= -lpthread
 SCRIPTS	= btrace
-- 
2.19.1

