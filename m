Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8598BC43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 09:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5653120883
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 09:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V+NgIUfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfARJpT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:45:19 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34681 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbfARJpS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 04:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547804719; x=1579340719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J5dITalF8Q+eHuhjO0iTOWrN0bjgfPaGbX8tVYk/w1k=;
  b=V+NgIUfW88Xfy/aYYOvbw3kqdh/EoMI6tD+vwxoyoM+QF1dWYsDBN7S9
   Suamdzh95tlNABVmhgq419ZXmODz0YGnTPovO/XwOnq397tWJeitvbgKY
   F/xQlG0TOve7ow89L5pU1W5HRC0UQPGVz+7iXHX4OGHwdhELPPZ5/byss
   i21taIR9FGfZ1bxSqJf2TDoKhEsrn/8YcilaEEhxpqC8e2MljpCcgJLyx
   Pm3rbOQxpJzyaXFxMJuq2AWWM4Cn8EM401+vq1VI6aHfyZAXjjqnR31oh
   XtYxyzU7DuTFQhCJVHlDTZSacyNmKd5mPB8SehZKct7Qo1X0NLWoZEOkK
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,489,1539619200"; 
   d="scan'208";a="100920279"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2019 17:45:19 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 18 Jan 2019 01:26:36 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2019 01:45:15 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v3 05/13] check: Introduce fallback_device() and cleanup_fallback_device()
Date:   Fri, 18 Jan 2019 18:44:45 +0900
Message-Id: <20190118094453.13773-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
References: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
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
 check | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/check b/check
index 4563d62..4b66995 100755
--- a/check
+++ b/check
@@ -407,6 +407,7 @@ _run_test() {
 	CHECK_DMESG=1
 	DMESG_FILTER="cat"
 	RUN_FOR_ZONED=0
+	FALLBACK_DEVICE=0
 
 	# shellcheck disable=SC1090
 	. "tests/${TEST_NAME}"
@@ -425,6 +426,23 @@ _run_test() {
 			_call_test test
 		fi
 	else
+		if [[ ${#TEST_DEVS[@]} -eq 0 ]] && \
+			declare -fF fallback_device >/dev/null && \
+			declare -fF cleanup_fallback_device >/dev/null; then
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
@@ -451,6 +469,13 @@ _run_test() {
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

