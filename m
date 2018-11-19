Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4360EC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 03:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CD420817
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 03:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a5U5X6Vd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CD420817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeKSONw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 09:13:52 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:62727 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbeKSONw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 09:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542599495; x=1574135495;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8MsMZoI+D1i7y80aJCA5qjWTwVIchxjht1F/2zox79E=;
  b=a5U5X6VdOnsOwwUuWGvBSYPG5wEXf1HYj1aC7woPCxP2htQHit8pT7tv
   UDVcUt/jScuEu30D3ichTr7NmuMpJTkZeqKJVA3MPTAIeHOw3bXbSfqID
   c+YlDVZky3W1vTaAbMTlgHPfXDH43PpANtieD7jLP6nOuBTLRbOcNfdXC
   1Vv/7x+HFjrkBj9WjrvTrHQn3q8rEf8bJ2v37qRLMSX6R0Vk3rc/PEms9
   3IMYSZjv7+pG9+l3SGwisBcJHC2uU9ChaoOBvficGjljemuBw2HSlimj4
   8I9E39lotSq1BfHObfeasqxtr+NuxVKW7tSZ9dqWMMUEkpx2lwdLLQ2LJ
   w==;
X-IronPort-AV: E=Sophos;i="5.56,250,1539619200"; 
   d="scan'208";a="96272443"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2018 11:51:35 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 18 Nov 2018 19:34:33 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2018 19:51:33 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/7] Improve I/O priority handling
Date:   Mon, 19 Nov 2018 12:51:24 +0900
Message-Id: <20181119035131.11255-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This small series based on for-4.21/block brings improvements to I/O priority
hanlding. The main fixes are in patches 5, 6 and 7. These fix BIO and request
I/O priority initialization for both the synchronous and asynchronous pathes.

Of note is that patch 3 is what I beleive a clear bug fix but can result in
userland applications behavior change since a different I/O priority values
will be returned for processes that have *not* executed ioprio_set(). This
needs careful review.

Damien Le Moal (7):
  aio: Comment use of IOCB_FLAG_IOPRIO aio flag
  block: Remove bio->bi_ioc
  block: Fix get_task_ioprio() default return value
  block: Introduce get_current_ioprio()
  aio: Fix fallback I/O priority value
  block: prevent merging of requests with different priorities
  block: Initialize BIO I/O priority early

 block/bio.c                  |  4 ----
 block/blk-core.c             | 12 +-----------
 block/blk-merge.c            | 14 ++++++++++++--
 block/blk-mq-sched.c         |  4 ++--
 block/blk-mq-sched.h         |  2 +-
 block/blk-mq.c               |  4 ++--
 block/blk.h                  | 16 ----------------
 block/ioprio.c               |  2 +-
 fs/aio.c                     |  2 +-
 include/linux/blk_types.h    |  3 +--
 include/linux/fs.h           |  2 +-
 include/linux/ioprio.h       | 13 +++++++++++++
 include/uapi/linux/aio_abi.h |  2 ++
 13 files changed, 37 insertions(+), 43 deletions(-)

-- 
2.19.1

