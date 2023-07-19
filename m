Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0230FC0015E
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 07:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjGSHPV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 03:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGSHPQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 03:15:16 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E693E69
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 00:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689750916; x=1721286916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VyX0+ZkhZwbxaoy8Ni9gLqUxYr9nhG9rSMR/Z0bCLVE=;
  b=Sqi15MSd4TgAJcJd/eEkv/hxskQXyr2548h6Ea0dLq5b1JY73S1Hs/8P
   zURlJZaJkg+D6YnGty4PipsXHjoa0g+d1XBF/G4VJPP4RD3spRUdES+2a
   spe15m3OrRd3XXZ8stpT+Zmo1SrpTMBZQQQNJNzgJdiCOKiFvNl1p8G9u
   /v5CyC7XzqS3yl4zBY0ARz8fuzoMQarEwv6846MnwqdHGvzqzbkc81byK
   1Nd0ypcGrP0UhyuBUF/oo50IKcRGrzHep7qwWQV/PUE7D6mEPA1XtD/8G
   kZ4hLWhjPJTGp5113Iv7GwIJQ8UB+h/RK9zyU44ugVETma+R6Ye2GfxGl
   w==;
X-IronPort-AV: E=Sophos;i="6.01,216,1684771200"; 
   d="scan'208";a="238846520"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2023 15:15:14 +0800
IronPort-SDR: WvE+zokGfQzTWmwLyXkU0eso/YjdjLFeNXnNrPwAeuN9RQvXaWn0UiRx4YV0BBiPM25EKOP2pM
 brkc7gZVxlsemy3sHOr/Tbwa/kag6S6TdPbrhJQrXsAvvzEyVOy40DF7uVvrjYdK7vwEsoD/5E
 x2Yw2wIVrGKIcpwGafw8+dspTKlfbv6i30lRgtRgwgfxgg4oFM8XLiMfKuZ4Ox4fmpnmrKg97t
 k5fKPo89ZS8yM9O9np9oRnsas47309vWaon9zqWGy7CBPbWQNOlQnBXEirfNGWA1WFeiF/PlJ7
 Hhs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2023 23:29:06 -0700
IronPort-SDR: BGvZT+FmYj2MvNoVpYe2D3ZBqFamJYiexF3pvis6kJSpHXmVfvQ19v9K9ZyWC+eRwom4s7+rFF
 KcRph/eVVWZyF+mqnG5NS4A93Nmp99EfP6vsA5z/Nap0vcapR0yhKeqX/ETEQf1/NNMk009vIc
 NNLPQW2VASeXfO4AIkEnON7cVnKVQK+FM8bpO6BQdMDq8koooihohHaGV9RxIZngL3O7frc3UN
 QkErpzFxDm3T3aNPDcl0VPtZtWfMyyjdptZE4Yyogmejf+OMgAf6droONeI/fkeefy8TQUT917
 25I=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jul 2023 00:15:13 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 4/6] common/rc: introduce _require_test_dev_sysfs
Date:   Wed, 19 Jul 2023 16:15:08 +0900
Message-Id: <20230719071510.530623-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719071510.530623-1-shinichiro.kawasaki@wdc.com>
References: <20230719071510.530623-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test case block/005 requires TEST_DEV to have the queue/scheduler
sysfs attribute. However, kernel no longer provides the attribute since
version 6.5. Add the helper function _require_test_dev_sysfs to check
the requirement.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/rc b/common/rc
index 52d1602..caaa49c 100644
--- a/common/rc
+++ b/common/rc
@@ -256,6 +256,14 @@ _test_dev_is_rotational() {
 	[[ $(cat "${TEST_DEV_SYSFS}/queue/rotational") -ne 0 ]]
 }
 
+_require_test_dev_sysfs() {
+	if [[ ! -e "${TEST_DEV_SYSFS}/$1" ]]; then
+		SKIP_REASONS+=("${TEST_DEV} does not have sysfs attribute $1")
+		return 1
+	fi
+	return 0
+}
+
 _require_test_dev_is_rotational() {
 	if ! _test_dev_is_rotational; then
 		SKIP_REASONS+=("$TEST_DEV is not rotational")
-- 
2.40.1

