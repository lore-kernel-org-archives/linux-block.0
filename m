Return-Path: <SRS0=Aqm6=3J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5152C2D0DB
	for <linux-block@archiver.kernel.org>; Mon, 20 Jan 2020 18:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A563F22525
	for <linux-block@archiver.kernel.org>; Mon, 20 Jan 2020 18:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgATS2P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jan 2020 13:28:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATS2P (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jan 2020 13:28:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CA2422525;
        Mon, 20 Jan 2020 18:28:13 +0000 (UTC)
Date:   Mon, 20 Jan 2020 13:28:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: introduce block_rq_error tracepoint
Message-ID: <20200120132812.384274d3@gandalf.local.home>
In-Reply-To: <20200110221500.19678-1-xiyou.wangcong@gmail.com>
References: <20200110221500.19678-1-xiyou.wangcong@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 10 Jan 2020 14:15:00 -0800
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> Currently, rasdaemon uses the existing tracepoint block_rq_complete
> and filters out non-error cases in order to capture block disk errors.
> 
> But there are a few problems with this approach:
> 
> 1. Even kernel trace filter could do the filtering work, there is
>    still some overhead after we enable this tracepoint.
> 
> 2. The filter is merely based on errno, which does not align with kernel
>    logic to check the errors for print_req_error().
> 
> 3. block_rq_complete only provides dev major and minor to identify
>    the block device, it is not convenient to use in user-space.
> 
> So introduce a new tracepoint block_rq_error just for the error case
> and provides the device name for convenience too. With this patch,
> rasdaemon could switch to block_rq_error.
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>  block/blk-core.c             |  4 +++-
>  include/trace/events/block.h | 43 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 089e890ab208..0c7ad70d06be 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1450,8 +1450,10 @@ bool blk_update_request(struct request *req, blk_status_t error,
>  #endif
>  
>  	if (unlikely(error && !blk_rq_is_passthrough(req) &&
> -		     !(req->rq_flags & RQF_QUIET)))
> +		     !(req->rq_flags & RQF_QUIET))) {
> +		trace_block_rq_error(req, blk_status_to_errno(error), nr_bytes);
>  		print_req_error(req, error, __func__);
> +	}
>  
>  	blk_account_io_completion(req, nr_bytes);
>  
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index 81b43f5bdf23..a0f63f4d50c4 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -145,6 +145,49 @@ TRACE_EVENT(block_rq_complete,
>  		  __entry->nr_sector, __entry->error)
>  );
>  
> +/**
> + * block_rq_error - block IO operation error reported by device driver
> + * @rq: block operations request
> + * @error: status code
> + * @nr_bytes: number of completed bytes
> + *
> + * The block_rq_error tracepoint event indicates that some portion
> + * of operation request has failed as reported by the device driver.
> + */
> +TRACE_EVENT(block_rq_error,
> +
> +	TP_PROTO(struct request *rq, int error, unsigned int nr_bytes),
> +
> +	TP_ARGS(rq, error, nr_bytes),
> +
> +	TP_STRUCT__entry(
> +		__field(  dev_t,	dev			)
> +		__field(  char *,	name			)

Please make this a string() field and not a pointer to name.

> +		__field(  sector_t,	sector			)
> +		__field(  unsigned int,	nr_sector		)
> +		__field(  int,		error			)
> +		__array(  char,		rwbs,	RWBS_LEN	)
> +		__dynamic_array( char,	cmd,	1		)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev	   = rq->rq_disk ? disk_devt(rq->rq_disk) : 0;
> +		__entry->name	   = rq->rq_disk ? rq->rq_disk->disk_name : "?";
> +		__entry->sector    = blk_rq_pos(rq);
> +		__entry->nr_sector = nr_bytes >> 9;
> +		__entry->error     = error;
> +
> +		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, nr_bytes);
> +		__get_str(cmd)[0] = '\0';
> +	),
> +
> +	TP_printk("%d,%d %s %s (%s) %llu + %u [%d]",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->name, __entry->rwbs, __get_str(cmd),

The ring buffer will hold a pointer to a location that may no longer
exist, and cause a fault when read. Also, this makes the user space
utilities trace-cmd and perf useless to know what the name is, as they
read the raw ring buffer data directly.

-- Steve


> +		  (unsigned long long)__entry->sector,
> +		  __entry->nr_sector, __entry->error)
> +);
> +
>  DECLARE_EVENT_CLASS(block_rq,
>  
>  	TP_PROTO(struct request_queue *q, struct request *rq),

