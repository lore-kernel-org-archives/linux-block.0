Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D8EC433E1
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551A3208E4
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M6dMKEZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgG1KPB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:15:01 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:41078 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbgG1KPB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 06:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595931300; x=1627467300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZcX1U0dicMsZFqsUVHG9A0vjQGjfz0c8b1BKlzUqbgI=;
  b=M6dMKEZKk8g9YrR8woRNBiPMPKWg/O/cpHWAvjGdJxiXbg8YD0aUxgLV
   dbJrVjhu0KpmpORzIoadr8ZoCOAD14ypljeTAaT12G3JzRvHUQyKVova2
   U3dlhJXs/xrZKbNhF/LPNJt7ObF2SXBweWX1OstPOY86UZcvR+vF8Kc4c
   V3FU7WTlkhMQFDL5aZvZvP19eeCB3w/P1EaIP3aVdqbZaoq8WDnY+iJ5o
   fR5/JHvO95w33hIfGg+8C5itZ3QiU26EDyMDe4nz1BJAjcgQN8TL6nnNT
   wga/3bAbPRhE63Q/y3bod/eoIp+gSgMDnYbV8q1ei45HJMqlTyPaB8UK9
   A==;
IronPort-SDR: F1Kjvf0Ib42HguajpnU3EpJOvoRXbGgM+lDRRYhDXyFdfcZgJ36cvzjt5waUPtXe4xk7GynpGD
 NPakfYW355dqoVKtDZ6wSFTcfbQZGRx5IhirWxSNduv8R4GNpJE5P6/pATnBlmaYLJhda7uVTe
 9wgqqNMUulXTpjHWyrzlNzB+qt7Ed05ddH0BkjnH2rUPJZUT/1Flimacdqtp21E3kCGdNy5Ysf
 PB3eCtgYlprPiigLWI6LwMfMdSazVzPqn0DJdydgb2m4OHMdMNPS+LsWdq5HS9WqMcpxyiRw10
 QbA=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="143543054"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 18:15:00 +0800
IronPort-SDR: dtjt41vwN2fdqWmxMdRAkAW2j/FV43FFy4zIaZ7/7voTr3nSeVIVb1PxFatxzQ/EWwfmH5Yx5t
 8AWrIoRn5FvUX0zAHaLxQpGEG19tDVxUo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 03:03:10 -0700
IronPort-SDR: xK/DDdeIf1J4nw7AkynUmiAe6Cs4Bro2iIYXewuWxxH+WDF28YgjLgtKIfU1z8WjdqZmRquj4Z
 HgYDtHXNFNYg==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.87])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jul 2020 03:14:59 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 5/5] zbd/002: Check write pointers only when zones have valid conditions
Date:   Tue, 28 Jul 2020 19:14:52 +0900
Message-Id: <20200728101452.19309-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
References: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Per ZBC, ZAC and ZNS specifications, when zones have condition "read
only", "full" or "offline", the zones may not have valid write pointers.
In such a case, do not check validity of write pointers.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/002 | 7 +++++--
 tests/zbd/rc  | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/zbd/002 b/tests/zbd/002
index a134434..39c2ad5 100755
--- a/tests/zbd/002
+++ b/tests/zbd/002
@@ -80,9 +80,12 @@ _check_blkzone_report() {
 		fi
 
 		# Check write pointer
-		if [[ ${wptr} -lt 0 || ${wptr} -gt ${len} ]]; then
+		if ((cond != ZONE_COND_READ_ONLY &&
+		     cond != ZONE_COND_FULL &&
+		     cond != ZONE_COND_OFFLINE &&
+		     (wptr < 0 || wptr > len) )); then
 			echo -n "Write pointer is invalid at zone ${idx}. "
-			echo "wp:${wptr}"
+			echo "wp:${wptr}, cond:${cond}"
 			return 1
 		fi
 
diff --git a/tests/zbd/rc b/tests/zbd/rc
index 3fd2d36..1237363 100644
--- a/tests/zbd/rc
+++ b/tests/zbd/rc
@@ -41,7 +41,9 @@ export ZONE_TYPE_SEQ_WRITE_PREFERRED=3
 export ZONE_COND_EMPTY=1
 export ZONE_COND_IMPLICIT_OPEN=2
 export ZONE_COND_CLOSED=4
+export ZONE_COND_READ_ONLY=13
 export ZONE_COND_FULL=14
+export ZONE_COND_OFFLINE=15
 
 export ZONE_TYPE_ARRAY=(
 	[1]="CONVENTIONAL"
-- 
2.26.2

