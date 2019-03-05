Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F34C43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 05:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1544820684
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 05:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SVYfuIfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfCEFZI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 00:25:08 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29725 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfCEFZI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Mar 2019 00:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1551763508; x=1583299508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MiZZeTqu+1kJzRl7EGsiCbJmhOI0dS6PQbZ9+5e6sPs=;
  b=SVYfuIflS8fTRbBL57+2TNquD5ozgYowMmkpKCyFs5qzjY1wiIAmFQkI
   qQYYSOfKn/kG5he6W9qmhGPNKgeSKfzd2RqkFLqYXc4oFgr3UxnxkkHth
   IAqY04N2mualWvQvLuvQG6Wg0R18+1I3eXtNsZyqIPoYLUzbaogymxnd2
   lrnPI7qNHFF8/fK089Wibjz6dlNG+VzhRH8sT0CCooFEvF2t/rBOjbD+q
   Bs7uqXiVeX3kHHCI2mHXM0qABGD+5CMZvUd7SJdfxGieG0p5fpB6mvNYT
   p0VzdnuCk97ROPr8j8ewToPHPePUWwgmBMLV0pSA1JzbSkEOPsMi49w6s
   w==;
X-IronPort-AV: E=Sophos;i="5.58,442,1544457600"; 
   d="scan'208";a="104040565"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2019 13:25:08 +0800
IronPort-SDR: PyEfEix1mlHtV5Wmi8CjKUTn2xekBr2d8NcaN7NOu66Hf2H9JdRya7SOavhY/il79vvUcXe9u/
 whH4lpY4lGqBOL9uMg9HpDZbSZYIxVArVpgpWMNqAi6Rwrjm2PQ9fOAWetK+KO/ZJC2TDUbrGE
 VhMTDw7VyaQddWTkgXBzLdsiNKKT+xniXdn8PgplPYouvjsVfja2vM6p2dOe3N3pugVakMKdmc
 UVdXMeWM/JitF3W3ZALzh8y/AuMkXh80NpP2kthgZhbJmorC6ozENGQdZY0AWDGp1Bk5UDJqV7
 DCLkloPA06jgX2nnBF6879li
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 04 Mar 2019 21:05:11 -0800
IronPort-SDR: Zom28rTANRXTDxVaTFHhMzyCHsWiv6/JqNVBGCoMhUlJZUsAmqc01FLh1eVTEjXVyqRH7KgBLQ
 XphV9JpgZKduVPxNiryzqLPKIGiL+9MlxrXM0wDb4izz5Qs55GHB8Cj4kmwEm9hB/J3RQENuAM
 MvlDSZV6HxVcox0zBZ1aPZnyvH7alry23SLmxVXDXwk/P5zL3xpXczzpubjoQbnc0Eoadpou2X
 TZGBZNt2ZO+nX/vQ6BLIuLLLO2kLx6JfE9071CyyQ5dd4jkmAngnh3y7Z6H3Yyzey+m563dFLh
 Orw=
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Mar 2019 21:25:07 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Masato Suzuki <masato.suzuki@wdc.com>,
        Omar Sandoval <osandov@osandov.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests 2/3] common: Add _test_dev_is_partition() helper function
Date:   Tue,  5 Mar 2019 14:24:46 +0900
Message-Id: <20190305052447.24291-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190305052447.24291-1-shinichiro.kawasaki@wdc.com>
References: <20190305052447.24291-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To control test conditions unique for partition devices, introduce the
_test_dev_is_partition() helper function. Refer TEST_DEV_PART_SYSFS
variable to tell if the TEST_DEV is a partition device or not.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Omar Sandoval <osandov@fb.com>
---
 common/rc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/rc b/common/rc
index 153a323..0c354a2 100644
--- a/common/rc
+++ b/common/rc
@@ -208,6 +208,14 @@ _test_dev_in_hotplug_slot() {
 	return 0
 }
 
+_test_dev_is_partition() {
+	if [[ -z ${TEST_DEV_PART_SYSFS} ]]; then
+		SKIP_REASON="${TEST_DEV} is not a partition device"
+		return 1
+	fi
+	return 0
+}
+
 # Older versions of xfs_io use pwrite64 and such, so the error messages won't
 # match current versions of xfs_io. See c52086226bc6 ("filter: xfs_io output
 # has dropped "64" from error messages") in xfstests.
-- 
2.20.1

