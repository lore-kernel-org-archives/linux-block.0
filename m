Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6041C83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 16:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851EB2063A
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 16:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MR8sTFPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgD1Qol (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:44:41 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8957 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgD1Qok (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 12:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588092281; x=1619628281;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L3rIGU4T1vWUT9whywXCA+D9vf8bLNmDygG6v9QJQac=;
  b=MR8sTFPylmoTiaspUIGOvaWE1FwWTXN6dpelRoVZXBaJchy4t2Fcj823
   xs6SzGHLL4UU86UvnBPv6bQtsYIrB6wRmuSLKQRf0FEKRtTMst+ItHkZ2
   kf0665d1eK/FvzMAB50AE5zMBnB7ls0A8A+hpK3r+RZbj6doz8jPemckr
   tcEhT+PxVmWnL9yrCxNAufIQAhX1fGYVVuK/DwNFJULI280kcxev8XG4o
   SlAaYXdlNEJEyfxpOrBYka1bB0t4BZdXAGDKJ3N28so6QiGnNPPOckPPU
   YXzeI5lB57yV+JvpKEAB/0nQ1eOOxpf1PUIUu8T8xSvKaRHxZTwKwWhGl
   g==;
IronPort-SDR: XCSpqNFYguuyCrSg/a4t0DaVZqL+bcMKS3EyUyqIPQCNQzyeJNbMxUTcQBHNRtvbIx1zbqc5Eq
 5V8A/GsCtly+n8FVv4ignT5IKIO+5RdD+yhulJXyQ+YaDsoSrnJfE1Ef/5fy2T+RCAeaFEoRux
 3CSb9z++JbBMtbWkn5fLDeZ7r005WD0CBgF2lJLZbgVRGK5zi+bJ8iZf1CGVr3YKeHtjFTTOPf
 lh/w+R4AT5iQCjxzmrlcIgLEslF1LkyVXdTtyleu4Ken22tmDIxK6+eF/6pja/Z8VxctpxHsST
 jxI=
X-IronPort-AV: E=Sophos;i="5.73,328,1583164800"; 
   d="scan'208";a="140725860"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2020 00:44:40 +0800
IronPort-SDR: gtqxfQ+o/lA4h945OcA9Sh0rHnCmlfuv8Vei3V0yrWruPGny6WSNhi+eIKKclyskdyDM/dY9Ly
 Gm0fTq2XSo6YI/D3BrAZTOjiS/bPAC4sg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 09:34:46 -0700
IronPort-SDR: UkhUaQJ7uVld+EXdlghQNV04c63kQcfrAIB+mk9rrfoacbBAp7I2ZRSzAQLT64MNsn1zrMrBxX
 UBjgKRfcd7Zg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Apr 2020 09:44:37 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/3] block: drive-by cleanups for block cgroup
Date:   Wed, 29 Apr 2020 01:44:31 +0900
Message-Id: <20200428164434.1517-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While reviewing Christoph's bio cleanup series, I noticed
blkcg_bio_issue_check() is way too big for an inline function. When I moved it
into block/blk-cgroup.c I noticed two other functions which only have one or
no callers at all, so I cleaned them up as well.

Johannes Thumshirn (3):
  block: remove blk_queue_root_blkg
  block: move blkcg_bio_issue_check out of line
  block: open-code blkg_path in it's sole caller

 block/bfq-cgroup.c         |  3 +-
 block/blk-cgroup.c         | 56 +++++++++++++++++++++++++
 include/linux/blk-cgroup.h | 85 +-------------------------------------
 3 files changed, 59 insertions(+), 85 deletions(-)

-- 
2.24.1

