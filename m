Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BE5C4361A
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 02:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 226A9207D1
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 02:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgLDCnn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 21:43:43 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:58736 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgLDCnm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 21:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607049822; x=1638585822;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dMbXIo35yB3tGZnfQHWQ/0tYXzfasVmCu3g/hmWAsR8=;
  b=jeSqUOkLbKmH7a7ntqG2rl0VhpXZVPh6vpq+WwxxghCrDvvHyvaxYNVz
   XEOSkuKpDedlToSCwl1q077QvUU6fBfPPZzx3QNxyNP/YYK1lJCKR8B1m
   N9/m/Tzvzz0vf0fKpfR/Utv2nZkm4pGO2Z9Rdf8cIXiyKrzQ4w/C8tgIf
   zXAIAFQHKnGQ1KrynAAK5Nz1ZlVPZCgtBsRvO1S7HKlbJzSB2kHZZVhhv
   CDhF2QzaLWH2ciXhPMd6ZlohWCbhg2BekuRpVK4r2UR8lDm8rizZjW/T5
   5M50YBevfT5KHAd1TYzjv8M4s5fRYqB6c0As6SkD6Miqfzqh2KhyZWRwH
   g==;
IronPort-SDR: QGq+tEDDRFdXqRvpcJUfFVwQ5xxPUCBV7QmQwMdGJ7U7NEq6+NHtCI2g3NDGIoQwwSBc5T6Myl
 abuZZOx9bDFMi5L7jy6Ugd+lEgokn/Syrs/+RSGbnM1cVyDjg6D/PLD8j6e6mvYlzdSHXcz1ug
 uIQ+Nktn9wImiuj/9l+OKZuLJNCFAIg50ieqfxeHHvqS6nUOU4cwqyiyKo4fE5GSH05bWh3TI4
 osiZtSaRaZgZwZ/ZJulmLlDjfmgNWg7z3cYfIF8dH8TczwF5C7BIDwWvDcr/C4OI2pefsssBFK
 Fyw=
X-IronPort-AV: E=Sophos;i="5.78,391,1599494400"; 
   d="scan'208";a="264546962"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 10:42:36 +0800
IronPort-SDR: nXd9hSxOHYwIppn35rotAZjnRtzjF0MSsROgqwBbnk/phvx76FUNeaGFqBGVrJefzxVp3nHfz2
 +JoIRZqrWcm3+XrizwvHZlQxXzN7ynt6E=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 18:28:09 -0800
IronPort-SDR: HkjqcvL2CkcQ9NIKY1I03CRhrQGBKfUIOmNuI7iVXTMFMJ3cyZdSYeWadZF940G6kxXPiuJXbE
 e2irB4By0DMA==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com ([10.149.52.189])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Dec 2020 18:42:35 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 0/2] Support max_open_zones and max_active_zones
Date:   Fri,  4 Dec 2020 11:42:33 +0900
Message-Id: <20201204024235.273924-1-shinichiro.kawasaki@wdc.com>
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

