Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F770C47247
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 15:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6045720775
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 15:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P2SON5Fs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgD3PEC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:04:02 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20784 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgD3PEC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 11:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588259042; x=1619795042;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=88BnW1AGv5cwjkg8N54IJ3rAQDhET1ELBSCqPvhKi5A=;
  b=P2SON5FsMNjj9uyV7P2rBQnWszJPQC2GGU91ojqkiZKvZ/uunxPtRSla
   CLClaK9MkxyDvCUmbzr2qmg+maGG5YAYlJj2p0vtcOBo+VxMp55/E06uO
   3DgyxShZ3lDxVaXZLrGwOYec9Qjmtcbixc9s+YZiR8CH52kYAEPF+sinh
   jXe5flfu9byHoZIDUK17+oPzz76attoHvbLr8zFVCKmV3vM+uchDjKkKc
   vbRNRj60sImqEksgYZ3P+ZOphTwFybpxjAt9hx5Jm1dZuOnVsR28Yk/s4
   MC+vResfAnWISC3BgEFgtreCvEk8PxqdqrSAvsQIEouY5+AaDTSFDtJpJ
   w==;
IronPort-SDR: MISShBMV8Y+xFhLXWP8rBcyajHVtOiCnbdCzI8rLcgEQiOqEeqWjBSdyATkrt8UGyHLYebx4KF
 DGARuu3EPuuS0FwVcDTxonfjpNJjtMXQrIL4HNr9m/5Zi893opwzlIzEvsd6VIgeG6mYa0teXA
 Gsql/8MRLH0GSGO4YnnrjMNWTNpGgXsIbozpgOGjrYZORmUSkczMGg4os6BlSO5LCLhbRtOcJN
 jC2pqRMBjqicJ+SF3KTQD3mA6zSa7kAZowWHZ5w8qgfl0cKl+4M20HtyKJam+27VdLzZif8O/2
 jeA=
X-IronPort-AV: E=Sophos;i="5.73,336,1583164800"; 
   d="scan'208";a="140916557"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 23:04:02 +0800
IronPort-SDR: rfIcNhAXjciSVYusmGOYPyYHKsw+TcQAxw/e/p7ciC0/7pMwSNQgO1DG7/8VYprFh6+PEXCIh7
 L2Xm7vpjnEPf499ljb4qZV6r4HEQ1B0NM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 07:54:04 -0700
IronPort-SDR: r0RwdPLUvVboI/BK13HNxBaA8HUkx7sykhhhdQzwpZIQY1rqQVFwTGu7csigir3WMs7jSVw/uu
 tazFc9g+ZQ1g==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2020 08:04:01 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/3] block: drive-by cleanups for block cgroup
Date:   Fri,  1 May 2020 00:03:53 +0900
Message-Id: <20200430150356.35691-1-johannes.thumshirn@wdc.com>
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


Changes to v1:
- Re-based onto for-5.8/block with Christoph's patches
- Removed white-space to not hurt Christoph's feelings
- Added Reviewed-bys

Johannes Thumshirn (3):
  block: remove blk_queue_root_blkg
  block: move blkcg_bio_issue_check out of line
  block: open-code blkg_path in it's sole caller

 block/bfq-cgroup.c         |  3 +-
 block/blk-cgroup.c         | 57 +++++++++++++++++++++++++
 include/linux/blk-cgroup.h | 87 +-------------------------------------
 3 files changed, 60 insertions(+), 87 deletions(-)

-- 
2.24.1

