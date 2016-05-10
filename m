Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42028 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751587AbcEJOb2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 10:31:28 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: Shaohua Li <shli@fb.com>
Cc: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, <axboe@fb.com>,
	<Kernel-team@fb.com>
Subject: Re: [PATCH 1/3] blktrace: delete garbage for message trace
References: <2c3ee532132f8925dd0be1178e8dee0bba6b448c.1462838969.git.shli@fb.com>
Date: Tue, 10 May 2016 10:31:25 -0400
In-Reply-To: <2c3ee532132f8925dd0be1178e8dee0bba6b448c.1462838969.git.shli@fb.com>
	(Shaohua Li's message of "Mon, 9 May 2016 17:22:13 -0700")
Message-ID: <x49inym6l36.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Shaohua Li <shli@fb.com> writes:

> commit f4a1d08ce65 introduces a regression. Originally for
> BLK_TN_MESSAGE, we add message in trace and return. The commit ignores
> the early return and add garbage info.
>
> Signed-off-by: Shaohua Li <shli@fb.com>
> ---
>  kernel/trace/blktrace.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index f94e7a2..8ae9ea2 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -1349,6 +1349,7 @@ static enum print_line_t print_one_line(struct trace_iterator *iter,
>  	if (t->action == BLK_TN_MESSAGE) {
>  		log_action(iter, long_act ? "message" : "m");
>  		blk_log_msg(s, iter->ent);
> +		return trace_handle_return(s);
>  	}
>  
>  	if (unlikely(what == 0 || what >= ARRAY_SIZE(what2act)))

It would have been closer to the original to put the 'out' label back
in, but this is fine.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
