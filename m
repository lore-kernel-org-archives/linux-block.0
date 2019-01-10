Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D1CC43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987DB214DA
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A22RF7Hg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfAJJhf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:37:35 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:25528 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfAJJhf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 04:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547113087; x=1578649087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pnt7Qxkqse0S6ZxSKQ/QFG4UwJwscYzQnINFv9SFMMk=;
  b=A22RF7HgV0SRq2ivAUczihSZ4YJT1BScDaNmqbQN8c2FuksetR3CbK3v
   1Ar8kxoSTI5skzkbShWodVFlKd+m0tNceurDRngC0UZNHYKkFcwPEYdha
   ZgafA7O8h5cplxF/bY2VUz/SQFhrg5exfazdiGQaibv1n48Wt9oMO0doI
   qHtFPMptqgCWQX3jj7qlbkHIt6SJPc5maCd4mrPBJcrW5bKf5TttVgBLl
   plfhfZYtjru9qFrud2Tzq0cY22c1SCB63RCZwETJS+qOHzymLdiS33StE
   KR0YN5TkSAeShntQ5DJAl5nbkRfRypsWBBTr5WmjXlxEGSV7SIa2R8Db2
   A==;
X-IronPort-AV: E=Sophos;i="5.56,460,1539619200"; 
   d="scan'208";a="196468967"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2019 17:38:07 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 10 Jan 2019 01:19:05 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jan 2019 01:37:31 -0800
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
Subject: [PATCH blktests v2 01/16] config: Introduce ZONED variable
Date:   Thu, 10 Jan 2019 18:37:10 +0900
Message-Id: <20190110093725.32675-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
References: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To allow running tests against null_blk devices with the zoned mode
enabled, introduce the config ZONED variable. If set (ZONED=1), tests
that create a null_blk device as a test target device will be executed
against a zoned null device.

_init_null_blk is modified to prepare null_blk as a zoned blocked device
if ZONED is set. To avoid "modprobe -r null_blk" failures, rmdir calls
on all sysfs nullbX directories is added.

Introduce a helper function _null_blk_not_zoned() to check if
_init_null_blk() creates zoned device or not. This function can be used
within test script implementation of the requires() function to ensure
that the test is run only for non-zoned null_blk device.

The use of the ZONED variable requires that the kernel be compiled with
CONFIG_BLK_DEV_ZONED enabled.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md | 11 +++++++++++
 check                          |  1 +
 common/null_blk                | 23 ++++++++++++++++++++++-
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 8f32af3..0416d6d 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -82,6 +82,17 @@ passing the `-d` command line option or setting the `DEVICE_ONLY` variable.
 DEVICE_ONLY=1
 ```
 
+### Zoned Block Device
+
+Some test items prepare virtual devices such as null_blk. To configure the
+virtual device as a zoned block device, set `ZONED` variable. The use of the
+ZONED variable requires that the kernel be compiled with CONFIG_BLK_DEV_ZONED
+enabled.
+
+```sh
+ZONED=1
+```
+
 ### Custom Setup
 
 The `config` file is really just a bash file that is sourced at the beginning
diff --git a/check b/check
index 6c6d9f5..141ebb6 100755
--- a/check
+++ b/check
@@ -591,6 +591,7 @@ fi
 # Default configuration.
 : "${DEVICE_ONLY:=0}"
 : "${QUICK_RUN:=0}"
+: "${ZONED:=0}"
 : "${OUTPUT:=results}"
 if [[ -v EXCLUDE ]] && ! declare -p EXCLUDE | grep -q '^declare -a'; then
 	# If EXCLUDE was not defined as an array, convert it to one.
diff --git a/common/null_blk b/common/null_blk
index 937ece0..a78c95d 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -8,8 +8,29 @@ _have_null_blk() {
 	_have_modules null_blk
 }
 
+_null_blk_not_zoned() {
+	if [[ "${ZONED}" != "0" ]]; then
+		# shellcheck disable=SC2034
+		SKIP_REASON="null_blk zoned mode not supported"
+		return 1
+	fi
+	return 0
+}
+
 _init_null_blk() {
-	if ! modprobe -r null_blk || ! modprobe null_blk "$@"; then
+	for d in /sys/kernel/config/nullb/*;
+	do [[ -d "$d" ]] && rmdir "$d";	done
+
+	local _zoned=""
+	if [[ ${ZONED} -ne 0 ]] ; then
+		if ! _have_kernel_option BLK_DEV_ZONED ; then
+			echo -n "ZONED specified for kernel with "
+			echo "CONFIG_BLK_DEV_ZONED disabled"
+			return 1
+		fi
+		_zoned="zoned=1"
+	fi
+	if ! modprobe -r null_blk || ! modprobe null_blk "$@" "${_zoned}" ; then
 		return 1
 	fi
 
-- 
2.20.1

