Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05EAC07E96
	for <linux-block@archiver.kernel.org>; Tue, 13 Jul 2021 10:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C8346127C
	for <linux-block@archiver.kernel.org>; Tue, 13 Jul 2021 10:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhGMKPc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jul 2021 06:15:32 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:23428 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbhGMKPb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jul 2021 06:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626171162; x=1657707162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=42Cpn3a1d7C3u8yTHao+Gwvp5aZGeSNxtykwiIrnhfM=;
  b=TihL5W708jqauRR/PzzOPz7wZMWABvwNaIkSqv5JsG9VZJxAqWKWTQ2i
   cImyErae9xwbGuSJn1DzoNp/lg4SGFzkFh765v/QeukZF5LTZ1kZWGCfe
   1rWanoaLTDwYiiFstqx1MbbANmbZTCztrVjlDoqI1efl9sjQaTwavl/P9
   XcKKeEHWZu4Nn+0JAjzCabLhzHJ2/AYHcg7zqxDZkWe7RA+dT9Cxq3UpQ
   kggYw+esiPQUgZsGCEBdAO0A/+ahhJarn66FyibQgDXY4Wfqd8ewEs7/h
   KFdATMC2CkgmIVuzO0sLX4FyGXJHHr0xJs30qRHovhXVVlmRb0NVpzJOk
   A==;
IronPort-SDR: 9dZvRYv9TU9L8BkkRZgSTSkZbHFIqxmtnbG2A/hYrgRTWobiVOXGyBX+mpj1ccpTqg68LOohfA
 D/Is2C3CGFCctIDAk14Rff+8Ev//kwJ7DVKzwk1Qrz9H/cYIOxMPh9iVFtBmbyt69+5xQ6A8dt
 HkE2eAbqRCZ1msUGx8kHA292LzYZXOrFpjPmFaV8/wsJTOsDsHx8olefDbyoNukDyu8M/yqUAb
 VHL4OfuNBPAz//S4MOQI+bhHUxM16qFW59wDiIAcaQkB5uOLIUdDEUk7hTrLQ2utnEJlzlQjmL
 dis=
X-IronPort-AV: E=Sophos;i="5.84,236,1620662400"; 
   d="scan'208";a="173685550"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2021 18:12:42 +0800
IronPort-SDR: Uxhpwtn8p1XJncbqLTUFK1mGHQZjl/T+bkODYUKZXiIHxQQYasW5PALRJn4XGO5q9HAqf4uPGR
 G3J8QLsLZc8H81MNTTI+x91OJJyYiRtcwo83SR/+PYKa7j8qMEW/eyH+8dNEmDZZX/j1tsb+K/
 eRAnoTF8BzsqpTh/VhUne7556+ICrxkmLH/dXvriVG4Twz7Mggm1UxI2ub4+7g0iWzjIiCZHIb
 UaA6fvq0I79dX/mC3WwLwaubJsEOWGaU0fJVjlyzFM9IddHV1IY8dukshzoFOyq1CxKxh3l1fI
 7Asd8/2CHsJTQwMuHZLv2XNV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 02:49:25 -0700
IronPort-SDR: 0OVrERysPshwG6ZuKAxsLHdd96RqgelOcilK1ymFY7JO/YtdDSBfVAqQ7etSQHF2yfoaUfYSfn
 86wv5kX1M7aj50I2OEnrvkrnXhRdCvL1oAenTfngwgg0lPqLmS7DwBlt16C0/W0R5wWxI+s9Pl
 FikxvfaXB+U/uRVD7lEKul713Dh+juUDZlvb7x9WkbEcSxROxlXlDfGglK7x2wgq1KwZoL636J
 u1FGPUvLG+SiJgpIOPy5QefFRgsQCdd88ItK9oVyE4xEoJGapX0J5eE/jmp60ZIfxinVK6rsCL
 Mf8=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2021 03:12:42 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/2] zbd/rc: Support dm-crypt
Date:   Tue, 13 Jul 2021 19:12:38 +0900
Message-Id: <20210713101239.269789-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210713101239.269789-1-shinichiro.kawasaki@wdc.com>
References: <20210713101239.269789-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Linux kernel 5.9 added zoned block device support to dm-crypt. To test
dm-crypt devices, modify the function _get_dev_container_and_sector().
To handle device-mapper table format difference between dm-crypt and
dm-linear/flakey, add dev_idx and off_idx local variables.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/rc | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tests/zbd/rc b/tests/zbd/rc
index 1237363..9deadc1 100644
--- a/tests/zbd/rc
+++ b/tests/zbd/rc
@@ -327,6 +327,7 @@ _get_dev_container_and_sector() {
 	local cont_dev
 	local -i offset
 	local -a tbl_line
+	local -i dev_idx=3 off_idx=4
 
 	if _test_dev_is_partition; then
 		offset=$(<"${TEST_DEV_PART_SYSFS}/start")
@@ -340,13 +341,19 @@ _get_dev_container_and_sector() {
 		return 1
 	fi
 	if ! _test_dev_has_dm_map linear &&
-			! _test_dev_has_dm_map flakey; then
-		echo -n "dm mapping test other than linear/flakey is"
+			! _test_dev_has_dm_map flakey &&
+			! _test_dev_has_dm_map crypt; then
+		echo -n "dm mapping test other than linear/flakey/crypt is"
 		echo "not implemented"
 		return 1
 	fi
 
-	# Parse dm table lines for dm-linear or dm-flakey target
+	if _test_dev_has_dm_map crypt; then
+		dev_idx=6
+		off_idx=7
+	fi
+
+	# Parse dm table lines for dm-linear, dm-flakey or dm-crypt target
 	while read -r -a tbl_line; do
 		local -i map_start=${tbl_line[0]}
 		local -i map_end=$((tbl_line[0] + tbl_line[1]))
@@ -355,10 +362,11 @@ _get_dev_container_and_sector() {
 			continue
 		fi
 
-		offset=${tbl_line[4]}
-		if ! cont_dev=$(_get_dev_path_by_id "${tbl_line[3]}"); then
+		offset=${tbl_line[off_idx]}
+		if ! cont_dev=$(_get_dev_path_by_id \
+					"${tbl_line[dev_idx]}"); then
 			echo -n "Cannot access to container device: "
-			echo "${tbl_line[3]}"
+			echo "${tbl_line[dev_idx]}"
 			return 1
 		fi
 
-- 
2.31.1

