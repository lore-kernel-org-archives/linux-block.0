Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD51C43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 05:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFB720842
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 05:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RIq+drCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbfCEFZJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 00:25:09 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29725 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfCEFZJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Mar 2019 00:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1551763509; x=1583299509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NLJDoKqNeFjkCpr7fNdtTafJP8i4aDf71RpsRFmb0uI=;
  b=RIq+drCxCzUBbYP+nV/T3PBfhn4Hvdw03xZaOMsnOMfhYeRioKpSs7rm
   I4yPErRnquLocKgPRi1s+ntJ6EAetttBNKBLcPWdkJKweZCW49uAOrDMZ
   IH1gCB4DcqJJP0AaBbNIfAoyLIhyd3h5eN51jv/pfN8R20GfT1VZDxM43
   BaC0vz4rJ4J5sjJX3tZ3lhmMFspE3lCEf60d1ve12Io/98IWtuuKfLeks
   nEJnSOCYBfCezTvJ6VNkz54+1Crgz9akgVj+vAHxlmBNjqP95JmzGQUlo
   fF8Ghx1HmVZA4GigMEY7LHF+57cu53npKZpGu7tVOl7po9GSaaX+YHm3Y
   w==;
X-IronPort-AV: E=Sophos;i="5.58,442,1544457600"; 
   d="scan'208";a="104040566"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2019 13:25:09 +0800
IronPort-SDR: qBqdgGiiAvlQQJOppG8xEP4+nDG9orG9QqdHjpMPY5CZm7+4VSbbxzNNiUAsAXUukobL4JIwvi
 U3i8YfJMRNYJBPVGSMDRhNrO0H525gxs40LW7cBrVEE6zLOVXRRHjObqcYZRnZjUGCz++yScRG
 Hckpjaug2SVSttNE4jYptqjbOUyNCqJCA+3XZjLr7FCAQs6OOQXDHZ/dRTlda4qpJOHUPzBJ9H
 VbFaW/VcJ+Oe8QKf6EX1EGnKaqeFOPSQWC8SHy9Db7qSnTlHPI2L773mcgIC6ihsPPXDvLJRVW
 w3CFIri/LZhbd6jVc0caChRM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 04 Mar 2019 21:05:12 -0800
IronPort-SDR: ER19VKxzZB7My61R0qozBwU3+3t2mxXo7xyXAKeYUtpsdtmQeE+wQWnppT+66KLbH8HC86Dmfo
 kcVW/RopYNsQavHJZ+ORFP7MO1mmfRH/aFLZW2lgZ5/quEqwmn1ghgBvGJTSRR+AJURkY4HMah
 6ftFuvGfN9roKeimCRyyDG5ROXUbvSAArJZb6VMiAb+i8NWwX3TsWO6ht4i1Sa/5kjxXimJ2hh
 dYjODJn8NdiW2uzdcb9im+9jQupwAL83g4s2CxDLbDfBgPw+DCCmfLdF+NjJF8Kma+bHUCa9tv
 RdU=
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Mar 2019 21:25:08 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Masato Suzuki <masato.suzuki@wdc.com>,
        Omar Sandoval <osandov@osandov.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests 3/3] zbd: Change sysfs path for partition devices
Date:   Tue,  5 Mar 2019 14:24:47 +0900
Message-Id: <20190305052447.24291-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190305052447.24291-1-shinichiro.kawasaki@wdc.com>
References: <20190305052447.24291-1-shinichiro.kawasaki@wdc.com>
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
Reviewed-by: Omar Sandoval <osandov@fb.com>
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

