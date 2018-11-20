Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC265C43441
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 01:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68392080C
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 01:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X2dtZ7GS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68392080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbeKTMTT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:19:19 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40409 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbeKTMTT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 07:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542678763; x=1574214763;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gBWAj7JdLrgOOxiDB5ngT44Hj5+j1cMZk7HpibFgk28=;
  b=X2dtZ7GSzh9On8J8HhRi3bEyBkuo8gjEaloAoaq9QMzzzM9oHvqmyFHn
   CX4pG3QrL2N4D/YIZkd3Jv1Id+Q4tlEhkQMVX82aliZIdjK5tYurXUaVO
   FwsFWKRp7N7dtMi8R56ZVwMxIGFlNOHDFt2e2eIbeOeB7j8cRrouLwKwi
   Dt1HOoa0r3vKS6YCV7h8lfviIYGlrhmiOEHdXof0fBilOw7ew8Di06Ymp
   dsCWZFWHUn+sb7nRGjlX+mBqm+WtMAuewtrOSvwGoNn/U5Tc8ZnFsmoNa
   QXw+uRDXPK8kovda8x+6kD9Cy5CKVBoyQ6HDOiM/1+tFc3wtF9EQ/TTt7
   g==;
X-IronPort-AV: E=Sophos;i="5.56,255,1539619200"; 
   d="scan'208";a="95813253"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2018 09:52:42 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 19 Nov 2018 17:35:57 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2018 17:52:40 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/6] Improve I/O priority handling
Date:   Tue, 20 Nov 2018 10:52:32 +0900
Message-Id: <20181120015238.26467-1-damien.lemoal@wdc.com>
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

Changes from v1:
* Removed not very useful comments in patch 5
* Dropped get_task_ioprio() change patch

Damien Le Moal (6):
  aio: Comment use of IOCB_FLAG_IOPRIO aio flag
  block: Remove bio->bi_ioc
  block: Introduce get_current_ioprio()
  aio: Fix fallback I/O priority value
  block: prevent merging of requests with different priorities
  block: Initialize BIO I/O priority early

 block/bio.c                  |  4 ----
 block/blk-core.c             | 12 +-----------
 block/blk-merge.c            |  8 ++++++--
 block/blk-mq-sched.c         |  4 ++--
 block/blk-mq-sched.h         |  2 +-
 block/blk-mq.c               |  4 ++--
 block/blk.h                  | 16 ----------------
 fs/aio.c                     |  2 +-
 include/linux/blk_types.h    |  3 +--
 include/linux/fs.h           |  2 +-
 include/linux/ioprio.h       | 13 +++++++++++++
 include/uapi/linux/aio_abi.h |  2 ++
 12 files changed, 30 insertions(+), 42 deletions(-)

-- 
2.19.1

