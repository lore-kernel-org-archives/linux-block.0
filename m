Return-Path: <SRS0=cIdD=UP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC20C31E49
	for <linux-block@archiver.kernel.org>; Sun, 16 Jun 2019 10:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE7B21707
	for <linux-block@archiver.kernel.org>; Sun, 16 Jun 2019 10:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfFPKOo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Jun 2019 06:14:44 -0400
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:21486 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with SMTP id S1726663AbfFPKOn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Jun 2019 06:14:43 -0400
X-ASG-Debug-ID: 1560680077-0e41085062309420001-Cu09wu
Received: from BJEXCAS007.didichuxing.com (bjexcas007.didichuxing.com [172.20.2.248]) by bsf02.didichuxing.com with ESMTP id lobWH3wB56afDEbI; Sun, 16 Jun 2019 18:14:37 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 16 Jun
 2019 18:14:37 +0800
Date:   Sun, 16 Jun 2019 18:14:31 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>, <hch@lst.de>,
        <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>
Subject: [RFC PATCH v2 0/4] blkcg: add support weighted round robin tagset map
Message-ID: <cover.1560679439.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [RFC PATCH v2 0/4] blkcg: add support weighted round robin tagset map
Mail-Followup-To: axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        bvanassche@acm.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bjexcas007.didichuxing.com[172.20.2.248]
X-Barracuda-Start-Time: 1560680077
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1731
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0113 1.0000 -1.9475
X-Barracuda-Spam-Score: -1.95
X-Barracuda-Spam-Status: No, SCORE=-1.95 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.72767
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series try to add support Weighted Round Robin for blkcg, and
add some module parameters to enable nvme driver WRR.

The first patch add an WRR infrastucture for block cgroup.
The second patch add demon WRR for null_blk to similate nvme spec.
The last two patched try to enable WRR for nvme driver.

For nvme part, rename write_queues to read_queues that we can add the
wrr_low/medium/high_queues easily to support WRR. To compatible with
READ and POLL, DEFAULT, tagset mapping, this patch set these three
types hardware submition queue's priority to medium.

Changes since V1:
 * reorder HCTX_TYPE_POLL to the last one to adopt nvme driver easily.
 * add support WRR(Weighted Round Robin) for nvme driver

Weiping Zhang (4):
  block: add weighted round robin for blkcgroup
  null_blk: add support weighted round robin submition queue
  genirq/affinity: allow driver's discontigous affinity set
  nvme: add support weighted round robin queue

 block/blk-cgroup.c            |  88 +++++++++++++
 block/blk-mq-debugfs.c        |   3 +
 block/blk-mq-sched.c          |   6 +-
 block/blk-mq-tag.c            |   4 +-
 block/blk-mq-tag.h            |   2 +-
 block/blk-mq.c                |  12 +-
 block/blk-mq.h                |  17 ++-
 block/blk.h                   |   2 +-
 drivers/block/null_blk.h      |   7 +
 drivers/block/null_blk_main.c | 294 ++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/pci.c       | 195 ++++++++++++++++++++--------
 include/linux/blk-cgroup.h    |   2 +
 include/linux/blk-mq.h        |  12 ++
 include/linux/interrupt.h     |   2 +-
 kernel/irq/affinity.c         |   4 +
 15 files changed, 574 insertions(+), 76 deletions(-)

-- 
2.14.1

