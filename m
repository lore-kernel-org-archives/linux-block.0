Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094B2C282CD
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 13:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDA120880
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 13:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hRqBnOf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfA1NPU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:15:20 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:31555 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfA1NPU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 08:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548681320; x=1580217320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ohdlxYWk3A5VLZiAOv6jplzCsRw75TbVrcXQSY4UUX4=;
  b=hRqBnOf7ut+9lRsczpsSomadf1KswBmaqmVg0c5jx9UEiULd9+CSn9Vt
   imCjDCubTPMxGjqDUhRoorlVPLhyc1XrZnvY4tImxf9yfa8lFc0x5WmOm
   o4ABTf4pAqc38z2KauCwPdX3Xavg4g/lxS8kduhpr/VensepdMaBGvMsb
   0wymCFYLj2PlUQeSvC8JrHbGd7ScFOxSiogeEpSI0SLx11NhA5LaVSUm4
   f4ChAyrwIv8hxT2Z8dMCkmJpbY6jYGCrM6EIXZ7om0GMnTgE+UqFpm8eT
   hRkwe0w3+o9Q+pQdl8RQVAwbBroU+6JqIR3qezhKiMfYWWSX0Bhpwwbl0
   w==;
X-IronPort-AV: E=Sophos;i="5.56,534,1539619200"; 
   d="scan'208";a="104898854"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2019 21:15:20 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 28 Jan 2019 04:54:23 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jan 2019 05:15:17 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v4 05/12] check: Introduce fallback_device() and cleanup_fallback_device()
Date:   Mon, 28 Jan 2019 22:14:48 +0900
Message-Id: <20190128131455.31997-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128131455.31997-1-shinichiro.kawasaki@wdc.com>
References: <20190128131455.31997-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These optional functions can be defined by a test case script. When
defined and TEST_DEVS is empty, the fallback_device() is executed before
runing the test case. The fallback_device() function intializes a virtual
device to run the test case and return the device to be set in TEST_DEVS.
After running the test case, cleanup_fallback_device() is executed to
clean up the device.

This feature allows to run test cases with test_device() function even if
TEST_DEVS is not set in the config, using virtaul devices such as null_blk.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/check b/check
index 5cf07dd..5d44ee3 100755
--- a/check
+++ b/check
@@ -17,7 +17,7 @@ _found_test() {
 	local test_name="$1"
 	local explicit="$2"
 
-	unset DESCRIPTION QUICK TIMED CAN_BE_ZONED requires device_requires test test_device
+	unset DESCRIPTION QUICK TIMED CAN_BE_ZONED requires device_requires test test_device fallback_device cleanup_fallback_device
 
 	# shellcheck disable=SC1090
 	if ! . "tests/${test_name}"; then
@@ -44,6 +44,16 @@ _found_test() {
 		return 1
 	fi
 
+	if declare -fF fallback_device >/dev/null && ! declare -fF cleanup_fallback_device >/dev/null; then
+		_warning "${test_name} defines fallback_device() but not cleanup_fallback_device()"
+		return 1
+	fi
+
+	if declare -fF cleanup_fallback_device >/dev/null && ! declare -fF fallback_device >/dev/null; then
+		_warning "${test_name} defines cleanup_fallback_device() but not fallback_device()"
+		return 1
+	fi
+
 	if (( QUICK && TIMED )); then
 		_warning "${test_name} cannot be both QUICK and TIMED"
 		return 1
@@ -407,6 +417,7 @@ _run_test() {
 	CHECK_DMESG=1
 	DMESG_FILTER="cat"
 	RUN_FOR_ZONED=0
+	FALLBACK_DEVICE=0
 
 	# shellcheck disable=SC1090
 	. "tests/${TEST_NAME}"
@@ -425,6 +436,22 @@ _run_test() {
 			_call_test test
 		fi
 	else
+		if [[ ${#TEST_DEVS[@]} -eq 0 ]] && \
+			declare -fF fallback_device >/dev/null; then
+			if ! test_dev=$(fallback_device); then
+				_warning "$TEST_NAME: fallback_device call failure"
+				return 0
+			fi
+			if ! sysfs_dir="$(_find_sysfs_dir "$test_dev")"; then
+				_warning "$TEST_NAME: could not find sysfs directory for ${test_dev}"
+				cleanup_fallback_device
+				return 0
+			fi
+			TEST_DEVS=( "${test_dev}" )
+			TEST_DEV_SYSFS_DIRS["$test_dev"]="$sysfs_dir"
+			FALLBACK_DEVICE=1
+		fi
+
 		if [[ ${#TEST_DEVS[@]} -eq 0 ]]; then
 			return 0
 		fi
@@ -452,6 +479,13 @@ _run_test() {
 				ret=1
 			fi
 		done
+
+		if (( FALLBACK_DEVICE )); then
+			cleanup_fallback_device
+			unset TEST_DEV_SYSFS_DIRS["${TEST_DEVS[0]}"]
+			TEST_DEVS=()
+		fi
+
 		return $ret
 	fi
 }
-- 
2.20.1

