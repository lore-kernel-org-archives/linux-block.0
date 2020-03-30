Return-Path: <SRS0=FzxQ=5P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A0FC43331
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 04:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23ACC20732
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 04:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Nqxu7TMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgC3EBT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Mar 2020 00:01:19 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:56281 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgC3EBT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Mar 2020 00:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585540878; x=1617076878;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LNGf5/jzltHNucFGSZWp6m9dE7M/QIxEMXG+YJbhWx4=;
  b=Nqxu7TMi43hUdxzIw83SvmP8po74bwmdoRO5lfA5+LS56/zeQ6j/uhU6
   0LP8NZ1Wq8dtzaREROFGO3rx5soo7oV6vyIYxMhkLLM0732nE7DQgqBuw
   UWMRXVgZWeWW/TpBTXvzoejHou/+RSqnJS8ngOq28sj/3x4LPsLsRcVY0
   FRBFk65o4+qEJ4Uy6HO9QibIQCH81Oom6ZF3h0YYtp5a8FBT5+P5bz6xk
   fqPfviRCxK/xHRCewtDs9m0B7X4JfTUdbbzlDGpMaOGEsDfdxbfvGunKy
   5cZehSIu1bFwQR2vL5gofojqeVp8nbQHa0C/i7wDKqjYcgURvJSa45XhU
   w==;
IronPort-SDR: +diTemGwF/h5SnVQ9qKR5n6tZVlvrJRyC10Xgq41puGoiQN6opWt7ciaPflyWTE6uKmw8gtPb1
 Orz06Z0EBqKMhOnddPO+UKQ0g2zhUpCZnvXDsZhzo7aLQQKe1D4hNQaIABQTo1tJ184izS1+QV
 8v+Tp37mG8HhKYexrbAPNYUHN3UDYmi7xqipexySlevBuovSK51tUi2SGvnR4AXSVioEEYjTAx
 0RSypPNXAexwEGwtcEphCWANr9xZMTQNotIrVvKApRL+0j+t9IUn9aKLhHvJB6mQSlnSHeCaEK
 384=
X-IronPort-AV: E=Sophos;i="5.72,322,1580745600"; 
   d="scan'208";a="242386352"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2020 12:01:18 +0800
IronPort-SDR: MhzUI1P4dVgS8rjgn4M1i2jp9Tt6dBptk92u0l13liTuCTFYTcDAD61iNFwkL4vv7SMz2H5FBu
 TEaFUScFEtAtug1ijDZe5rDl2EXwws8xB+/8qp+u8S366gC6TfDcFaD2/B27LZrpGzihqCjoHA
 FElazykAPFsKnweaiskbc98Zci6nKXrqARAsLLn0WEZAGQfbHKyvalEP8LO8aWJfNRimu2mmOE
 yJBLVhmc0BumuyeR1+UgMrY3dd2OKWLuHUfN8DR7Z68+J0711sijI8blbVv8Qt//Yn/uVFNLKu
 z++P2Gwe/jj4kMQDNGA6+2fJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 20:52:14 -0700
IronPort-SDR: iDUV8NkVbCNuAzNiOEHF1xh1Q5yILUm3Hq8s2BCyW14V3ahfSYcrNIYfEf3bojIe7Uu11qJFCg
 UwujA122BljzoslPH4eClTNILM2JDYxTI1Dc2EBFLpx6yqKzMUAvLvkFGtjcgit97XxVvNAlsy
 WvxAM5b4du5Ekut3Mc1Fxg7RpzQQtvQTu7dE4XHrhvLAUCWhKZo8jUTjSQqN/jrbx3M+/1fV9d
 zMFIVQcO738lzCwNnpgSWIXYrJdswRmIa0EydAqIQimBwFOp7x6vAT7mta5zgeAB5xsafYPQ42
 Ydg=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2020 21:01:17 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/2] null_blk cleanup and fix
Date:   Mon, 30 Mar 2020 13:01:14 +0900
Message-Id: <20200330040116.178731-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,

The first patch of this series, extracted as is from Johannes series
for REQ_OP_ZONE_APPEND support cleans up null_blk zoned device
initialization. The reviewed tag from Christoph sent for the patch
within Johannes post is included here.

The second patch extracts and extends a fix included in the zonne
append series to correctly handle writes to null_blk zoned devices.
The fix forces zone type and zone condition checks to be executed
before the generic null_blk bad block and memory backing options
handling. The fix also makes sure that a zone write pointer position
is updated only if these two generic operations are executed
successfully.

Please consider these patches for inclusion in 5.7.

Damien Le Moal (2):
  null_blk: Cleanup zoned device initialization
  block: null_blk: Fix zoned command handling

 drivers/block/null_blk.h       | 37 +++++++++++++++++++++---
 drivers/block/null_blk_main.c  | 51 ++++++++++++----------------------
 drivers/block/null_blk_zoned.c | 37 ++++++++++++++++++------
 3 files changed, 79 insertions(+), 46 deletions(-)

-- 
2.25.1

