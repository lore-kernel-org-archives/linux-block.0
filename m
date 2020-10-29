Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0668C2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 11:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63ACF20759
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 11:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XzhRrnRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgJ2LFC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Oct 2020 07:05:02 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:48833 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgJ2LFC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 07:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603969502; x=1635505502;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/e9KxVIGUkKOddi9BLJ3iABDXR+pgFxBd34SXYreKks=;
  b=XzhRrnRqrp/vFX8Lr1a6oRlzWvR3Ewni+RZb/hA7w4hvv/hga68azvuK
   801SXa9RdSDKJiv0PZrbqNbtTDJYJYI3NCQ6ic/seOAEj9l53gKxAZSn/
   YETNSKxdvKTW06TXm6w2BLMkmavWJJsyAH3TWXm9PzjbgOwJl5gNQlQGc
   /jC501dBxX4X/Sps8he8ZYNpMoz/PNW4mD0HAgdNjtgJCSeECRhUr2Y/d
   EhVoACeul7U6TjQij7C9HkW168w3sSXOgC6VjrjK3jTwr7V1COdE6hM/m
   8mEa/PtvLiMpuaY2FhTU4aaGyC/fGKVmoGudcrfxHLW/fH4js/Xct7nom
   g==;
IronPort-SDR: wYoitG589WSiomwm4OHR+Ksqce10Rv5sddV6Br4G9CXGGYW2zW/UBxbWZ4rPOSgfFbZty+j12L
 k/hN3Sp15TeA1/9RO8llNCWSoyAQ5K7/SlFkxhwPvRlIz8p6ZFDaKrGPTRjGD53f6nCcHYEwtQ
 IxmpVOuxx69V+YU+vvuNHcSn3cGTSnEffAcqs11C0JZyfF8+6TkwEb8sQIWOU3+AW6ZhaC5hfT
 jf1s/8d2o5yfssUaUHQGnQFq4SG7HgRIKjpDBf3Q9orf7cnLuQRcGHhcQj/L9F1Tz8vbwq4aq/
 Rd8=
X-IronPort-AV: E=Sophos;i="5.77,429,1596470400"; 
   d="scan'208";a="151134626"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 19:05:01 +0800
IronPort-SDR: /NQpCjK67cRpMQRdTdUihU4qgV569CiqkGK0eQact+FSm7UREpvNShkiGJLvCz+WNXjvsQqAyE
 m3KyuRTnF8CNNhnA1lxvuP8jd63//VePzeT6KCAc5qixnB5IRSqUrgehD4ge1zbzHSEMnY5zzH
 lrStttTQ3I3xQvtDo9gqE9OGMZ2tm/aLWnidMPvHZAlMYKPXDXHRKQusc5JYAMPZBCYgSTDh0m
 yzqDcZEKFQMkyFgIiLxPoiZWg1W2wKVeqzmOAzy8ZqmRu6S7MjcYisSmSNFcJSnM21ov8BWupv
 MydbS5I/oD8sCWLAy1SkICWi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 03:50:06 -0700
IronPort-SDR: O3WJ+PqA+s7aTzv/5bDyWkXpdCg5am4uZ/ED+froeYiI6EJ6TWnh2m+p3avAazKgTxPN/uEfOE
 Eh92yXTvobQr09+FFNgwrQ8VQuuMmneGwJpg1DMWJyPFoFOIT17sMaTNLHqHBPzk1aLzqW88jI
 P56kAi0X3p+ZZZ9j/0rL/wNAm+jocxNQFJNHXyrIImD4obts0kP2CJZ7aWDiUqJ0OhHeVkFJAl
 ug534XhDxxrxkAFWfrokZFvnd8k1X60pTAAbpNSztkbWW0aW6kv/CGkt58xANM6NdIYrXXknou
 N3s=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Oct 2020 04:05:02 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 0/2] zoned null_blk fixes
Date:   Thu, 29 Oct 2020 20:04:58 +0900
Message-Id: <20201029110500.803451-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,

Here is a couple of fixes for nullblk for this cycle.

The first patch fixes tracing of zone condition in the case of a
REQ_OP_ZONE_RESET_ALL operation.

The second patch fixes a more serious problem introduced with the recent
modification for protecting zone information using a spinlock. A
spinlock cannot be used when memory backing is turned on as that results
in potential memory allocations with the lock held and IRQ disabled.
The fix changes the locking method to using a bit, with the spinlock
retained only for function local protection. This new locking was
extensively tested with xfstests/btrfs and zonefs tests runs.

Damien Le Moal (2):
  null_blk: Fix zone reset all tracing
  null_blk: Fix locking in zoned mode

 drivers/block/null_blk.h       |   3 +-
 drivers/block/null_blk_zoned.c | 113 +++++++++++++++++++++++++--------
 2 files changed, 89 insertions(+), 27 deletions(-)

-- 
2.26.2

