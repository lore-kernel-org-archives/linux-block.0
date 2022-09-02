Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE11BC6FA82
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 03:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiIBDp3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 23:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbiIBDpY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 23:45:24 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5602657B
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 20:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662090323; x=1693626323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bnrwBntC+0AO69BK55AhoSUSUKxNSUoTxHX6DmLeRfo=;
  b=fO5YzjGE7VIi7wwNKXXFXdtjyHD38BChh7P3NP0lI3V5M+NA6qCRNSA9
   a6U0HzT35e+XufkF8M/OpsH0Rmo/KTrtkHnOZYfZH7OCNAov+g0oxX9Ci
   te2uB131GAINIstRI5Ug60ag6r7FZxXUYB/T4cqdSDVZL7L2wqWDL0Fls
   jhzoBVErlCMdEoEvzf9XjcwbJyKJtq0lwEPCQ9ijOIvhb9ruCBeHK04Bg
   ZvpXtcmXxs0TMmYgW22F1ANOfx5FNZshTXK6dK8WI9BT4bfPetMMMkc8V
   bKX3eAxBeII2KagMl9eghlxT8PKcsL66P+jPzCqU2fylYDau87QPREU/w
   g==;
X-IronPort-AV: E=Sophos;i="5.93,281,1654531200"; 
   d="scan'208";a="322404166"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2022 11:45:22 +0800
IronPort-SDR: ob+q8hUo20Q+TNkBdBhRc3ZdM84yqga9oI5kZEoCxv2mV992IsBiAKa7MvXcBmrEpKPJuBJaD/
 OQYzzjqr/trBVyf66DcztYHMI79ckWSS+4e35ajeElYD1iS7ywrukHPjkAWsxnN7OT4sq+qVDs
 4N1D2JOqYSMbo1Oo8gmQPzRpcBnAGAHoRmxuyVZR0W65uXV9GSTLSXK2Nj7NDPaZgTJfzQJsoz
 +c6rBZ+uopzbLWAYA1E1U951dvUZTjQomKs9Z/0tUlgog0tWzzmxVVCS1z3ylAkHmaj4jXD17c
 gGTsNwiBTcRMjos7I69cRB33
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2022 20:05:50 -0700
IronPort-SDR: Na+BpTetnNNKUUrUtD9L4FUtUjubuKmy7A8dJA8tgnl7SxVWg1yqx58/iCb5MVGfB+HJRzigwQ
 szFZ0si7dcsa+qTKUu1JXudjCyzoJLL+GzqHjrnM94buYwqpdJJ6LPD2L0uDWcorr2WDJdvlPF
 Q4X4XwNZygua1Fd6/YnguoWNyRK4fJtm9YHxIN3KXyQ12d8XsamBdloucSiCEQV5MyFzuwofAg
 HiIWOrElf4eI6+Hb7ZWvaG2XOXbcS6PP3+d1oVUxWkAd94LVw4yCN+qFzcqXjS2DVCwyEioM9L
 9b0=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Sep 2022 20:45:21 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/5] check,common/rc: move _unload_module() from common/rc to check
Date:   Fri,  2 Sep 2022 12:45:14 +0900
Message-Id: <20220902034516.223173-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220902034516.223173-1-shinichiro.kawasaki@wdc.com>
References: <20220902034516.223173-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To use in the 'check' script in the following commit, move the helper
function _unload_module() from 'common/rc' to 'check'.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check     | 13 +++++++++++++
 common/rc | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/check b/check
index 85e0569..5f57386 100755
--- a/check
+++ b/check
@@ -439,6 +439,19 @@ _test_dev_is_zoned() {
 	   $(cat "${TEST_DEV_SYSFS}/queue/zoned") != none ]]
 }
 
+# Arguments: module to unload ($1) and retry count ($2).
+_unload_module() {
+	local i m=$1 rc=${2:-1}
+
+	[ ! -e "/sys/module/$m" ] && return 0
+	for ((i=rc;i>0;i--)); do
+		modprobe -r "$m"
+		[ ! -e "/sys/module/$m" ] && return 0
+		sleep .1
+	done
+	return 1
+}
+
 _run_test() {
 	TEST_NAME="$1"
 	CAN_BE_ZONED=0
diff --git a/common/rc b/common/rc
index 738a32f..9bc0dbc 100644
--- a/common/rc
+++ b/common/rc
@@ -384,19 +384,6 @@ _uptime_s() {
 	awk '{ print int($1) }' /proc/uptime
 }
 
-# Arguments: module to unload ($1) and retry count ($2).
-_unload_module() {
-	local i m=$1 rc=${2:-1}
-
-	[ ! -e "/sys/module/$m" ] && return 0
-	for ((i=rc;i>0;i--)); do
-		modprobe -r "$m"
-		[ ! -e "/sys/module/$m" ] && return 0
-		sleep .1
-	done
-	return 1
-}
-
 _have_writeable_kmsg() {
 	if [[ ! -w /dev/kmsg ]]; then
 		SKIP_REASONS+=("cannot write to /dev/kmsg")
-- 
2.37.1

