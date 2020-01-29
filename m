Return-Path: <SRS0=SUnH=3S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E520C33CB7
	for <linux-block@archiver.kernel.org>; Wed, 29 Jan 2020 23:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74817206F0
	for <linux-block@archiver.kernel.org>; Wed, 29 Jan 2020 23:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eR/icbVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgA2X3d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jan 2020 18:29:33 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:24315 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA2X3c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jan 2020 18:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580340572; x=1611876572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yhegzVwY8X2y0VM3m5FGUcNSnFAXWRc3w6Nd/G8krxw=;
  b=eR/icbVDb8CHETbOPOzfVf1uSWq8qf3+PHU1Vd22wgmMNAjSR4LrFyk5
   cZqwij4fAhAYOqLvzvQrFyaQcrfRwDrxdbnnfz6ZQlCipKwyu1kp9jDW5
   YNtmLuO5FSfhJ7AMXEcKhlJ3EsQ+76EF4fODisORUpwY4CJvYbVYpmVe7
   l460bgBaXJZSg+XKo6I7zLj1t1xXL7OKDhzq9YtuemLt7WA81xVePnr8y
   tivq3muCX29927NaLVurUGVLTvWT6fVp/+adJN7/pvATsFdGRJgv/jjIl
   Bc5Bh7GLE6xF63eA8RALd4i0GkO0O3SBLuJpXjkPArTp9O1PgyFlK8EBM
   Q==;
IronPort-SDR: BTrubU08Yrjcs6u0gpsuzdp7glXk3gU16Y237aQ9aD8pZ8RkcAMTxTbizukgTQJ/et88nlj3OP
 hPiMieARIwgvplFZEbPBsC+36mNkuYFM5QcvkVVlvdee4X76s91wnmqCrzg5lLjQdOH+h1ZQ3b
 aEUPzRbqSu++Q944f/FOu6NEQe75J9eO2k6QDvNXRsXXVuLIlOixUBxpM5w5p7GV96p/9oFgpT
 pRKDAhPTAR7peCMlfGu+Ui8PxypV4KaL+GxJMIeukCe/AbAg5OGP4oW+/SCuX523Sv3bIu3n3I
 UJM=
X-IronPort-AV: E=Sophos;i="5.70,379,1574092800"; 
   d="scan'208";a="128691696"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2020 07:29:32 +0800
IronPort-SDR: QFRtojkkeFg9jmqfxsZALIX5QbNZJ3ALnwmjrjLVXkbMDsHfSiMxPY2fgN6n4kCVoY1asFS8yo
 V3JcP439V+PLLdP5opsgUChcEnN8VGb/9GCq67xvWKxUmuA6a/X9P7SXwaCN3krWPMm7iCpt6x
 H9k9eqRDJNBX1wlwb4c/FzyrH5Uw1foTLD764Iy2pQ9UYJIXpOCG+/Ju5EwFRdjcnL2ocxSJx5
 wVMr5vtg9o+F9Q9Ft+Ms8W9nzaf+OPEFAIEtfAQOzeKvh89ElaONqPo8bHcmbwVM464nAuEPv4
 rt8+EXSK5lmI06RgH6ux2fxa
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 15:22:44 -0800
IronPort-SDR: QBrRE3i19TU7CMyH/+/ZQ2KESII2BUI7FX+WNJk99N93BFvc3LrphHytr8UhtizdCxCfLKaEwY
 42sMvhuutrFd3wEjHJxETIHM5hwZzR8vPSQYW3pjgFlZ/XQlsOvp7A0u2OdXk2kbhqS0g0yB4e
 96pu9II8ucDfpt1BChg/ipurvxToTDXvA25zfFk7vseIsTtWTbprnPGJ6e2vekP0bK97BMFcQ1
 50cntKO00WRY/0VVGK11Guj4bRUxglOfk/muaIsGM2BK/sVPnvwtgjusEk09eh3E6e/n6KsbeM
 bUU=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jan 2020 15:29:32 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/5 blktests] nvme: allow target subsys set model
Date:   Wed, 29 Jan 2020 15:29:19 -0800
Message-Id: <20200129232921.11771-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch updates helper function create_nvmet_subsystem() to handle
newly introduced model attribute.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 tests/nvme/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index d1fa796..377c7f7 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -123,6 +123,7 @@ _create_nvmet_subsystem() {
 	local uuid=$3
 	local cntlid_min=$4
 	local cntlid_max=$5
+	local model=$6
 	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
 	mkdir -p "${cfs_path}"
@@ -133,6 +134,9 @@ _create_nvmet_subsystem() {
 		echo ${cntlid_min} > ${cfs_path}/attr_cntlid_min
 		echo ${cntlid_max} > ${cfs_path}/attr_cntlid_max
 	fi
+	if [ $# -eq 6 ] && [ -f ${cfs_path}/attr_model ]; then
+		echo ${model} > ${cfs_path}/attr_model
+	fi
 }
 
 _remove_nvmet_ns() {
-- 
2.22.1

