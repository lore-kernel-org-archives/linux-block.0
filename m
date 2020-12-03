Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71771C71156
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 08:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A44C21527
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 08:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbgLCIXw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 03:23:52 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38582 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388358AbgLCIXw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 03:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606983831; x=1638519831;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ym0msQcCQz8CHDU2NA4LS7VhzhBvoY2+z+2Z2YL0Hj8=;
  b=CkcBvrrXQhsTfMK4MYVf39zDAu52bDU+C87e/4WHg8N2BGOrtGYe2iaQ
   Jg5rkzqOpW+sAsRnqtUHOnGBir4Us3D0Levad1gnFmfNPxQmk93gExcDB
   EfaXx+CBb/3mF6/cGsMt/8zj6GqXgdZZoeOFBvFWcrDwTtfniJ9YuNN1+
   9W7idwx1/U4KyNZgfai/Mb+DI1mFmEzhyZwoKfzN/ZcZoYMKQzkpConjJ
   SDB85+zz+ZcFDQA2qv0nmc0yrigdCpe+J4gVRlRhQWQCru9pIF07Xia8l
   remNW8ulhjk+IJlO0w5UA4mARJTmFYNH+r7g6J/YgEWcOgY+2QiPMoPRR
   g==;
IronPort-SDR: fJrlrWm8BoDlxl3nOpvkDyZUd64sx+PiN1Fzf4E7KBzLGIIbub0/vNC60TuM6WulgJI+2gtpHu
 ZD7NE+ZR0/GO/NKgn4HsrDq1ys2i0/nuhflYbpndeAgaaifXQ3mplYGiJP8iYLv9SMLK+QuwuT
 HPJp+mqF2yM5NtfCZq2KHoFUjqhtENSo3g/Mopy+FLGjvqWeNYEqEP1Gu3jR/w7P0f9fpxEtqn
 5GyX/XmusH3EoS7+lEQ2JJjxvJF9LEpUVnsbldrqbhNW/s4Wowp+9Hmfuvtcjx4c8enuE9tNzh
 slk=
X-IronPort-AV: E=Sophos;i="5.78,389,1599494400"; 
   d="scan'208";a="154306297"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2020 16:22:46 +0800
IronPort-SDR: MKX2kaxwZZdXVMJggzOVgqjapqEJtp0tjvGIcpomU5XJ5M4XX0vsZibcMhYiVPS7aunzVIk+kz
 5/s72+KXLmKmsgAZBB+bXoWz9k79d64hM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 00:06:56 -0800
IronPort-SDR: diPN4n6rjCUXaeBY+9CBgvKYLfwIlS/LVQdZH8XHc20i5RjCPyi9fJ2Bb2VAtKc/YG8IeHXKgk
 kfZZtqQZyW7Q==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com ([10.149.52.189])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Dec 2020 00:22:45 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/2] Support max_open_zones and max_active_zones
Date:   Thu,  3 Dec 2020 17:22:42 +0900
Message-Id: <20201203082244.268632-1-shinichiro.kawasaki@wdc.com>
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

Shin'ichiro Kawasaki (2):
  common/rc: Check both max_active_zones and max_open_zones
  zbd/005: Provide max_active/open_zones limit to fio command

 common/rc       | 21 +++++++++++++++++----
 tests/block/004 |  2 +-
 tests/zbd/003   |  6 +++---
 tests/zbd/005   | 13 ++++++++-----
 4 files changed, 29 insertions(+), 13 deletions(-)

-- 
2.28.0

