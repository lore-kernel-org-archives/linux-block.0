Return-Path: <SRS0=s4v/=QY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97446C43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Feb 2019 20:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67059218A1
	for <linux-block@archiver.kernel.org>; Sun, 17 Feb 2019 20:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1ATFxIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfBQUV5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Feb 2019 15:21:57 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36137 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfBQUV5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Feb 2019 15:21:57 -0500
Received: by mail-it1-f196.google.com with SMTP id h6so35174867itl.1;
        Sun, 17 Feb 2019 12:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k+Mv8dhA1bSLIbpGntzlrAGUf/L6WQgCFDF+3/GenKw=;
        b=Y1ATFxIFR27UulM6IG5bbF9Cwqq+Pd9/Vsuwwu0lxixEZwZMTgRbgiVT5uryB9YYR5
         0CI0C5oGQkZAI3+Y9TqaFCr6AhlEC8j3mp89uNO0MVvub4ttrj8xmdGP2yTX6EGO4McW
         xxppn72HmxPxJZ8oB/Sf3xtCNgOJX8bguP2y65O0D/87QufABe+xbQC5ctgMnp+LTnN+
         NNn/u0kLXFKfdUj0SYMf2TwqrOKO3UFKYUxwvsbovqFj1QP+tOETzuFhNjSx9INLbGLE
         43F1rhChyP5wEkZqINUdSz2/Y05TE3iz2lClFTiywz0OI9+gwD6L3Vi3rSd1CmkICuQb
         r9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k+Mv8dhA1bSLIbpGntzlrAGUf/L6WQgCFDF+3/GenKw=;
        b=hcrfWqiWnn2dam11RPowH4qCvQ5qcPIOtmmFdD3V6Eq4QnQpl2yfD0/35/DAlcxyRF
         Hk6eMWSzOfwX60+fSCFb/6PKutIlCPQidN2VZGB8IHlrAvu8E37TPMaCA6LBf+nx3Q7D
         lFeJ7yQeSLAcD80j3od5p39rmhsoRZFdWEDkg7w6cTLlKPPIvKm1ueryq9iNIpkhXMrK
         zwigv4NPkccwGPsXtBJ/8xQ+GbfJA67lyhaq0dv59ipU9Pd6apUznXmKUl0BdV+Mh5tZ
         KsZc9CU5o1dzKm5MUfuuRue0IxOmwauefjp4W7t9Um52TXXrRfjZS8maQPCXyr30Y7/B
         kO8A==
X-Gm-Message-State: AHQUAubSLX60rDLvGy/w3jANgfiQ6E+PWuw4PUZhiMnF7Moiw2ssm07V
        TRYp6qmV4FeENcqKpk7GTw==
X-Google-Smtp-Source: AHgI3IZTlYeCOwJkOmVIrQQ+o2x6eh6S21O2SdMtxaA4K4qRX20NQNeAWvr+Xj5h+f07gwVGLURtCw==
X-Received: by 2002:a05:660c:2c4:: with SMTP id j4mr2922969itd.168.1550434916448;
        Sun, 17 Feb 2019 12:21:56 -0800 (PST)
Received: from localhost.localdomain (modemcable148.230-83-70.mc.videotron.ca. [70.83.230.148])
        by smtp.gmail.com with ESMTPSA id k3sm1558717ioa.47.2019.02.17.12.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 12:21:55 -0800 (PST)
From:   iamkeyur96@gmail.com
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keyur Patel <iamkeyur96@gmail.com>
Subject: [PATCH] block: Replace function name in string with __func__
Date:   Sun, 17 Feb 2019 10:21:56 -0500
Message-Id: <20190217152156.14438-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keyur Patel <iamkeyur96@gmail.com>

Replace hard coded function name register_blkdev with __func__, to
improve robustness and to conform to the Linux kernel coding
style. Issue found using checkpatch.

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
 block/genhd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 1dd8fd6613b8..33ab7150fbe4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -365,8 +365,8 @@ int register_blkdev(unsigned int major, const char *name)
 		}
 
 		if (index == 0) {
-			printk("register_blkdev: failed to get major for %s\n",
-			       name);
+			printk("%s: failed to get major for %s\n",
+			       __func__, name);
 			ret = -EBUSY;
 			goto out;
 		}
@@ -375,8 +375,8 @@ int register_blkdev(unsigned int major, const char *name)
 	}
 
 	if (major >= BLKDEV_MAJOR_MAX) {
-		pr_err("register_blkdev: major requested (%u) is greater than the maximum (%u) for %s\n",
-		       major, BLKDEV_MAJOR_MAX-1, name);
+		pr_err("%s: major requested (%u) is greater than the maximum (%u) for %s\n",
+		       __func__, major, BLKDEV_MAJOR_MAX-1, name);
 
 		ret = -EINVAL;
 		goto out;
-- 
2.20.1

