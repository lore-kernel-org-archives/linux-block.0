Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55299C433E8
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A1420714
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OM5UzqqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgG1KO5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:14:57 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:41078 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgG1KO5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 06:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595931296; x=1627467296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WgMqeRKEoIHGJ6rjL4jdAWTvtm4BC32GS5ByI4+Z8qY=;
  b=OM5UzqqB/ENm8hH0qsx/obSqnoAZLLwZROqkqq7hoBXvSnU2n/JUUJMT
   EMB3dvONAzLSp+WG5Ek16KMpz+MHFm1wu+sCUgCsILzszYaRJ9bcD8Ij0
   N0BKZ61dY/07HLcQq+iyPGnKL7nuF4MhdpeWjPbtofXiWJE0X9dpCP6r9
   1dGvf9zpbuPIkgdGoAkSJAevLEGdOpmAuJ6JIqBrerVkekp5CU746AJsj
   BPeBS5Q8M0v5HvViWnhbW66bteoWP0QfDF5ocJEOeJEEXMdQ6ObZ1Q4a9
   VGq7qzMzeTkNYeYc8EBHJ3hcFyqbKPCAi3xkCM3FsLFBzxCsZLeTtCux/
   w==;
IronPort-SDR: RV1atcyY9chgb4Q6jNsokWQYEL4F1PbcBB4ksGmcqyYUf5Dz0PnUuOZ+W5bg+LpoDKNbN10oKg
 sq2c5YwpI4CcIxhecnXNIwhfMcsm14MfjyOOQL3sYEv/zmP88HaUEEjef7zCOekHUY4tkVy/BD
 kP9NTZZ6WwKACu9CCPHQdwTJn4UX370W+ty6H6+RuS2GKaI9AFS0CBMl915/F+kSEi7L2I09yO
 +bFhiLrN2pm0lgU5aKHG+1W7gsXHMWYJpETxWiKRMRD1SaTkYDAC8rWqyxTPaSis4+UynOTDze
 pDY=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="143543038"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 18:14:56 +0800
IronPort-SDR: ZksTMZDXgkUgJwjc4rvF3ctY4oAakDFfThCDZr0VklB/JPNG6ViPK4/6atm4HW97rS5pXg0N/R
 Y7PkvmbRxQ8vTuGYJ9CwBxOidb/sI3NAY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 03:03:06 -0700
IronPort-SDR: 4Tij4hoF8bW/jnJgVUDVvGT/r+1gfnsqS+VHR7wiIZ38A87ALBOxwKwsbUfRR5yf1vJGxGNo5L
 hva4TlhtUJ9A==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.87])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jul 2020 03:14:55 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/5] zbd/002: Check validity of zone capacity
Date:   Tue, 28 Jul 2020 19:14:49 +0900
Message-Id: <20200728101452.19309-3-shinichiro.kawasaki@wdc.com>
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
field defining the range of sectors usable within a zone. Add a check to
ensure that the zone capacity is smaller than or equal to the zone size.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/002 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/zbd/002 b/tests/zbd/002
index e197827..a134434 100755
--- a/tests/zbd/002
+++ b/tests/zbd/002
@@ -24,6 +24,7 @@ _check_blkzone_report() {
 	local -i cur_start=${ZONE_STARTS[0]}
 	local -i next_start=0
 	local -i len=0
+	local -i cap=0
 	local -i wptr=0
 	local -i cond=0
 	local -i zone_type=0
@@ -50,6 +51,7 @@ _check_blkzone_report() {
 
 		next_start=${ZONE_STARTS[$((idx+1))]}
 		len=${ZONE_LENGTHS[$idx]}
+		cap=${ZONE_CAPS[$idx]}
 		wptr=${ZONE_WPTRS[$idx]}
 		cond=${ZONE_CONDS[$idx]}
 		zone_type=${ZONE_TYPES[$idx]}
@@ -70,6 +72,13 @@ _check_blkzone_report() {
 			return 1
 		fi
 
+		# Check zone capacity
+		if [[ ${cap} -gt ${len} ]]; then
+			echo -n "Zone capacity is invalid at zone ${idx}. "
+			echo "capacity: ${cap}, size: ${len}"
+			return 1
+		fi
+
 		# Check write pointer
 		if [[ ${wptr} -lt 0 || ${wptr} -gt ${len} ]]; then
 			echo -n "Write pointer is invalid at zone ${idx}. "
-- 
2.26.2

