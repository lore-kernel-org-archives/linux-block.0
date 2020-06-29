Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7F1C433E0
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A4520780
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Rf2uTVfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgF2XnT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:43:19 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:21797 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgF2XnS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 19:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593474198; x=1625010198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wgv9em9HenfSWgxv4aK/scSE83X9g/1kLwUkhHSEsvs=;
  b=Rf2uTVfGawkwh4a6/qMDcEe46NLc4wD9XW59UNSK21HT5YCt2I0rfVDG
   ACTp/dwkOI6d5ZsqXmDp1daExtwl3gqE00ubxPV/+fhyDjuJM5stN8q0/
   D+/8hOPeHbzcKW2jTkjbsyruVJscoWJYTuiuEBFdhzK9psAb0BBVDtBxI
   WkT0fFJ4yV9YuAivjedLYtV21E5d469+SIyNTNp/VGTvczPiUFbPIUruK
   OdNltLHqTzQ0Zt3kIQ9ApIgfRvIxOfiPfW0zkKvt3UMozUIzfeZPfl+oc
   PrhKCTcf9wfpSDTXT7aWQMbXAuilsU2G2KQUlBCWQr8Gzex3SKnWv6fF+
   A==;
IronPort-SDR: Qqnbc5xQD96Nsk6NhtEk0zaWBbfFKQX59eg8gjXhKcKbToVAT/Ap54491q/QSbkS00/oThtqpP
 jJ94rR0XdCvyOmF3ot89P3WBnvIYPKYXtZ/adA+7sJ72CScuH63BdxlWXfWYW4Emui7rgPFS2w
 UW6jh5RRCg0zXd1516z0wU7IhPDdeL8Zj9tGiD2nUF2sD3BbuZYxLsP+dVC4UXKWIAkpyU0oPM
 kS4TAMbI1HFgkghL6c68AXPQ7at5thrY1MXlgu7VlPL23ofQYy8SGfV6/xAG36pj44OHgTLvno
 nBA=
X-IronPort-AV: E=Sophos;i="5.75,296,1589212800"; 
   d="scan'208";a="142577088"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2020 07:43:18 +0800
IronPort-SDR: vLNsfnIm+HDBFa0wqnlPCPn5ga41naLkcd9ZDMuaPRGymu2oOp/d+FsnaJW/jZGR0BcThAHrCd
 /of+J6QtTdIxgOxUMQlwjjrcXNl6ljfrA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:31:37 -0700
IronPort-SDR: cdZUopfc86SzUbc+do8Bt/k3tYAC+fjpzS1YCOddzou9iU5sux+DCySCmUpRnd8k3W+iGrHmAT
 9O3G2G7A9rIw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jun 2020 16:43:17 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, dm-devel@redhat.com
Cc:     jack@suse.czi, rdunlap@infradead.org, sagi@grimberg.me,
        mingo@redhat.com, rostedt@goodmis.org, snitzer@redhat.com,
        agk@redhat.com, axboe@kernel.dk, paolo.valente@linaro.org,
        ming.lei@redhat.com, bvanassche@acm.org, fangguoju@gmail.com,
        colyli@suse.de, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 00/10] block: blktrace framework cleanup
Date:   Mon, 29 Jun 2020 16:43:03 -0700
Message-Id: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

There are many places where trace API accepts the struct request_queue*
parameter which can be derived from other function parameters.

This patch-series removes the struct request queue parameter from the
blktrace framework and adjusts the tracepoints definition and usage
along with the tracing API itself.

Also with the queue parameter removed now we can merge some of the trace
events with creating generic event class for bio based tarce events.

Finally few of more cleanups to remove the trace_block_rq_insert()
wrapper blk_mq_sched_request_inserted(), get rid of the extra parameter
for trace_block_getrq, remove the blk_trace_request_get_cgid(),
fix tracepoint comment header,  and blk_fill_rwbs() related triggred
cleanup.

I've added patches after first cleanup as I scan the code for more
cleanup. I think patch distribution can be better but it will be great
to have some feedback as the amount of clenaup has grown bigger.

Any comments are welcome.

Regards,
Chaitanya

Chaitanya Kulkarni (11):
  block: blktrace framework cleanup
  block: rename block_bio_merge class to block_bio
  block: use block_bio event class for bio_queue
  block: use block_bio event class for bio_bounce
  block: get rid of the trace rq insert wrapper
  block: remove extra param for trace_block_getrq()
  block: get rid of blk_trace_request_get_cgid()
  block: fix the comments in the trace event block.h
  block: remove unsed param in blk_fill_rwbs()
  block: use block_bio class for getrq and sleeprq
  block: remove block_get_rq event class

 block/bfq-iosched.c           |   4 +-
 block/blk-core.c              |   6 +-
 block/blk-merge.c             |   4 +-
 block/blk-mq-sched.c          |   6 -
 block/blk-mq-sched.h          |   1 -
 block/blk-mq.c                |  10 +-
 block/bounce.c                |   2 +-
 block/kyber-iosched.c         |   4 +-
 block/mq-deadline.c           |   4 +-
 drivers/md/dm.c               |   4 +-
 include/linux/blktrace_api.h  |   2 +-
 include/trace/events/bcache.h |  10 +-
 include/trace/events/block.h  | 226 +++++++++++-----------------------
 kernel/trace/blktrace.c       | 129 +++++++++----------
 14 files changed, 161 insertions(+), 251 deletions(-)

-- 
2.26.0

