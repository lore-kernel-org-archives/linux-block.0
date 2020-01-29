Return-Path: <SRS0=SUnH=3S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F595C2D0DB
	for <linux-block@archiver.kernel.org>; Wed, 29 Jan 2020 23:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AA9206F0
	for <linux-block@archiver.kernel.org>; Wed, 29 Jan 2020 23:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y6Fo5+jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgA2X32 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jan 2020 18:29:28 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:24315 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA2X32 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jan 2020 18:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580340568; x=1611876568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vsWnYxkL3guXdXYEXfUdlM4bUkHgg9d9fy/3CAVl06c=;
  b=Y6Fo5+jp1FF/6cXCmlp2Wu3fCLeUNIV6C+gXdfe5W2+FCmbCZpcGmJ8x
   eV2+kNnh9w0sPnP0fSv3+HaP5OWkoc5ubg0418dds1fyH2KpDvrLMqE7j
   24Bs6dfuAEtdKCONnpm4fUn2jQNS9HJQiaBBShy9xuELpUqxTWpdUs5S6
   eDASrn/6TVwXndr5pohTbeEBRt3LNNfs9VitvE+aeXcOfRIuwxr5Swy/0
   RqxZuNolcDhbg3GpgatmGrNBzaifwVfI7UHdQ7XHfAlqGxvykSck+zKl9
   OuuCExVHWMkZ6/4K5JBdSXmiw87sFA76qscVDoIZsphNz26/BYSc0hh63
   w==;
IronPort-SDR: zZvIixF9aH9MhYOHDgf1iYcyMoufXaZx6ip3+ot4Lfn/7AjiZW1lD5d/fgk9iWb/XmecPBPCkg
 osw4pNTuFy0z0Xs8fkU1opxfJ4N+PoTjg1tW88RH8PAxSG1N3rffBT6gcUtenjM/lsv39xuIlf
 nLcxiRhI3LipdWrSgT+fvEVkEm7oZ6NdgNm+6mh/FYwlLz7ybESD68XR5MlmmD/zQR0VkOE2W7
 blslab6UJf2wsF7gWM0uQWQVW9ywyp2bxA2XNiA93Ax4Bj26sG0nveSNJYAlXlmdchc0icOS/2
 sBo=
X-IronPort-AV: E=Sophos;i="5.70,379,1574092800"; 
   d="scan'208";a="128691692"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2020 07:29:28 +0800
IronPort-SDR: fW9z84a4RYMxVXdDbfFdGou37Y9PMo/HmhRAORSTQq6aoVsL9BDylMIzvbSeJHKJ0WyAZkpq9M
 qiHJIpbl1r8ZfogUQxBQbJiXrb2epkgIxttkp3fgOQRYofAi7Uied8W9wmCd+crjYYwY9Jcpiv
 /weQSMBddOTlmRxFl8poI1fW5oPi3WSyFp9ropJYcmBk3qxFj0Ec0umDMrDgBcwisXfu54Z/qz
 yOinp17HApZks6mBixHudLf0lD24+XBU33R4oNgctLzF+SDbVKjVXeDodpW4SqtPPRqRne0B0x
 roS/+NUSp0/9bIdH8bMTWg0K
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 15:22:40 -0800
IronPort-SDR: qiEFBqR7OxCyAa6e5I9ODkf3gO1TtAjCk3dZgU5zphyUrPJCAsydE1KW7ochUqJ36pDEo7dMug
 rZkX/g3bCMdzP2/m+6uT5GF44Nnh+06o4tR5ZuyBTyJeZKPxAzVEuQ9VZvksBiKLUxueXTJndO
 szdvZJ8JCiy/5NEXIsiWKcPzs4laWl2Q0sNkrRvsJtNNWozx5hKkqlCE3iXBNx0nZ03+jZRlvp
 KRTqTFP3JUnV3dpc8+R3IdTgjy75BaZrIE0HBs3vhvi7QANVPjUxymYSeS6sB44IUjxBHJJprY
 C5M=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jan 2020 15:29:29 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/5 blktests] nvme: allow target subsys set cntlid min/max
Date:   Wed, 29 Jan 2020 15:29:17 -0800
Message-Id: <20200129232921.11771-2-chaitanya.kulkarni@wdc.com>
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
newly introduced cntlid_min and cntlid_max attributes.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 tests/nvme/rc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 40f0413..d1fa796 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -121,11 +121,18 @@ _create_nvmet_subsystem() {
 	local nvmet_subsystem="$1"
 	local blkdev="$2"
 	local uuid=$3
+	local cntlid_min=$4
+	local cntlid_max=$5
 	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
 	mkdir -p "${cfs_path}"
 	echo 1 > "${cfs_path}/attr_allow_any_host"
 	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
+
+	if [ $# -eq 5 ] && [ -f ${cfs_path}/attr_cntlid_min ]; then
+		echo ${cntlid_min} > ${cfs_path}/attr_cntlid_min
+		echo ${cntlid_max} > ${cfs_path}/attr_cntlid_max
+	fi
 }
 
 _remove_nvmet_ns() {
-- 
2.22.1

