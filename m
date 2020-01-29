Return-Path: <SRS0=SUnH=3S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC16C2D0DB
	for <linux-block@archiver.kernel.org>; Wed, 29 Jan 2020 23:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1A1206D5
	for <linux-block@archiver.kernel.org>; Wed, 29 Jan 2020 23:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZZuihmTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgA2X3f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jan 2020 18:29:35 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:24315 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA2X3f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jan 2020 18:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580340574; x=1611876574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SVMZ6rDXDxbqh4kdUlp9IH8pJ8H96RNHWhe6WJPfMBM=;
  b=ZZuihmTXt6ycwJsLsTIZBCpFXuaDO5YzmNIvvhvZjrPZv5zjKz0sFYoM
   jvdXheYrJ5ayRSWTCWuhYEmhoA5lUX1bbWmhtOUNUlFkMZYKijdYOhuy0
   SAhsnGD06hK77kVo6RZR/jOWbFyUg/RlCsmhrMy+QUdpVWn1CT/MyMsiH
   n3HPg3NmFVROL9cXp34004RbS98MI1FgPxFKtcq8iSAWDbo5mn1x3jdMc
   SPIaDACl1HqQ0q6wyEzFx2CDe6tymHov6klMf2Kq8EpIvFFf6nzy1d7Ya
   CGnBx+tnhO2VB/l3Code03lbq5jPgCufncSTtu1oSCc48jYJBdrXKPrCj
   A==;
IronPort-SDR: Ukx9phanNdzU3aC0sy35tWcvpL2cMUncXaoRIdP0LHFOx4EJyNnWRPbfMHgB/B5XaXZX6os7L/
 QxZOb7A7QtKqQE2hHTuyl9yhYPCw3VlmzlLShO/csorFBl9BOibU/OmWeE3NSs0Dsu/IG35Nbj
 6tY8SzAaDaxiEBPCzMMYjyGMBYNfCtYKRHZBtfNuTGsQVsECHVx/nUk6zcaVlTP74gpD+uTZgW
 iRMY4lkgFlGL97ZZh50N/m9cpxtuCwQqvv+5UWna2Uc6vDb65XKv9Scj0aqPPd8XftNb6XUYC5
 9rY=
X-IronPort-AV: E=Sophos;i="5.70,379,1574092800"; 
   d="scan'208";a="128691700"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2020 07:29:34 +0800
IronPort-SDR: 3Tz0eLteqZnqWDDKWRhjO3GYjnsRplupH1VLxjLwFf/dERaKxysCHcFJXJ9yQuw70WyCIl/d9v
 wIEidHBZTIfYrGFDaBWQxtHMbQ5eOKi3qaj9A7SszkcxCOnNiyb4uekSYMOTzkDluK7V2bsXeW
 jQxsDouK02vi+bZPgoluHFjsSW/fKzVghtHBIg55uVo75fdGtSE4Cp4fU/oTdofwPVKrVMYUMs
 KEGcp2axedtqmr9HsJpbwEyuqs9GWIO7aCWOJKhNVlnbXG4OZZ34+r3nK5Z+G8zB4OfyurOq0n
 HUY0IfhcT1YM+L7iOL/VotLq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 15:22:46 -0800
IronPort-SDR: 0XlCdI7bSbpDT5MVYWh1/IJHF+0QNycY++B3dtpf3KPw0hkBZP8wtAa/c2Z0m5c0kNZWsMOTZx
 rLEOMnrTUvxgMLgyi+I1KFaAOa4ZtTqecRp/ruoJVJ5Vb5LSh6KeSx4cFuwW8EcIOgjmo8Qy48
 W/YOP+GOn4O1d2L90C9/kJI5YLCNLGUIQ90SYS+iQOLj3mHtD9dnsbhV2EKBalhrxFlCt/YUdh
 9PI+sN10C97nNTXRqVgHx9Al0HBYL9vQTxoOvj3GSgHMLrTfOlvAwAnAjnAu9ct5yqq2IlTnMs
 Kfk=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jan 2020 15:29:35 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 5/5 blktests] nvme: make new testcases backward compatible
Date:   Wed, 29 Jan 2020 15:29:21 -0800
Message-Id: <20200129232921.11771-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch makes newly added testcases backward compatible with
right value setting into the SKIP_REASON variable.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 tests/nvme/033 | 60 +++++++++++++++++++++++++++-----------------------
 tests/nvme/034 | 59 ++++++++++++++++++++++++++-----------------------
 tests/nvme/rc  | 27 +++++++++++++++++------
 3 files changed, 83 insertions(+), 63 deletions(-)

diff --git a/tests/nvme/033 b/tests/nvme/033
index 97eba7f..db5ded3 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -9,49 +9,53 @@
 DESCRIPTION="Test NVMeOF target cntlid[min|max] attributes"
 QUICK=1
 
