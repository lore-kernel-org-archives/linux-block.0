Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42A5C433EF
	for <linux-block@archiver.kernel.org>; Wed, 11 May 2022 03:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbiEKDBY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 May 2022 23:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiEKDBY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 May 2022 23:01:24 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E0B06220D
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 20:01:22 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3Af3iSF69rQh2mg5z1dFUoDrUDunyTJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUoqhmACyTYYWWyBMvjeZTegKtgnO4u1oEMA7J7QnNU3SFdlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4Ef9WlTdhSMkj/vQHOKlULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt8F4ztpd856hY?=
 =?us-ascii?q?Qk0PKzQg/lbWB5de817FfQcpOabeibi4aR/yGWDKRMA2c5GC1o/O4Ef5M55Cyd?=
 =?us-ascii?q?F8vlwACEMKAKDjuS56Ki2RullmoIoK8yDFIcevGxwiDvdCv0laY7MTr+M5tJC2?=
 =?us-ascii?q?jo0wMdUEp7ji2AxAdZ0RE2YJUQRZRFMU9Rj9NpET0LXK1VwwG95b4Jui4QL8DF?=
 =?us-ascii?q?M7Q=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ArtcioK+f8gMtmEdP5Ipuk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124143658"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 May 2022 11:01:21 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 07A014D1716F;
        Wed, 11 May 2022 11:01:21 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 11 May 2022 11:01:20 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 11 May 2022 11:01:19 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <osandov@fb.com>, <yi.zhang@redhat.com>
CC:     <linux-block@vger.kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH blktests] Documentation: Fix typo nvme-trtype -> nvme_trtype
Date:   Wed, 11 May 2022 11:00:59 +0800
Message-ID: <20220511030059.205953-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 07A014D1716F.A4F75
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fixes: 3be78490def5 ("Documentation: add document for nvme-rdma nvmeof-mp srp tests")
Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 Documentation/running-tests.md | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 713d7ba..586be0b 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -103,12 +103,12 @@ RUN_ZONED_TESTS=1
 Most of these tests will use the rdma_rxe (soft-RoCE) driver by default. The siw (soft-iWARP) driver is also supported.
 ```sh
 To use the rdma_rxe driver:
-nvme-trtype=rdma ./check nvme/
+nvme_trtype=rdma ./check nvme/
 ./check nvmeof-mp/
 ./check srp/
 
 To use the siw driver:
-use_siw=1 nvme-trtype=rdma ./check nvme/
+use_siw=1 nvme_trtype=rdma ./check nvme/
 use_siw=1 ./check nvmeof-mp/
 use_siw=1 ./check srp/
 ```
-- 
2.25.4



