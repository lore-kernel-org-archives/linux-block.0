Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94113C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 08:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EE720700
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 08:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MFvkc+pJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfBTIM4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:12:56 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:33059 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfBTIM4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 03:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550650376; x=1582186376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oI/CYB9DFPJxVFP56PJxwlRlPbv/Y7JCPnfHQRDzaHQ=;
  b=MFvkc+pJf0Zyuh3iaO/Mv6it9mv52D5Jr6Ef4rb1q4qQczpQbWOKZJ1k
   MQSHaPKhhcWmwxpChS0VJPm3F9BwLXqz0jq1OIVzcIHXR5x5wcGFW9IRV
   XXrMUfXlxEdfBGfRjHxvS+Z1TCu+5eyOjLp1p20Hs/M/O+dOga/oX/4jJ
   Q55vyMeA59HoSW7yOSFMOZWyl35ZbDM59JD4TvaE/JXloYMIGFuitAApi
   fIO7WcLuEOBM0FtOWBASV1gkITdOb8cbtHMR37h6nsasjIw9LBErMbwRC
   xH4Hx6I0MT/1rmaSVSxYalMFw7guHyDXmxoFiNVNmtirPO5mraAQo22TX
   g==;
X-IronPort-AV: E=Sophos;i="5.58,390,1544457600"; 
   d="scan'208";a="106683028"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2019 16:12:56 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Feb 2019 23:51:19 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Feb 2019 00:12:54 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests 5/5] zbd: Change sysfs path for partition devices
Date:   Wed, 20 Feb 2019 17:12:31 +0900
Message-Id: <20190220081231.15366-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220081231.15366-1-shinichiro.kawasaki@wdc.com>
References: <20190220081231.15366-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

zbd/001 and zbd/002 test cases fail for partition devices because of
sysfs path difference between partition devices and their holder
devices. The size parameter in sysfs path is different between the
partition devices and their holder devices. The holder devices have
nr_zones parameter in sysfs but the partition devices do not.

Utilize _test_dev_is_partition() helper function and TEST_DEV_PART_SYSFS
variable to refer correct sysfs size parameter for the partition devices.
Do not refer sysfs nr_zones parameter for the partition devices. Instead,
calculate the expected nr_zones from device capacity and zone size.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/rc | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/zbd/rc b/tests/zbd/rc
index c32bf31..88538d0 100644
--- a/tests/zbd/rc
+++ b/tests/zbd/rc
@@ -75,7 +75,11 @@ export SV_NR_ZONES=4
 _get_sysfs_variable() {
 	unset SYSFS_VARS
 	local _dir=${TEST_DEV_SYSFS}
-	SYSFS_VARS[$SV_CAPACITY]=$(<"${_dir}"/size)
+	if _test_dev_is_partition; then
+		SYSFS_VARS[$SV_CAPACITY]=$(<"${TEST_DEV_PART_SYSFS}"/size)
+	else
+		SYSFS_VARS[$SV_CAPACITY]=$(<"${_dir}"/size)
+	fi
 	SYSFS_VARS[$SV_CHUNK_SECTORS]=$(<"${_dir}"/queue/chunk_sectors)
 	SYSFS_VARS[$SV_PHYS_BLK_SIZE]=$(<"${_dir}"/queue/physical_block_size)
 	SYSFS_VARS[$SV_PHYS_BLK_SECTORS]=$((SYSFS_VARS[SV_PHYS_BLK_SIZE] / 512))
@@ -83,7 +87,7 @@ _get_sysfs_variable() {
 	# If the nr_zones sysfs attribute exists, get its value. Otherwise,
 	# calculate its value based on the total capacity and zone size, taking
 	# into account that the last zone can be smaller than other zones.
-	if [[ -e ${TEST_DEV_SYSFS}/queue/nr_zones ]]; then
+	if [[ -e "${_dir}"/queue/nr_zones ]] && ! _test_dev_is_partition; then
 		SYSFS_VARS[$SV_NR_ZONES]=$(<"${_dir}"/queue/nr_zones)
 	else
 		SYSFS_VARS[$SV_NR_ZONES]=$(( (SYSFS_VARS[SV_CAPACITY] - 1) \
-- 
2.20.1

