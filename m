Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACB4C433E0
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 18:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8A02063A
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 18:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r0CWMCvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgF2Ss3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:48:29 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56654 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbgF2SsJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 14:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593456490; x=1624992490;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nYDJ1cP4EzpASFxLCTYltAbGnjUpG/8agq++iCkHRAM=;
  b=r0CWMCvgzJsIok45i5hf9mm7skTQZdET7G+e5vz2y99RU3COC7keJGMs
   y5VPLB+/n2gLkzajjZ7hxIfKsK+EU6/5zW8/padC5vfRaAbXorm3tiaR4
   5MM3tb1FYJC8AOT5CpEZAIT6EDRGIROd55sKRaPZJ63RC6YmBnIiFZ9E2
   nwZH/cEh4+rtJOlCnAVp6Nqvrsc6GOjuaw0YuAEp2dr7csQfkfh3xirz1
   iXUY+iTq9e5rdyDI3/GPYgLhzk6WuMKKqblxmgRokh/MQrrayfXcdFuuF
   zryR00LDKPXFuxcBmtBYg6f+d78chunCTuD4f+2ahGN7bP9XMHRBmj4DF
   Q==;
IronPort-SDR: fYz2RSLLk9TMnElVTSB0PT5nXydgh1tmv4bvk6hLaU0kr2Gus5M33Y/xii4Hq7ZOlusyqcDubQ
 4sqY4A/qtiks1UWcd/HCGwWh1t+Lw2avmodO/MdyjsUH6Ik3tP7cLdzMyOCn0ZEOD8facG7/MD
 6OWmV8tA78NfpdxGSwTsOscU6VRezVUrg68alxf7J8nlsll63YvfIo4to8u6/U58uazVUcsypX
 /vx8qe5dEJnYP2mBwwaYUXh5AznJ9BYR3+NO8E0Zy239OO0G0jaRba4t39foCjkZmhIMG6cH4C
 4WM=
X-IronPort-AV: E=Sophos;i="5.75,294,1589212800"; 
   d="scan'208";a="141379664"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 16:26:27 +0800
IronPort-SDR: 4oBsa3tYUpuN45YL0bdqmH4zGCxBfZu43JYViUy0sEw2Nd3AQkjt4KDziwiIJh/c0FWVgiIGRg
 OyUOm4o7ojk6bObKpgdhQxj+S1ruw/PCQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 01:14:46 -0700
IronPort-SDR: k8SVoU3toZdHMM2lP8ruIyDTWk+77jJH6TsJHewl2RU+dYpiK5YGtvJu/6H5/4hatmKnV12TGZ
 l+hUIULYGWEg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Jun 2020 01:26:25 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        "linux-block @ vger . kernel . org" <linux-block@vger.kernel.org>,
        paolo.valente@linaro.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 0/2] block: drive-by cleanups for block cgroup
Date:   Mon, 29 Jun 2020 17:26:20 +0900
Message-Id: <20200629082622.37611-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
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


Changes to v2:
- Re-based 
- Removed patch concerning blkcg_bio_issue_check, Christoph has a better one

Changes to v1:
- Re-based onto for-5.8/block with Christoph's patches
- Removed white-space to not hurt Christoph's feelings
- Added Reviewed-bys

Johannes Thumshirn (2):
  block: remove blk_queue_root_blkg
  block: open-code blkg_path in it's sole caller

 block/bfq-cgroup.c         |  3 ++-
 include/linux/blk-cgroup.h | 27 ---------------------------
 2 files changed, 2 insertions(+), 28 deletions(-)

-- 
2.26.2

