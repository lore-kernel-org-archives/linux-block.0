Return-Path: <SRS0=i0oD=EB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEC7C2D0A3
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 06:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86A92225C
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 06:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421682AbgJZGl6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Oct 2020 02:41:58 -0400
Received: from mx1.didichuxing.com ([111.202.154.82]:16366 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1420395AbgJZGl6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Oct 2020 02:41:58 -0400
X-ASG-Debug-ID: 1603694510-0e41086da21f39e0001-Cu09wu
Received: from mail.didiglobal.com (bogon [172.20.36.203]) by bsf02.didichuxing.com with ESMTP id tYLAp8r83KGd09hn; Mon, 26 Oct 2020 14:41:50 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 26 Oct
 2020 14:15:10 +0800
Date:   Mon, 26 Oct 2020 14:15:09 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <snitzer@redhat.com>,
        <mpatocka@redhat.com>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH v4 0/2] fix inaccurate io_ticks
Message-ID: <20201026061509.GA22573@192.168.3.9>
X-ASG-Orig-Subj: [PATCH v4 0/2] fix inaccurate io_ticks
Mail-Followup-To: axboe@kernel.dk, ming.lei@redhat.com, snitzer@redhat.com,
        mpatocka@redhat.com, linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bogon[172.20.36.203]
X-Barracuda-Start-Time: 1603694510
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1627
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.85498
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patchset include two patches,

01. block: fix inaccurate io_ticks
fix the io_ticks if start a new IO and there is no inflight IO before.
Please see the commit message of patch1 for more detail.

02. blk-mq: break more earlier when interate hctx
An optimization for blk_mq_queue_inflight and blk_mq_queue_inflight,
these two function only want to know if there is IO inflight and do
not care how many inflight IOs are there.
After this patch blk_mq_queue_inflight will stop interate other hctx
when find a inflight IO, blk_mq_part_is_in_inflight stop interate
other setbit/hctx when find a inflight IO.

Changes since v3:
 * add a parameter for blk_mq_queue_tag_busy_iter to break earlier
   when interate hctx of a queue, since blk_mq_part_is_in_inflight
   and blk_mq_queue_inflight do not care how many inflight IOs.

Changes since v2:
* use blk_mq_queue_tag_busy_iter framework instead of open-code.
* update_io_ticks before update inflight for __part_start_io_acct

Changes since v1:
* avoid iterate all tagset, return directly if find a set bit.
* fix some typo in commit message

Weiping Zhang (2):
  block: fix inaccurate io_ticks
  blk-mq: break more earlier when interate hctx

 block/blk-core.c       | 19 ++++++++++----
 block/blk-mq-tag.c     | 11 ++++++--
 block/blk-mq-tag.h     |  2 +-
 block/blk-mq.c         | 58 +++++++++++++++++++++++++++++++++++++++---
 block/blk-mq.h         |  1 +
 block/blk.h            |  1 +
 block/genhd.c          | 13 ++++++++++
 include/linux/blk-mq.h |  1 +
 8 files changed, 94 insertions(+), 12 deletions(-)

-- 
2.18.4

