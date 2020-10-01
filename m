Return-Path: <SRS0=e+pS=DI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83330C47420
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 10:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2124420838
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 10:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y6dTUh+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgJAKPf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Oct 2020 06:15:35 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:12424 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgJAKPf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Oct 2020 06:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601547334; x=1633083334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LuItoBUpj2iUBhvJo6LKYvNcMYQxVP2fOX0Ya2+m6zA=;
  b=Y6dTUh+A1tctBfhrmLQ8EVoHnpKHSc3N0l0b+5T8ISG4478hOuVw2K8d
   oakmsUjce7+1oriHBFb9NhWzTYa6ZaGcTCwqcmX0b4Qy10c9QhbXOvqAw
   kwM/FpiXv/+JuT6suaumuSc8hRfSHTOVYfzj2RYQ8JwIhrEhgJ1ur9QbK
   iDfC9D715uk7NaHk1eVhdwwx/JxjvpqBkd84aacERuJW+yD0mVLHGjen9
   dBzqvFHhkQXjZ7RaG3SDLMFP6433ccK4d4TWklyHQnsOO//2HuBD9BYoe
   zFIRyxO8Mbbu+LAbZI7IQj7DCXS7y8DXDBcouwH+9ZQJ25KybKE7NQgUg
   w==;
IronPort-SDR: DWXNMgaGFoPAQ/OoX4zVDnHa+bYeB/LfSCZmWjcJerZr5UOLgtRjfIAuLF2YnBLwEYdVWrY/MY
 qyn8P+uPMJt/TFmLvufFHT2mzgXc7xmbcHNM+hB5KyvN2+uxwCOQCIPW04QiAA9kGEq0oUdicf
 HLHGMM/8yQWw+21mPnz5gdotHK444W6haPaRqk9bDUCmYgMogs8vMExh/oNTS9I+vYp6vM+BzF
 7Z/eB2XihJ/LEq1NrjQWAFljLSz/5ZnkqcGqp5zx8gqvyEBvAogaVCQfImwJ+y5ZJTJjueVpx2
 B3Y=
X-IronPort-AV: E=Sophos;i="5.77,323,1596470400"; 
   d="scan'208";a="258516731"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 18:15:34 +0800
IronPort-SDR: t3rBKHh1HP9CcaY1lghxK3zIYNk6WoXqQ9KTkJaYpuXi1AUhjjQdAXhZLzUmNsgfNoiIQK1odA
 MPZbn0MasI+Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 03:02:26 -0700
IronPort-SDR: bNAbVeLcLAykyjLhlQV5f3ef6R92c3BnKo7GrmhggytLnYYLH8e/ERNKGH/NXmmj0NQ4HpHau6
 PH85+Y9MNyfA==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com ([10.149.52.189])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 03:15:34 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/3] common/rc: Add _test_dev_max_active_zones() helper function
Date:   Thu,  1 Oct 2020 19:15:29 +0900
Message-Id: <20201001101531.333879-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001101531.333879-1-shinichiro.kawasaki@wdc.com>
References: <20201001101531.333879-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Linux kernel 5.9 introduced a new sysfs attribute "max_active_zones". It
is an attribute of zoned block devices which indicates the limit of zones
in open or close status. To refer the attribute from test cases,
introduce the helper function _test_dev_max_active_zones(). If the
attribute is available, the function returns the attribute value.
Otherwise, returns 0 to indicate that the device does not have the limit.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/rc b/common/rc
index cdc0150..0589431 100644
--- a/common/rc
+++ b/common/rc
@@ -272,6 +272,14 @@ _test_dev_is_partition() {
 	[[ -n ${TEST_DEV_PART_SYSFS} ]]
 }
 
+_test_dev_max_active_zones() {
+	if [[ -r "${TEST_DEV_SYSFS}/queue/max_active_zones" ]]; then
+		_test_dev_queue_get max_active_zones
+	else
+		echo 0
+	fi
+}
+
 _require_test_dev_is_partition() {
 	if ! _test_dev_is_partition; then
 		SKIP_REASON="${TEST_DEV} is not a partition device"
-- 
2.26.2

