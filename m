Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60809 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbcEJPwS (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 11:52:18 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: Shaohua Li <shli@fb.com>
Cc: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, <axboe@fb.com>,
	<Kernel-team@fb.com>
Subject: Re: [PATCH 3/3] blk-throttle: don't parse cgroup path if trace isn't enabled
References: <2c3ee532132f8925dd0be1178e8dee0bba6b448c.1462838969.git.shli@fb.com>
	<b395946862a1a963e6d74b70349322eceb5d42d4.1462838969.git.shli@fb.com>
Date: Tue, 10 May 2016 11:52:15 -0400
In-Reply-To: <b395946862a1a963e6d74b70349322eceb5d42d4.1462838969.git.shli@fb.com>
	(Shaohua Li's message of "Mon, 9 May 2016 17:22:15 -0700")
Message-ID: <x49a8jx7vww.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Shaohua Li <shli@fb.com> writes:

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

You've only addressed the second part of the TODO, please don't remove
the first part.

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

Do we want to return !!(bt->act_mask & BLK_TC_NOTIFY)?

-Jeff

> +}
> +
>  extern void blk_add_driver_data(struct request_queue *q, struct request *rq,
>  				void *data, size_t len);
>  extern int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
> @@ -79,6 +87,7 @@ extern struct attribute_group blk_trace_attr_group;
>  # define blk_trace_remove(q)				(-ENOTTY)
>  # define blk_add_trace_msg(q, fmt, ...)			do { } while (0)
>  # define blk_trace_remove_sysfs(dev)			do { } while (0)
> +# define blk_trace_note_message_enabled(q)		(false)
>  static inline int blk_trace_init_sysfs(struct device *dev)
>  {
>  	return 0;
