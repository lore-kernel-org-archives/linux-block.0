Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2556C433E0
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 00:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8221A22227
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 00:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgL2Apm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Dec 2020 19:45:42 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59439 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgL2Apl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Dec 2020 19:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1609202741; x=1640738741;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AQnJaMJuiLlSLJQ0EQJ3Tf3ANt/gvfjdD/up11jWM4g=;
  b=U3Dux2eCGFuQpAKxj91q0Y3zeqt+uo0MW4TkLcXCsHK7R0paQe84nN9D
   KfyoqkTEn43TnUm9Ukt+kAhusWIXPTvwJY7zmBeWedRF1dX8QNz24aFUM
   JQZmtHtdt+GSxncy48Qhz/lbK96DpuzbfRMT1lNevk2RIXZcUibOPDdu5
   Hk6BXpFOFXjP9hsMExya1SZ1jW3IhMsLs2JcGBz6RuJdTVFQ+2+hRwRdQ
   xiRf7A6CRXI+Ip2JabjKWtpAJcg8BiPKSphz2MBz8l5Cg3nxXqZO61muN
   tWR5l67TBxqQDKQgm8DzqIA3CiF56WBAt2ZikJbGA8/FjHb4imfTqKK3/
   g==;
IronPort-SDR: d7VZMgRzRYdm4XP24/P8zNAVWzhUSu7g9f7706hWYzmW7v9dk42r7fX93W4eMlB+afHDtO2sH3
 jiRccjglgvs+9cU6/u5WKG8uOfXyLel/gif0OnhF2oDdKJRIfWYBEeF3UpEsIRegTnaNm6YCQ6
 V6YWXNpCrAv25db45xKQu43oRxUyA7im35kQH2am/O3PwvgY8bi9doNAVfxZ/E+Gr2hWyTClmN
 scXLs+YZqeqxtdX0RJ0M7R2IhJISY5yx9fTWvTmOK8ntyCUz6DaYtL4bwKTIs/6CBp4KG3k8LY
 JOE=
X-IronPort-AV: E=Sophos;i="5.78,456,1599494400"; 
   d="scan'208";a="156192848"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Dec 2020 08:44:35 +0800
IronPort-SDR: Iyfnu8vf8orGQJOmPcMBaMZxDT6OVzJKXD14HA/MiotqR3cgoPuF0n4SrEEaAWLvsq5SKguIT1
 ApIRg8v+AQRt74BYuSBStDC55dRnx7p9U+9bzabop7a2ZDLYx7B7yTLfpPTUatbsOUMy+ZThNK
 zv3hF0GQ9plm2I63muqMYCA2Cztuvv+gT6erepz5FHtBQbM5nwNSNKoIa5igIK/HLNrRzQrrW2
 40ze+nJH0axpZn7dZ3MZhm7bealraBt67+By9qP5bZU6noxiUlclxdsAXmgxA7m+nkeGWd3be9
 muXr0epYBC6inNk88roQocCY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 16:29:38 -0800
IronPort-SDR: JSnHYOiiO5Mb672+ngAy3QppjaLylXYo2m+VcXD33GymLxlu69uIe/LMzi8zS4bBnvM8lE+DqF
 MBdOtaUq++3Ti36+vwPOQt/u/Cvy2oqkmRddrYmbo1TpliDbBXQYLqEn3Rhq2PIs2459mKsIZN
 IWSA5hycDwUEziI8bWjE42EXaK134EJZMmyHI4Y8pl/9cbwfipdAIwF/KH65OojE77Vj3IilpJ
 yRyI30glAPQiq2Zxp3SKrpja+CCQXMTdaLruUsUdwdeW8VxaWkZIrVN78Mv1hfzPDbLrCBFCoo
 ba8=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com ([10.149.52.189])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Dec 2020 16:44:35 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3 0/2] Support max_open_zones and max_active_zones
Date:   Tue, 29 Dec 2020 09:44:32 +0900
Message-Id: <20201229004434.927644-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Linux kernel 5.9 introduced new sysfs attributes max_active_zones and
max_open_zones for zoned block devices. Blktests already handles
max_active_zones. However, max_open_zones handling is missing. Also,
zbd/005 lacks support for the two attributes.

This patch series fills the missing attributes handling. The first patch
modifies the helper function for max_active_zones to support both
max_active_zones and max_open_zones. The second patch modifies zbd/005 to
handle the attributes.

Changes from v2:
* Added Reviewed-by tags

Changes from v1:
* Reflected comments on the list
* Added Reviewed-by tags

Shin'ichiro Kawasaki (2):
  common/rc: Check both max_active_zones and max_open_zones
  zbd/005: Provide max_active/open_zones limit to fio command

 common/rc       | 19 ++++++++++++++++---
 tests/block/004 |  2 +-
 tests/zbd/003   |  6 +++---
 tests/zbd/005   | 13 ++++++++-----
 4 files changed, 28 insertions(+), 12 deletions(-)

-- 
2.28.0

