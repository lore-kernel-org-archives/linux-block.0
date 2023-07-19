Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59196EB64DA
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 07:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjGSHPS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 03:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGSHPQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 03:15:16 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66026E43
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 00:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689750913; x=1721286913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G09vDse7zEvj0+oVciZKEnyas4RKYuUwRXOFND9n7Po=;
  b=KPGG5UlU301/N/pL4Ff64IWxFdfVHZ5q8qnVTyItTmk1vNVvAdSX/YYU
   205e+KaloCV/ugC1xqL+5IozIc6/+zUfNjjWkfGcW1AOgQj6c4jsnUHbp
   k7XIs/vcT6CBTUKk/PYTq4ubeFa9F7swfZeu/IDLPN5/c76jaBVVKonGT
   AoaVhFE8Ykwum0gwl3OWi94Af3UpKCnWqnAV1j5VMWWt7ZwgEGswswoVS
   5ZyyDRMH5PwI2MwHIx7oox6Su7PZqsQZtBgnxy7KNw0fD1dmincepfo1p
   IUOcP2Zr3IkW5894NiYw/9xAnYJ6GxT//HV3sON6bJyceYgJuuugvvBm7
   g==;
X-IronPort-AV: E=Sophos;i="6.01,216,1684771200"; 
   d="scan'208";a="238846515"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2023 15:15:12 +0800
IronPort-SDR: myQcDpxsY2pMrRbfLmGsFc/WQ0xgUEAwTM0r2QkmtllVIVRbpRLgiS1qU3RdvUePa/d2E19Iop
 cpOy0PcH2L3zYeFzTzYO7/txsISLp//iS0b7pLjTyT/0NFrbWuD7v7VxcF7+w8ZxNsDzuNuU1b
 JVVfPDrp8AasjsscPF2z9G0LUelOjraKr/wBVd8sYEgMLpuPxlJa/d/AvijxjwQjF4+dLBbZTX
 Lrgs4X7EU7lE8LsSd3mStaLNgiQzzpLQyqcK+ic+FxO6s6Ao4p4KG0OeIVT3txPkfyKmXLrwWK
 xSM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2023 23:23:24 -0700
IronPort-SDR: SnTCgq74RsPYr51cHOs6U1bvbNVS2agXymhORRqAOG7AOgHboUBekQGLj60bDWm6c2YdDTZ63z
 /pGUKU4oNFYjVmDhBMnXXKoe/rXvnLymS5yKPTtEnk9SSiucUPUqGLGJeyfxwaS27S97goHdjD
 servZtGY1VEIv3ziqBsQTkr472iUsEOGUVEDOMirp+iMU6779vPLW5c9se3o23yWJVjQCgx7Pn
 gCRprYEr6dxYO7sU0qfxpLGzB6Q2lRL5N0Af7dGdcfEbMJErwGI6ESvf0wco1eEYiTOMc8QWqB
 44c=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jul 2023 00:15:11 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/6] check, common/rc: save sysfs attribute path
Date:   Wed, 19 Jul 2023 16:15:05 +0900
Message-Id: <20230719071510.530623-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719071510.530623-1-shinichiro.kawasaki@wdc.com>
References: <20230719071510.530623-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Current implementation saves sysfs attributes under queue/ directory
in the associative array TEST_DEV_QUEUE_SAVED using attribute file names
as keys. The saved attributes are restored after each test case run.
When TEST_DEV is a device-mapper, this attribute restore does not cover
attributes of device-mapper destination devices. As a preparation to
cover the destination devices, use path of the attributes as keys
instead of file names. Also rename the associative array
TEST_DEV_QUEUE_SAVED to SYSFS_QUEUE_SAVED.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check     | 10 +++++-----
 common/rc | 12 +++++++-----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/check b/check
index 8eaf5c6..e5697c6 100755
--- a/check
+++ b/check
@@ -314,10 +314,10 @@ _cleanup() {
 	fi
 
 	local key value
-	for key in "${!TEST_DEV_QUEUE_SAVED[@]}"; do
-		value="${TEST_DEV_QUEUE_SAVED["$key"]}"
-		echo "$value" >"${TEST_DEV_SYSFS}/queue/${key}"
-		unset "TEST_DEV_QUEUE_SAVED[$key]"
+	for key in "${!SYSFS_QUEUE_SAVED[@]}"; do
+		value="${SYSFS_QUEUE_SAVED["$key"]}"
+		echo "$value" >"${key}"
+		unset "SYSFS_QUEUE_SAVED[$key]"
 	done
 
 	if [[ "${RESTORE_CPUS_ONLINE:-}" ]]; then
@@ -336,7 +336,7 @@ _call_test() {
 	local seqres="${RESULTS_DIR}/${TEST_NAME}"
 	# shellcheck disable=SC2034
 	FULL="${seqres}.full"
-	declare -A TEST_DEV_QUEUE_SAVED
+	declare -A SYSFS_QUEUE_SAVED
 
 	declare -A LAST_TEST_RUN
 	_read_last_test_run
diff --git a/common/rc b/common/rc
index 90122c0..4984100 100644
--- a/common/rc
+++ b/common/rc
@@ -284,12 +284,14 @@ _test_dev_queue_get() {
 }
 
 _test_dev_queue_set() {
-	# For bash >=4.3 we'd write if [[ ! -v TEST_DEV_QUEUE_SAVED["$1"] ]].
-	if [[ -z ${TEST_DEV_QUEUE_SAVED["$1"]} &&
-	      ${TEST_DEV_QUEUE_SAVED["$1"]-unset} == unset ]]; then
-		TEST_DEV_QUEUE_SAVED["$1"]="$(_test_dev_queue_get "$1")"
+	local path="${TEST_DEV_SYSFS}/queue/$1"
+
+	# For bash >=4.3 we'd write if [[ ! -v SYSFS_QUEUE_SAVED["$path"] ]].
+	if [[ -z ${SYSFS_QUEUE_SAVED["$path"]} &&
+	      ${SYSFS_QUEUE_SAVED["$path"]-unset} == unset ]]; then
+		SYSFS_QUEUE_SAVED["$path"]="$(_test_dev_queue_get "$1")"
 	fi
-	echo "$2" >"${TEST_DEV_SYSFS}/queue/$1"
+	echo "$2" >"$path"
 }
 
 _require_test_dev_is_pci() {
-- 
2.40.1

