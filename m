Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A188FC4332F
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 01:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241654AbiC3BeL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 21:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241662AbiC3BeH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 21:34:07 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23631717AB
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 18:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648603942; x=1680139942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jwC8nlFbJTudjf2iGZWVEWkkspsXWBZD/gOpoJQ3smk=;
  b=fCmP1N0x+vy/F5Wbklo0g6WQw0MLbqD4tu6cCzkkKJnJWaUbPc8kQej7
   zrA0yme09poP7y7AEY8HcgFwyUB+8fICayK3IUXgCSUMfYgi7QZtDWvss
   9N/b4l7ZMZ1SrFn9yX1FBCIN62TPAU3JlelUN7rTXsnkyG9aVJEGdBzGK
   Qm/TQ6WmqRCL5wy+8Gj5+UUg8uqW59RDivIG285X6QHHjuLyBkbEHijCr
   BzyntO+gcytp6ujQH7pfIAi2yzqCe2HkzqpXdarStTkK77BIbMrRhTM7P
   R7qPKSh3y1dGyT3iaDJrc98FqEnergDX7l6LMmUm3yui/l3BFDtWgowV/
   g==;
X-IronPort-AV: E=Sophos;i="5.90,221,1643644800"; 
   d="scan'208";a="201439168"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2022 09:32:22 +0800
IronPort-SDR: Nrv470lbnCTt2nFFS1spcqT2fDYU71pTU5kkAvhoTQBjN3aoSv93/MW6YXgOreStOQIwJHBK4V
 3oDyYUimJTfslSEZ75L9cR9nTZGHRjgvxPwpXMSNFTwtzJw7j/40bjNDYkUBMYt/sRiD+z2dI3
 /Wz4KZXbn3Vj2QhUv8ElZTk7mWB0y/PtGqN6l0b9qNAP8XiHzgMG2LN/XZOy4dXnlj+eB/tj15
 b2rFFjFtBD+7i1yjk15KTv6BFXCAqDjnANOLiunHMgz1Y3QwRGtN+4kIKRnkmbQnCR0URrNjMZ
 lbmIBZOOW29ac48i6dSG8RPK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2022 18:03:14 -0700
IronPort-SDR: rCeDuQ5ioGLvV2aNjN9bki8MHJDQATcMdx/37nx3/Tyt/clBjvU2HfxJhUpn2FC1wdSOekVkNc
 DMfegK3csEbB8tkpBljkLTbml7ZkZPY8UNJMnrwq5HCAkBhJmBD2tdnyeBsXAOc/M/Va6LomLf
 gjXQI28nTMz5i/FowLr7bC0mIq+CmHyuRR7/By+ShX6RH/ASVyR8X34F273Hlts+c//zVc+rk+
 EDgkTZpRqTKMFDOq+SFdtosDyYmSm4JFTVXI1lweJ/XyzP2Sk9n0N1cQYfADGf7PwkOcO2kvdJ
 hwg=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Mar 2022 18:32:22 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 5/6] scsi/006: skip cache types which disable read cache for SATA drives
Date:   Wed, 30 Mar 2022 10:32:14 +0900
Message-Id: <20220330013215.463555-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330013215.463555-1-shinichiro.kawasaki@wdc.com>
References: <20220330013215.463555-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test case scsi/006 sets four cache types to test target SCSI
devices. Two cache types out of the four, "none" and "write back, no
read (daft)" disable read cache. However, these two types do not work
for SATA drives since SAT specification requires Disable Read Cache is
always set to zero in the caching mode page. It results in invalid
argument error and the test case failure.

To avoid the failure, skip the cache types which disable read cache if
the test devices are SATA drives. To check the device, add a helper
function _test_dev_is_sata in scsi/rc.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/scsi/006 | 4 ++++
 tests/scsi/rc  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/tests/scsi/006 b/tests/scsi/006
index 74df39d..fe1d202 100755
--- a/tests/scsi/006
+++ b/tests/scsi/006
@@ -35,6 +35,10 @@ test_device() {
 	original_cache_type="$(cat "$cache_type_path")"
 	for cache_type in "${cache_types[@]}"; do
 		echo "$cache_type"
+		# SAT requires Read Cache Disable always set to zero.
+		# Skip cache types which disable read cache for SATA drives.
+		_test_dev_is_sata && [[ $cache_type == none ]] ||
+			[[ $cache_type =~ "no read" ]] && continue
 		( echo "$cache_type" > "$cache_type_path" ) |& grep -v "Invalid argument"
 		if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
 			# If setting the cache type succeeded, it should now
diff --git a/tests/scsi/rc b/tests/scsi/rc
index 1477cec..c8d2f42 100644
--- a/tests/scsi/rc
+++ b/tests/scsi/rc
@@ -37,3 +37,7 @@ _require_test_dev_is_scsi_disk() {
 _get_test_dev_sg() {
 	echo "${TEST_DEV_SYSFS}"/device/scsi_generic/sg* | grep -Eo "sg[0-9]+"
 }
+
+_test_dev_is_sata() {
+	[[ $(<"${TEST_DEV_SYSFS}"/device/vendor) == "ATA     " ]]
+}
-- 
2.34.1

