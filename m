Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E58BECAAD3
	for <linux-block@archiver.kernel.org>; Wed, 31 Aug 2022 05:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiHaF1d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 01:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHaF1c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 01:27:32 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE291AB07D
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 22:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661923651; x=1693459651;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ByKcWcIpfCse/1hPY8HeKN2pwqbZzeKO8j/Hwys4Ebw=;
  b=hh4B0ECrZ6DBSUh7i2/ZMemOVInIiKerl5fq7ZzRbWRwOV8eS0JmoEws
   aKHDmiNM3n0GWb0bYtcwD295Ioea2bbylm8ZoY3lI8j1ESrCelxdER6ca
   /U5hpgDSTJFob/jT/uEz4f812vrLhoLSiJchtPuJwRK9DsjFmOkQToiHp
   1HyTY1Z+LLlDqIVS6WhzvhbvOuag2MCDhJw7tYlhQ3Y46l5spMGBgJO6s
   AT3h1ce8OHGVBeP3xGF5JBaf8jHWHs+bVGzAGhH8MqB6ZbeUwdGaxR8Kt
   11DWlNu0OI/UnZo6b1j67K2/Qa/R/HBj66nq7iOJYNCnB0ow9L/PMHeLc
   w==;
X-IronPort-AV: E=Sophos;i="5.93,276,1654531200"; 
   d="scan'208";a="314384594"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2022 13:27:30 +0800
IronPort-SDR: sOk86hABNwxULIrYW4izEwSO1WvKkNErcUCm9IEESk2mGjVQRFgnS/728e/w/woH/ofMWPwV+k
 HRUTxlIHZoC/0/RYxP+OQBK0h6fpEkX975895ylDRmhQt2t9zu+PhELqHXqdDcq7k4O+u7RT2e
 Qp+4YaihntCqXdjWDlYi4RFUcuJ3jCZK7XhK/u5iPXGuY8RuTq+PpmDSF46H4A6sDCHlERtawc
 1BrSiAtZXl9iTBM7RAdvck4dYJxPQCDhjvT3dwKL7U0hiI0hETwLHvdhUDTaytTEG7XUXiESU9
 zoFBwlh+UqdDUOw84LX2qAUW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Aug 2022 21:48:01 -0700
IronPort-SDR: hizPfkSQj+R1AVB3qYVnBn+WcmNuyOXqGHpB9nU3LxPHCOnhHhHhzb+X61rW/E9VbbNrVYcZbS
 2i89kdt9/z67upctY9EHlsU58HpNFqdkVxA6HeyfKpFBj8hrrkRCDNXwMKMj5VFoPdYsM4LFWH
 GwXZB4uqRoja2oLHuJOR4BqTFulI6wFUumGUUdKe0yTwb+6gGpFjJcQHFRDuU6BCgMhEBIUBS5
 7AXAfLXqjaGPleGSuUiK5mda+NPdRuEMFY0sdQxc3/B2ed90J1hCp4qd+QK390hvUO3JbkaLjw
 fiA=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Aug 2022 22:27:31 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Hannes Reinecke <hare@suse.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/043,044,045: load dh_generic module
Date:   Wed, 31 Aug 2022 14:27:29 +0900
Message-Id: <20220831052729.202997-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Test cases nvme/043, 044 and 045 use DH group which relies on dh_generic
module. When the module is built as a loadable module, the test cases
fail since the module is not loaded at test case runs.

To avoid the failures, load the dh_generic module at the preparation
step of the test cases. Also unload it at test end for clean up.

Reported-by: Sagi Grimberg <sagi@grimberg.me>
Fixes: 38d7c5e8400f ("nvme/043: test hash and dh group variations for authenticated connections")
Fixes: 63bdf9c16b19 ("nvme/044: test bi-directional authentication")
Fixes: 7640176ef7cc ("nvme/045: test re-authentication")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://lore.kernel.org/linux-block/a5c3c8e7-4b0a-9930-8f90-e534d2a82bdf@grimberg.me/
---
 tests/nvme/043 | 4 ++++
 tests/nvme/044 | 4 ++++
 tests/nvme/045 | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/tests/nvme/043 b/tests/nvme/043
index 381ae75..dbe9d3f 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -40,6 +40,8 @@ test() {
 
 	_setup_nvmet
 
+	modprobe -q dh_generic
+
 	truncate -s 512M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
@@ -88,5 +90,7 @@ test() {
 
 	rm "${file_path}"
 
+	modprobe -qr dh_generic
+
 	echo "Test complete"
 }
diff --git a/tests/nvme/044 b/tests/nvme/044
index 0465531..5ef6160 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -51,6 +51,8 @@ test() {
 
 	_setup_nvmet
 
+	modprobe -q dh_generic
+
 	truncate -s 512M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
@@ -118,5 +120,7 @@ test() {
 
 	rm "${file_path}"
 
+	modprobe -qr dh_generic
+
 	echo "Test complete"
 }
diff --git a/tests/nvme/045 b/tests/nvme/045
index b60f18f..1d44c55 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -53,6 +53,8 @@ test() {
 
 	_setup_nvmet
 
+	modprobe -q dh_generic
+
 	truncate -s 512M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
@@ -130,5 +132,7 @@ test() {
 
 	rm "${file_path}"
 
+	modprobe -qr dh_generic
+
 	echo "Test complete"
 }
-- 
2.37.1

