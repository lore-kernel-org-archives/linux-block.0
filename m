Return-Path: <SRS0=eqh8=ZK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBDBC432C3
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 00:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65F420748
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 00:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="aEv5g5+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfKRAVP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Nov 2019 19:21:15 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38611 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfKRAVL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Nov 2019 19:21:11 -0500
Received: by mail-ot1-f65.google.com with SMTP id z25so13009870oti.5
        for <linux-block@vger.kernel.org>; Sun, 17 Nov 2019 16:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SDNwfNn5T935taTtptdT62qB38KmzsVcQ6J6XQJ53cI=;
        b=aEv5g5+5C6ppRO0EAPEGURQUArJ63u81uTTgvLm4P+Guga1fGGKMS1Nuo8T37b4zV4
         zEuuBGKHk131JOaVbjUp/EQHLOIQnVu3zbEgCeAhw5dbdt1tAjHx4aKJbZhJuG+7QFCu
         zkGZX2Exv2ZNkGsnurlGEWsp7DHnheWdZnl+1nhKFL/wSbaGx1Ec5wcyxebhJ8s+5n/8
         hJ0CWQbXD7vb3ZKuDIKO9wJWpMZ4EOMUkjkwndgxNuR5F7g3kPUUdIIx6LnNlSj0J+I7
         Mrir+yrv7R+gw8Dqe7MUm+kKc3hRE6f1dRRFXrO70FjfDlF7dentqtYRz6dnx04pOgM0
         Ihjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SDNwfNn5T935taTtptdT62qB38KmzsVcQ6J6XQJ53cI=;
        b=Wbbj3VORBGSsDQHsbMVmkiyksvDa7HX2B6Y0MKgjKm3EcDM1P7/QLCHxoLeiLsjmNC
         tHA43ao65DwOKCTZy0+sAUNRWhx5f9BNJqS/Zy/LyGKA2JW8YnOghqb18tVvYQNm093m
         VIUw9yY1NA0vRkbvHuy++ZuaTR1/Smt/c/tHEzMpM2tOCs92mNUQL4pNpST7g1d9lJjK
         t6pgqJkUrWXFqswkx9KBpGG16whfRtruCfiiq+HsuQ4uVuW/pHS98hgd+/UpVqmYpSig
         V8QafS3Eyzi2MMVnNk3yGkcEriq+kz6fQi2gjqODfh1ygRwCIS+cdKWMLHoZs3kMscWc
         W7zA==
X-Gm-Message-State: APjAAAWo+TnWaHBrvVTAY2G6wq2HXWxdWKuKMV1+QHl0usJ7omsuioH4
        ksy51Ty8PqCKrcNqBoIn5Vbr3Q==
X-Google-Smtp-Source: APXvYqwUvhZb0tmkUQIH6eMJOADzdbdXiPEfFkpMFra3bB5mOsE5PZZOsHOxZWI4QlXk8Y3GXm3jCA==
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr20448773otn.135.1574036469452;
        Sun, 17 Nov 2019 16:21:09 -0800 (PST)
Received: from com.attlocal.net ([2600:1700:4870:71e0::10])
        by smtp.gmail.com with ESMTPSA id 65sm5532194oie.50.2019.11.17.16.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 16:21:08 -0800 (PST)
From:   Frederick Lawler <fred@fredlawl.com>
To:     axboe@kernel.dk
Cc:     Frederick Lawler <fred@fredlawl.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        bvanassche@acm.org
Subject: [PATCH v2 2/4] skd: Replace magic numbers with PCI constants
Date:   Sun, 17 Nov 2019 18:20:55 -0600
Message-Id: <20191118002057.9596-3-fred@fredlawl.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118002057.9596-1-fred@fredlawl.com>
References: <20191118002057.9596-1-fred@fredlawl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Readability was improved by replacing pci_read_config_word() with
pcie_capability_read_word(). Take that a step further by replacing magic
numbers with PCI reg constants.

No functional change intended.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
v2
- Added this patch
---
 drivers/block/skd_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index f25f6ef6b4c7..7f8243573ad9 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -3141,9 +3141,11 @@ static char *skd_pci_info(struct skd_device *skdev, char *str)
 		char lwstr[6];
 		uint16_t pcie_lstat, lspeed, lwidth;
 
-		pcie_capability_read_word(skdev->pdev, 0x12, &pcie_lstat);
-		lspeed = pcie_lstat & (0xF);
-		lwidth = (pcie_lstat & 0x3F0) >> 4;
+		pcie_capability_read_word(skdev->pdev, PCI_EXP_LNKSTA,
+					  &pcie_lstat);
+		lspeed = pcie_lstat & PCI_EXP_LNKSTA_CLS;
+		lwidth = (pcie_lstat & PCI_EXP_LNKSTA_NLW) >>
+			 PCI_EXP_LNKSTA_NLW_SHIFT;
 
 		if (lspeed == 1)
 			strcat(str, "2.5GT/s ");
-- 
2.20.1