+PORT=""
+NVMEDEV=""
+LOOP_DEV=""
+FILE_PATH="$TMPDIR/img"
+SUBSYS_NAME="blktests-subsystem-1"
+
+_have_cid_min_max()
+{
+	local cid_min=14
+	local cid_max=15
+
+	_setup_nvmet
+	truncate -s 1G "${FILE_PATH}"
+	LOOP_DEV="$(losetup -f --show "${FILE_PATH}")"
+
+	# we can only know skip reason when we create a subsys
+	 _create_nvmet_subsystem "${SUBSYS_NAME}" "${LOOP_DEV}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" ${cid_min} ${cid_max}
+}
+
 requires() {
 	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+		_have_configfs && _have_cid_min_max
 }
 
 test() {
 	echo "Running ${TEST_NAME}"
 
-	_setup_nvmet
-
-	local port
-	local nvmedev
-	local loop_dev
-	local cid_min=14
-	local cid_max=15
-	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
-
-	truncate -s 1G "${file_path}"
-
-	loop_dev="$(losetup -f --show "${file_path}")"
-
-	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" ${cid_min} ${cid_max}
-	port="$(_create_nvmet_port "loop")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	PORT="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "${PORT}" "${SUBSYS_NAME}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	nvme connect -t loop -n "${SUBSYS_NAME}"
 
 	udevadm settle
 
-	nvmedev="$(_find_nvme_loop_dev)"
-	nvme id-ctrl /dev/${nvmedev}n1 | grep cntlid | tr -s ' ' ' '
+	NVMEDEV="$(_find_nvme_loop_dev)"
+	nvme id-ctrl /dev/${NVMEDEV}n1 | grep cntlid | tr -s ' ' ' '
 
-	nvme disconnect -n "${subsys_name}"
+	nvme disconnect -n "${SUBSYS_NAME}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
-	_remove_nvmet_port "${port}"
+	_remove_nvmet_subsystem_from_port "${PORT}" "${SUBSYS_NAME}"
+	_remove_nvmet_subsystem "${SUBSYS_NAME}"
+	_remove_nvmet_port "${PORT}"
 
-	losetup -d "${loop_dev}"
+	losetup -d "${LOOP_DEV}"
 
-	rm "${file_path}"
+	rm "${FILE_PATH}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/034 b/tests/nvme/034
index 1a55ff9..39d833f 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -9,50 +9,53 @@
 DESCRIPTION="Test NVMeOF target model attribute"
 QUICK=1
 
+PORT=""
+NVMEDEV=""
+LOOP_DEV=""
+FILE_PATH="$TMPDIR/img"
+SUBSYS_NAME="blktests-subsystem-1"
+
+_have_model()
+{
+	local model="test~model"
+
+	_setup_nvmet
+	truncate -s 1G "${FILE_PATH}"
+	LOOP_DEV="$(losetup -f --show "${FILE_PATH}")"
+
+	# we can only know skip reason when we create a subsys
+	 _create_nvmet_subsystem "${SUBSYS_NAME}" "${LOOP_DEV}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" 14 15 \
+		${model}
+}
 requires() {
 	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+		_have_configfs && _have_model
 }
 
 test() {
 	echo "Running ${TEST_NAME}"
 
-	_setup_nvmet
-
-	local port
-	local result
-	local nvmedev
-	local loop_dev
-	local model="test~model"
-	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
-
-	truncate -s 1G "${file_path}"
-
-	loop_dev="$(losetup -f --show "${file_path}")"
-
-	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" 0 100 ${model}
-	port="$(_create_nvmet_port "loop")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	PORT="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "${PORT}" "${SUBSYS_NAME}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	nvme connect -t loop -n "${SUBSYS_NAME}"
 
 	udevadm settle
 
-	nvmedev="$(_find_nvme_loop_dev)"
-	nvme list | grep ${nvmedev}n1 | grep -q test~model
+	NVMEDEV="$(_find_nvme_loop_dev)"
+	nvme list | grep ${NVMEDEV}n1 | grep -q test~model
 	result=$?
 
-	nvme disconnect -n "${subsys_name}"
+	nvme disconnect -n "${SUBSYS_NAME}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
-	_remove_nvmet_port "${port}"
+	_remove_nvmet_subsystem_from_port "${PORT}" "${SUBSYS_NAME}"
+	_remove_nvmet_subsystem "${SUBSYS_NAME}"
+	_remove_nvmet_port "${PORT}"
 
-	losetup -d "${loop_dev}"
+	losetup -d "${LOOP_DEV}"
 
-	rm "${file_path}"
+	rm "${FILE_PATH}"
 
 	if [ ${result} -eq 0 ]; then
 		echo "Test complete"
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 377c7f7..77bafd8 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -128,15 +128,28 @@ _create_nvmet_subsystem() {
 
 	mkdir -p "${cfs_path}"
 	echo 1 > "${cfs_path}/attr_allow_any_host"
-	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
-
-	if [ $# -eq 5 ] && [ -f ${cfs_path}/attr_cntlid_min ]; then
-		echo ${cntlid_min} > ${cfs_path}/attr_cntlid_min
-		echo ${cntlid_max} > ${cfs_path}/attr_cntlid_max
+	if [ $# -eq 5 ]; then
+		if [ -f ${cfs_path}/attr_cntlid_min ]; then
+			echo ${cntlid_min} > ${cfs_path}/attr_cntlid_min
+			echo ${cntlid_max} > ${cfs_path}/attr_cntlid_max
+		else
+			SKIP_REASON="attr_cntlid_[min|max] not found"
+			rmdir "${cfs_path}"
+			return 1
+		fi
 	fi
-	if [ $# -eq 6 ] && [ -f ${cfs_path}/attr_model ]; then
-		echo ${model} > ${cfs_path}/attr_model
+	if [ $# -eq 6 ]; then
+		if [ -f ${cfs_path}/attr_model ]; then
+			echo ${model} > ${cfs_path}/attr_model
+		else
+			SKIP_REASON="attr_cntlid_model not found"
+			rmdir "${cfs_path}"
+			return 1
+		fi
 	fi
+	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
+
+	return 0
 }
 
 _remove_nvmet_ns() {
-- 
2.22.1

