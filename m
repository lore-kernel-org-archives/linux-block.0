Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34435 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbcEKIPf (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 11 May 2016 04:15:35 -0400
Date: Tue, 10 May 2016 13:46:13 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, axboe@fb.com,
	Kernel-team@fb.com
Subject: Re: [PATCH 3/3] blk-throttle: don't parse cgroup path if trace isn't
 enabled
Message-ID: <20160510054613.GA12366@simonLocalRHEL7.x64>
References: <2c3ee532132f8925dd0be1178e8dee0bba6b448c.1462838969.git.shli@fb.com>
 <b395946862a1a963e6d74b70349322eceb5d42d4.1462838969.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b395946862a1a963e6d74b70349322eceb5d42d4.1462838969.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi, 
On Mon, May 09, 2016 at 05:22:15PM -0700, Shaohua Li wrote:
> if trace isn't enabled, parsing cgroup path just wastes cpu
> 
> Signed-off-by: Shaohua Li <shli@fb.com>
> ---
>  block/blk-throttle.c         | 5 ++---
>  include/linux/blktrace_api.h | 9 +++++++++
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 2149a1d..47a3e54 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -211,15 +211,14 @@ static struct throtl_data *sq_to_td(struct throtl_service_queue *sq)
>   *
>   * The messages are prefixed with "throtl BLKG_NAME" if @sq belongs to a
>   * throtl_grp; otherwise, just "throtl".
> - *
> - * TODO: this should be made a function and name formatting should happen
> - * after testing whether blktrace is enabled.
>   */
>  #define throtl_log(sq, fmt, args...)	do {				\
>  	struct throtl_grp *__tg = sq_to_tg((sq));			\
>  	struct throtl_data *__td = sq_to_td((sq));			\
>  									\
>  	(void)__td;							\
> +	if (likely(!blk_trace_note_message_enabled(__td->queue)))	\
> +		break;							\
>  	if ((__tg)) {							\
>  		char __pbuf[128];					\
>  									\
> diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
> index afc1343..0f3172b 100644
> --- a/include/linux/blktrace_api.h
> +++ b/include/linux/blktrace_api.h
> @@ -57,6 +57,14 @@ void __trace_note_message(struct blk_trace *, const char *fmt, ...);
>  	} while (0)
>  #define BLK_TN_MAX_MSG		128
>  
> +static inline bool blk_trace_note_message_enabled(struct request_queue *q)
> +{
> +	struct blk_trace *bt = q->blk_trace;
> +	if (likely(!bt))
> +		return false;
> +	return bt->act_mask & BLK_TC_NOTIFY;
> +}
Is there any reason to skip following condition?
        if (unlikely(bt->trace_state != Blktrace_running &&
                     !blk_tracer_enabled))

Thanks,
- Simon
