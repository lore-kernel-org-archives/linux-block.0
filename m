Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560E5C433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Feb 2021 07:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF23964ED3
	for <linux-block@archiver.kernel.org>; Fri, 26 Feb 2021 07:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhBZHRC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Feb 2021 02:17:02 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:51205 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229541AbhBZHRB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Feb 2021 02:17:01 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id E9E32A68;
        Fri, 26 Feb 2021 02:16:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 26 Feb 2021 02:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=Gas7BtOMLnsm7/pZORoRcfDmtc
        HaHtW6ogx7TjAsTvU=; b=rZ2cBqcDl4ERFl2S9jsQsxFmwl3S+QN5zYOQ3DFI/+
        JgNFgmr8QG/Q3kxMkRFd5ZJ2KRW96MGGl2PXm9xJZtnFXMTcpVmrlpmbomha5+4a
        kYv9U4RMgSSRK+Wd7GG0ss89B2g5DZxcH3mu0QtsmDVYtDlBfzo9A1FGYFJ71SYh
        Si+laXNGfTBtip1FAvyrjrs5Ue6AZakVWnF+6W4XIDIy1pauqfm7rtMn/OzyKVXX
        nzOXbj72gHCA1qQbkyzoS9gUCcsfghZXoD5iuNRDtaCjcZIyHjq+iZwZWTZc+6Jt
        fzbH4e93jlem+LARrV5r2TUE8F5kpgC58oYMmS9NuGdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Gas7BtOMLnsm7/pZO
        RoRcfDmtcHaHtW6ogx7TjAsTvU=; b=a/EwPVjkKn0+wrgrGvMCt6GTwdu+A/RGw
        8E2I7cT98DJf4YY83lw6XrH22o1WzSm1Z7zuFcM/8S3wFoWSyVKX2MEXXyzU7Ipa
        wtnEzIA0I6eIHwMx2Pqqc66SpOSAuVKXiDfBv+3XFamQ5dpFHgwAH4QfidN66fVN
        QmU/hdizsttVdnup4SBoYqtgYpGxc/YsF7WR+EEWBoUQE0kQ+xn/O+DUHQXT1yRW
        198655IFP9MEIGuCwlrg3qEh9weYXN5pUwOiBtFIfI4VzSfd9CPO5p3gV8VcTHlM
        4HyYE7X2S1dtLAhDHZSeAbB+LL9nXhQ31ju0Afdow0naVymrIbV2g==
X-ME-Sender: <xms:PKA4YFBu_6DxnxpxFUTkX6ARiyh1WJ3VPn4FhNS8KnQeOjqQH8iqog>
    <xme:PKA4YDj0k2P1jOMwKDUYGb5ROS_VzdMPMAsUIk80aIltYS0QAPcLy-veRk7Rfa9ln
    eNIrp6HGrt9JcXnOzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrledtgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhsucfl
    vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
    hnpeefveelvdeikeduueffteeggeefhedvffffjeeuueeludehvdegjeevjefhtdetheen
    ucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:PKA4YAmkaf4V94FJGgnDl8cL263lB9CU8exaqII0Qnfgru4Czx30Kw>
    <xmx:PKA4YPxZiof7zGX_stnIIjW77YNnsLSpz55PYBhM8idrCYS_gX9PSg>
    <xmx:PKA4YKR8VLt2xjWn7clhM67BF0Xy7IAugMws8SWaIXl9oMgUjg3MQQ>
    <xmx:PaA4YNIofAecv848Bz07F9p38C4gZG3seXHp40TPbuUI-Uo16G7C-A>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3CDAE240057;
        Fri, 26 Feb 2021 02:16:12 -0500 (EST)
From:   Klaus Jensen <its@irrelevant.dk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH] block: fix argument order for capacity change info print
Date:   Fri, 26 Feb 2021 08:16:06 +0100
Message-Id: <20210226071606.362321-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Klaus Jensen <k.jensen@samsung.com>

Swap "before" and "after" capacities in the info print in
set_capacity_and_notify.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 304f8dcc9a9b..de8ecc402f69 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -73,7 +73,7 @@ bool set_capacity_and_notify(struct gendisk *disk, sector_t size)
 		return false;
 
 	pr_info("%s: detected capacity change from %lld to %lld\n",
-		disk->disk_name, size, capacity);
+		disk->disk_name, capacity, size);
 
 	/*
 	 * Historically we did not send a uevent for changes to/from an empty
-- 
2.30.1

