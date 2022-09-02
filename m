Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3F5ECAAA1
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 03:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiIBDp1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 23:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbiIBDpX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 23:45:23 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF371EC4D
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 20:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662090320; x=1693626320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+hi6RyCKfTtr3DMi2eEnpO/6akt85B6JcggBgLY6cew=;
  b=DNRAgxg6XIMD8CrxTx6iHgKAG3yoOfEM1We5u9pLq7zjNbHDdlqtLrnb
   pWmXjO5Lm58n7MixC5xNecPUZ7ehFhL70lfYf/pLmGgRYhnPA5hVGXpco
   upOOlK0YhHXYGYOhArPdjyYAmni8i8CK8RHDoDERGADeAHVgJi9F33wYI
   LZrUl8du4yXY/0lyvm8GoBJuTgufW6QkwKxE5lB+QQ5krw8iel66/o79A
   WCpyQ5REuvZ2CLdq2A9S56sWtFmbGBT53+BBTNm0Ve3I1i4dhRSfHqlfY
   zrcKFtT72DVEX60TRTsID1mfCIBAzN0r8U4pwcofwdNr7qkvMifgrrtKO
   w==;
X-IronPort-AV: E=Sophos;i="5.93,281,1654531200"; 
   d="scan'208";a="322404159"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2022 11:45:19 +0800
IronPort-SDR: 1y48n6aIlCx5wsZ5MD6TC2cFfzBbyIIONf0CpxYXd8YLvNsIc+u74A/V6J8U2Y9scCGEc0vdrs
 B6vYpfNUBzgp1JGuVxG/lRmnqyKQ1ccUXwFByzuOSr8RDDQxV9qNQ9k2PGzt0vp1NZgLISmqxO
 MrbuUhEPyGxfepqlCNh0m7tk3bMD2XszYflt7n4iJGXCqdSMz/pq0LMwzMyBb/gc7Vs+C/nM3+
 Xz2y0fX8S4bdXiBhXQ7mBuIH+RY7Xh9dNfHODt0h79sA7jgtWWtZ7+7iKPu8sFeeSNRmsngV4G
 g4k0weLfY5Zod7Rn9f+ElGQf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2022 20:05:47 -0700
IronPort-SDR: hpwv2grAuwVZ0rFra5IhIGAnxGJKzDRSzO9djJw/mIuoPSZ/q6/zyeM31nH5NTWnfqPHQpxTg/
 pMvMThq+978EL8ko0vZdShBaWn/RON+C0BbmnQgWz6kTFx2OS5L1Tcz138ZYcnInMA2fxKbHcX
 etpiJ9emeT0mTCvBfzSNcmX5OTk4XJKIPAVtaz0L1QAv6GfgAc2frqXLf8ol+VSXP362bS86+5
 cIasu/nyInXWZP1cB2Wz1laAPVOFX6OoJNj56eUs96GbL0KJ9168gCQwrxvpqAY2UWrRXG29AV
 PNg=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Sep 2022 20:45:18 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/5] check: clean up _run_test()
Date:   Fri,  2 Sep 2022 12:45:12 +0900
Message-Id: <20220902034516.223173-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220902034516.223173-1-shinichiro.kawasaki@wdc.com>
References: <20220902034516.223173-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Avoid duplicated declarations and returns of local variable 'ret' in
_run_test(). This is a preparation for a following commit.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/check b/check
index e6c321c..85e0569 100755
--- a/check
+++ b/check
@@ -447,6 +447,8 @@ _run_test() {
 	RUN_FOR_ZONED=0
 	FALLBACK_DEVICE=0
 
+	local ret=0
+
 	# Ensure job control monitor mode is off in the sub-shell for test case
 	# runs to suppress job status output.
 	set +m
@@ -461,14 +463,13 @@ _run_test() {
 
 		RESULTS_DIR="$OUTPUT/nodev"
 		_call_test test
-		local ret=$?
+		ret=$?
 		if (( RUN_ZONED_TESTS && CAN_BE_ZONED )); then
 			RESULTS_DIR="$OUTPUT/nodev_zoned"
 			RUN_FOR_ZONED=1
 			_call_test test
 			ret=$(( ret || $? ))
 		fi
-		return $ret
 	else
 		if [[ ${#TEST_DEVS[@]} -eq 0 ]] && \
 			declare -fF fallback_device >/dev/null; then
@@ -494,7 +495,6 @@ _run_test() {
 			requires
 		fi
 
-		local ret=0
 		for TEST_DEV in "${TEST_DEVS[@]}"; do
 			TEST_DEV_SYSFS="${TEST_DEV_SYSFS_DIRS["$TEST_DEV"]}"
 			TEST_DEV_PART_SYSFS="${TEST_DEV_PART_SYSFS_DIRS["$TEST_DEV"]}"
@@ -523,9 +523,9 @@ _run_test() {
 			unset "TEST_DEV_PART_SYSFS_DIRS[${TEST_DEVS[0]}]"
 			TEST_DEVS=()
 		fi
-
-		return $ret
 	fi
+
+	return $ret
 }
 
 _run_group() {
-- 
2.37.1

