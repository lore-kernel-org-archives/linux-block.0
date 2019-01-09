Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4514C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FE420821
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AJJFBg53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfAIBgC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:36:02 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65001 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbfAIBgC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 20:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546997761; x=1578533761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OQ3QVybT61rwiBgKm6rMdQP6nKEsbfWcJftCP3bU+cc=;
  b=AJJFBg53rVg5i0dALQ/FK7y6PDf7Am4/pC7rvtqzrYbVuGOOuY/4Galw
   F4FBbE9dWk2vO3naLcGMUmtvKjy9QKEUbo8ZuJq9jdB3Xgz4dKWCvvAzl
   sR3zSCoj4d+ZlRgv+Sq+wXWaxME0WrevckZ+xi2gv9U/OFNiXrzRdXDYv
   b8QnHXZeVP5eVvkTb58VLqezR/CKHc5LX7nmrHupbKzG3Mu69Id2psi8R
   fGcpxkVXbKo1z/o6HDHb+NS76DyAfS9VX+qLiwqu3CfsrIkSuId3HXCgn
   jceZWHk/gQCXuButv6TFz8O50bL2vhfVVy4b9CykbsiKR3MzwGep9JHd5
   A==;
X-IronPort-AV: E=Sophos;i="5.56,455,1539619200"; 
   d="scan'208";a="203169138"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2019 09:36:01 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 08 Jan 2019 17:16:02 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jan 2019 17:35:59 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH blktests 01/14] config: Introduce ZONED variable
Date:   Wed,  9 Jan 2019 10:35:29 +0900
Message-Id: <20190109013542.23686-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109013542.23686-1-damien.lemoal@wdc.com>
References: <20190109013542.23686-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

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

