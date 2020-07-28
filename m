Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015EEC433DF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D8320714
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Iitd9q3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgG1KO4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:14:56 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:41078 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgG1KO4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 06:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595931295; x=1627467295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iiIeZiDX1QEz+itBrpo/ZaQ+TXtbtTS4gMusSZY7Kb4=;
  b=Iitd9q3q9KboDMN+GTy3MdFrXMebxoXzSKs87KZr+RSCu8XR+E8F2Q76
   FJp3At5OExS1mHMK83EztNnDNm8JXm+2q0ehzJZIW6TF2kIId21dmPHGU
   RhjOE0nWWOgEhOYvbA5gZRHrVdx6iK6nfNMqo1VovXrPJPxXcIK18AnAr
   I6p2EcD+KVHn5D1q854LqI5PXyhl5g+KlGlTINMYlkKY1O/yqovZV64Z7
   VtjRDR+hB0YDZ8FEO6AUTpHl3hN+9h67Q2R6dQOrDAh61ZlwAIFZSSsfF
   L/wqxt3lICof/pRkriGmmNiBMoK5Rk22+McPPsB7Awk4aXWg6rV2DV573
   w==;
IronPort-SDR: L0sUKBEN/4DupBCROB7kVi9++J+aU7x4ukeh6QwDfTZCADyf7jfDrbI41H+yBlcMO2xs9VTEyC
 US9OSNh4h+zTL8oGANKunZFohPoJrwG4z4gUT6yPI3xBM5xAj9kUxXy68uiqevOvvbwum/Vd+N
 0rIKKA+0yGYFeGM3yupMif52VBK0AlzI8LqbEw4MTr1KoaoQI3o06mGqkB5mjNClZeaiUswJei
 dmPid+FXJijnCFTOBB1DiX92kVJTUPmKz2ZiFSPnlIAFwtWvAM46CAxvXtXCn+50y0N5hiCe23
 ef4=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="143543034"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 18:14:55 +0800
IronPort-SDR: nUr2XRsrua+Qr6gsJRn82FNaThb3mw4+5b8ruiIQAfxuBQMdGJOPVrG7r9drEwVL/eEf0ydHvv
 hl/wfLZZMohEW2KopaMkArBoJndPKzrWI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 03:03:04 -0700
IronPort-SDR: BiQJ9LEb0jPM+eA3XcyO0yyIUCfMdAUXTlDMZTEiYP/+f7W7LQH0SSeYofm1Wh3Gaq4C7tIlDf
 FWIPfg8mQ65w==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.87])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jul 2020 03:14:54 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/5] zbd/rc: Support zone capacity report by blkzone
Date:   Tue, 28 Jul 2020 19:14:48 +0900
Message-Id: <20200728101452.19309-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
References: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Linux kernel 5.9 zone descriptor interface added the new zone capacity
field defining the range of sectors usable within a zone. The blkzone
tool recently supported the zone capacity in its report zone feature.
Modify the helper function _get_blkzone_report() to support the zone
capacity field.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/rc | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tests/zbd/rc b/tests/zbd/rc
index 3124693..dafd130 100644
--- a/tests/zbd/rc
+++ b/tests/zbd/rc
@@ -104,6 +104,7 @@ _put_sysfs_variable() {
 # until put function call.
 _get_blkzone_report() {
 	local target_dev=${1}
+	local cap_idx wptr_idx conds_idx type_idx
 
 	# Initialize arrays to store parsed blkzone reports.
 	# Number of reported zones is set in REPORTED_COUNT.
@@ -111,6 +112,7 @@ _get_blkzone_report() {
 	# to simplify loop operation.
 	ZONE_STARTS=()
 	ZONE_LENGTHS=()
+	ZONE_CAPS=()
 	ZONE_WPTRS=()
 	ZONE_CONDS=()
 	ZONE_TYPES=()
@@ -123,6 +125,17 @@ _get_blkzone_report() {
 		return $?
 	fi
 
+	cap_idx=3
+	wptr_idx=5
+	conds_idx=11
+	type_idx=13
+	if grep -qe "cap 0x" "${TMP_REPORT_FILE}"; then
+		cap_idx=5
+		wptr_idx=7
+		conds_idx=13
+		type_idx=15
+	fi
+
 	local _IFS=$IFS
 	local -i loop=0
 	IFS=$' ,:'
@@ -130,9 +143,10 @@ _get_blkzone_report() {
 	do
 		ZONE_STARTS+=($((_tokens[1])))
 		ZONE_LENGTHS+=($((_tokens[3])))
-		ZONE_WPTRS+=($((_tokens[5])))
-		ZONE_CONDS+=($((${_tokens[11]%\(*})))
-		ZONE_TYPES+=($((${_tokens[13]%\(*})))
+		ZONE_CAPS+=($((_tokens[cap_idx])))
+		ZONE_WPTRS+=($((_tokens[wptr_idx])))
+		ZONE_CONDS+=($((${_tokens[conds_idx]%\(*})))
+		ZONE_TYPES+=($((${_tokens[type_idx]%\(*})))
 		if [[ ${ZONE_TYPES[-1]} -eq ${ZONE_TYPE_CONVENTIONAL} ]]; then
 			(( NR_CONV_ZONES++ ))
 		fi
@@ -150,6 +164,7 @@ _get_blkzone_report() {
 	local -i max_idx=$((REPORTED_COUNT - 1))
 	ZONE_STARTS+=( $((ZONE_STARTS[max_idx] + ZONE_LENGTHS[max_idx])) )
 	ZONE_LENGTHS+=( "${ZONE_LENGTHS[max_idx]}" )
+	ZONE_CAPS+=( "${ZONE_CAPS[max_idx]}" )
 	ZONE_WPTRS+=( "${ZONE_WPTRS[max_idx]}" )
 	ZONE_CONDS+=( "${ZONE_CONDS[max_idx]}" )
 	ZONE_TYPES+=( "${ZONE_TYPES[max_idx]}" )
@@ -160,6 +175,7 @@ _get_blkzone_report() {
 _put_blkzone_report() {
 	unset ZONE_STARTS
 	unset ZONE_LENGTHS
+	unset ZONE_CAPS
 	unset ZONE_WPTRS
 	unset ZONE_CONDS
 	unset ZONE_TYPES
-- 
2.26.2

