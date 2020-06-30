Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD30DC433E0
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 00:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91AFB2078B
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 00:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgF3A65 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgF3A64 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 20:58:56 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD71B20781;
        Tue, 30 Jun 2020 00:58:54 +0000 (UTC)
Date:   Mon, 29 Jun 2020 20:58:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com, jack@suse.czi,
        rdunlap@infradead.org, sagi@grimberg.me, mingo@redhat.com,
        snitzer@redhat.com, agk@redhat.com, axboe@kernel.dk,
        paolo.valente@linaro.org, ming.lei@redhat.com, bvanassche@acm.org,
        fangguoju@gmail.com, colyli@suse.de, hch@lst.de
Subject: Re: [PATCH 00/10] block: blktrace framework cleanup
Message-ID: <20200629205853.38628a63@oasis.local.home>
In-Reply-To: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 29 Jun 2020 16:43:03 -0700
Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com> wrote:

> Hi,
> 
> There are many places where trace API accepts the struct request_queue*
> parameter which can be derived from other function parameters.
> 
> This patch-series removes the struct request queue parameter from the
> blktrace framework and adjusts the tracepoints definition and usage
> along with the tracing API itself.
> 
> Also with the queue parameter removed now we can merge some of the trace
> events with creating generic event class for bio based tarce events.
> 
> Finally few of more cleanups to remove the trace_block_rq_insert()
> wrapper blk_mq_sched_request_inserted(), get rid of the extra parameter
> for trace_block_getrq, remove the blk_trace_request_get_cgid(),
> fix tracepoint comment header,  and blk_fill_rwbs() related triggred
> cleanup.
> 
> I've added patches after first cleanup as I scan the code for more
> cleanup. I think patch distribution can be better but it will be great
> to have some feedback as the amount of clenaup has grown bigger.
> 
> Any comments are welcome.
> 
> Regards,
> Chaitanya
> 
> Chaitanya Kulkarni (11):
>   block: blktrace framework cleanup
>   block: rename block_bio_merge class to block_bio
>   block: use block_bio event class for bio_queue
>   block: use block_bio event class for bio_bounce
>   block: get rid of the trace rq insert wrapper
>   block: remove extra param for trace_block_getrq()
>   block: get rid of blk_trace_request_get_cgid()
>   block: fix the comments in the trace event block.h
>   block: remove unsed param in blk_fill_rwbs()
>   block: use block_bio class for getrq and sleeprq
>   block: remove block_get_rq event class

From a tracing perspective:

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> 
>  block/bfq-iosched.c           |   4 +-
>  block/blk-core.c              |   6 +-
>  block/blk-merge.c             |   4 +-
>  block/blk-mq-sched.c          |   6 -
>  block/blk-mq-sched.h          |   1 -
>  block/blk-mq.c                |  10 +-
>  block/bounce.c                |   2 +-
>  block/kyber-iosched.c         |   4 +-
>  block/mq-deadline.c           |   4 +-
>  drivers/md/dm.c               |   4 +-
>  include/linux/blktrace_api.h  |   2 +-
>  include/trace/events/bcache.h |  10 +-
>  include/trace/events/block.h  | 226 +++++++++++-----------------------
>  kernel/trace/blktrace.c       | 129 +++++++++----------
>  14 files changed, 161 insertions(+), 251 deletions(-)
> 

