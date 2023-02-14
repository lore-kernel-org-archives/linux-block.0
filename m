Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DDFC6379F
	for <linux-block@archiver.kernel.org>; Tue, 14 Feb 2023 04:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBNEro (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 23:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBNErn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 23:47:43 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4021CE385
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 20:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676350063; x=1707886063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=706ISowlsI7TcwwD4qz2Zdc7nmdg/lEhqhN+DAUvWrA=;
  b=cssCn7CMh5e74BTfWswbFNZ12Zi8qL/Xv4hkxsqADHmgdBqQa4WOMs0I
   5iI86Cm18F7MUnn/Y+Vis8VaCNA9DkCCj19fLV9pbuiA1oKzMdZe3ua0F
   n0eRfKENxv/oAADBWFktpJAik8BMboy6kcFGWd5S3q6fdl7S7wHQlvM9X
   ji1PLPb+s7T7pHPOrTdtQfos1B4kLdtCAcOpl4RgJS2/5uoX81+VqOLSE
   Tl+M9cm0Y8mSyVebqPrisUtGcguXMz/2zSn5xkMnFUi8UZ8PYdQhC4Nr0
   rp5DLs2kMSg1ctaoKmPT7+aNf9RKeQ1WgiXCBgDow2qYlZyvmNd7WSHuS
   w==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669046400"; 
   d="scan'208";a="221538217"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 12:47:42 +0800
IronPort-SDR: n6p8d+NQeWcXCXcyiBaQq6gKbYtb1oFcwtbJ9X6jcFbdtFO6C7ZoyeCi7UHs2JsAR9mDYOIyuG
 1kdOBYcoz316I0f7PEG0HuB4jNdNSDSP1HSYNlQAp5u5XneKXbkCK9DI4Gqoip42EORYpJ6zHb
 6TQJixMvz90J7mfNO2gmIfCqwNHc94CNvwjXLouaLjPHqtsF0VIe4zlEZn9m2RxUhXC1ONnq9b
 On0UXmaRgRgIMKIckzQkpSx7QjB6Ez35zQoUGAKpJYDMVI660x2wTO72Wm2GdGIYz1izch6Plt
 Hdc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 20:04:51 -0800
IronPort-SDR: H+ZlCuRjtxKHnpkDbhXhDSD1LuwJJePMGcPYw/Ksbp9fgraA/BT2nlO7FBQHB9uc6W6//Z1kxJ
 YP7GExzpNdQ0Q/WpAD97c+mh6ISBYr2IXU/Hf+jwUUIEksvsCY+cLy7vGN96ymWf66DljcAVAm
 hOXAFVPFku1nfrMs4/yUeHT6o6W9oJ3amcxYG+/c7Ft1pOYjUMacIZ7M1cetvnsfW162UVMbwI
 u0xMRWzpp+Qx+4EyonycCGk90qPCd66Ku69497s9OZDhJ93ODzedPZcA7GBWPqGnum53m2Q1/7
 gWQ=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Feb 2023 20:47:42 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Kanchan Joshi <joshi.k@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 1/2] check, common/rc: support normal user privilege
Date:   Tue, 14 Feb 2023 13:47:38 +0900
Message-Id: <20230214044739.1903364-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230214044739.1903364-1-shinichiro.kawasaki@wdc.com>
References: <20230214044739.1903364-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To run commands with normal user privilege, add a new config variable
NORMAL_USER and two helper functions _run_user and _require_normal_user.
The user name specified to NORMAL_USER is used to run the commands
specified to _run_user. The test cases which require NORMAL_USER shall
call _require_normal_user to ensure the NORMAL_USER is valid.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md | 10 ++++++++++
 check                          |  1 +
 common/rc                      | 13 +++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 586be0b..3550f37 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -113,6 +113,16 @@ use_siw=1 ./check nvmeof-mp/
 use_siw=1 ./check srp/
 ```
 
+### Normal user
+
+To run test cases which require normal user privilege, prepare a user and
+specify it to the `NORMAL_USER` variable. The test cases are skipped unless a
+valid user is specified.
+
+```sh
+NORMAL_USER=blktests_user
+```
+
 ### Custom Setup
 
 The `config` file is really just a bash file that is sourced at the beginning
diff --git a/check b/check
index 34e96c4..8eaf5c6 100755
--- a/check
+++ b/check
@@ -799,6 +799,7 @@ fi
 
 : "${LOGGER_PROG:="$(type -P logger || echo true)"}"
 : "${RUN_ZONED_TESTS:=0}"
+: "${NORMAL_USER:=''}"
 
 # Sanity check options.
 if [[ $QUICK_RUN -ne 0 && ! "${TIMEOUT:-}" ]]; then
diff --git a/common/rc b/common/rc
index ef23ebe..af4c0b1 100644
--- a/common/rc
+++ b/common/rc
@@ -381,6 +381,14 @@ _require_test_dev_is_partition() {
 	return 0
 }
 
+_require_normal_user() {
+	if ! id "$NORMAL_USER" >/dev/null 2>&1; then
+		SKIP_REASONS+=("valid NORMAL_USER is not specfied")
+		return 1
+	fi
+	return 0
+}
+
 # Prints a space-separated list with the names of all I/O schedulers supported
 # by block device $1.
 _io_schedulers() {
@@ -409,3 +417,8 @@ _have_writeable_kmsg() {
 	fi
 	return 0
 }
+
+# Run the given command as NORMAL_USER
+_run_user() {
+	su "$NORMAL_USER" -c "$1"
+}
-- 
2.38.1

