Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6177C35247
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 18:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B2220CC7
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 18:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgBCS0o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:26:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbgBCS0o (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Feb 2020 13:26:44 -0500
Received: from oasis.local.home (unknown [213.120.252.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89ADA2086A;
        Mon,  3 Feb 2020 18:26:42 +0000 (UTC)
Date:   Mon, 3 Feb 2020 13:26:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [Patch v3] block: introduce block_rq_error tracepoint
Message-ID: <20200203132638.5a37f2f2@oasis.local.home>
In-Reply-To: <20200203053650.8923-1-xiyou.wangcong@gmail.com>
References: <20200203053650.8923-1-xiyou.wangcong@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun,  2 Feb 2020 21:36:50 -0800
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>  block/blk-core.c             |  4 +++-
>  include/trace/events/block.h | 41 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 1 deletion(-)
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

I'm curious to why you don't just pass error into the trace event.
Looks like blk_status_to_errno() is a function call and that injects
code at the location of the call. Note, it is not a big deal as I
believe (haven't looked at the objdump of it), the call may be placed
in the nop portion of the code, and not hit when the trace point is not
enabled. But moving the blk_status_to_errno() call to the
TP_fast_assign() will move it to another section entirely.

I did see trace_blk_rq_complete() does the same thing, so perhaps that
could just be a clean up change after this on both trace events.



> +
> +	TP_printk("%d,%d %s %s %llu + %u [%d]",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __get_str(name), __entry->rwbs,
> +		  (unsigned long long)__entry->sector,
> +		  __entry->nr_sector, __entry->error)
> +);
> +

Other than my comment above, for the trace event correctness point of view:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
