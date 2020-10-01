Return-Path: <SRS0=e+pS=DI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BAAC4727C
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 10:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40912137B
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 10:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qXHNr4/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgJAKPe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Oct 2020 06:15:34 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:12424 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgJAKPe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Oct 2020 06:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601547333; x=1633083333;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xJm7z9TzYBkCPJ7NV7YeKx70AkFEcFO6TH2WrQr2Pm4=;
  b=qXHNr4/RdxMlnlz7cp0vFuO7QhO4m1AlHYFFA2e52bz705LJPVO06O2Z
   X3mCsmYVFV1KmNt4DDMzpSOypWLwa20QeZiNlCuMAJ5Jje9/qW5tjkYre
   p0nZgZl8Y7RkAgP/J5KuWpQ8xTVVPDHGW8YO6r5SsQ3ZvPzU8daFdjPVk
   Inn/BfqPrNu4DCQaR2liku4+gueXDn+0LFS03kLoG4CxU//pUVaL4kn9Z
   7uyXll5blaK1UYVR7OZWHaurSfGwj9f3ti9GyHOD7/OfPiscROaXtp0al
   dsgDyVXQqSvMONkUGXzdCUWeTZDaxhw+uRT5EVZratieUmaRr7u430HCM
   Q==;
IronPort-SDR: xWm4wT+1Je1XO60rxc2WcUyDrJMShptskagjBnTuWhJbL7wFQ6GYS6Aduic+aMky85SZtkaX2r
 jpYEdeL/cltvkFBN/8qMIsTcQ3ksHUHPcczqjdMqhfsoO0H5m/Z9n69WNw3lK5Ma0XqzhRqaQF
 Uvr4luUPpbtH8nfpag+MaSVpRiK4W28bTAeblJn18B2ZtweDo7LDM5E9VApZDIswga5a+FPV0r
 AZG34oFv14YpH6YmA55FcBsd4kIOVdnD57uFvKyBBgVPAEVmXnqBwA0779vyyT/9fKDc+H0HAs
 ILA=
X-IronPort-AV: E=Sophos;i="5.77,323,1596470400"; 
   d="scan'208";a="258516725"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 18:15:33 +0800
IronPort-SDR: UIiFVBsOE3U5ZSN+Jjv5iVC7qXSGl298QZXYnFOzxAcf29xtdecA8Si5PsNW0Ls54fXOJML2KC
 sZHZ4XRjrcMQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 03:02:25 -0700
IronPort-SDR: flxVdlj1eGlod9hErPz6TQnKW6zJs2vtizj3ybsK9bzRtRtl4q2KPFDffWP53uWIDvvVW5mC15
 iTk53opGz8fA==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com ([10.149.52.189])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 03:15:33 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/3] Support max_active_zones
Date:   Thu,  1 Oct 2020 19:15:28 +0900
Message-Id: <20201001101531.333879-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Linux kernel 5.9 introduced a new sysfs attribute "max_active_zones". It
is an attribute of zoned block devices which indicates the limit of zones
in open or close status. When zoned block devices has this limit, test cases
block/004 and zbd/003 fail since write operations in them open zones and the
number of open zones excceds the limit.

This patch series addresses the failures. The first patch introduces a
helper function to get the max_active_zones value. Following patches modify
the two test cases to avoid the failures.

Shin'ichiro Kawasaki (3):
  common/rc: Add _test_dev_max_active_zones() helper function
  block/004: Provide max_active_zones to fio command
  zbd/003: Reset zones when the test device has max_active_zones limit

 common/rc       | 8 ++++++++
 tests/block/004 | 9 ++++-----
 tests/zbd/003   | 5 +++++
 3 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.26.2

