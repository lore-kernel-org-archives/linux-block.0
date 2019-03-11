Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912F4C43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 09:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5965A206BA
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 09:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfCKJIt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:08:49 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:38620 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfCKJIt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 05:08:49 -0400
Received: from tux.wizards.de (pD9EBF050.dip0.t-ipconnect.de [217.235.240.80])
        by mail02.iobjects.de (Postfix) with ESMTPSA id E596741666B0;
        Mon, 11 Mar 2019 10:08:46 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id 862A5F01604;
        Mon, 11 Mar 2019 10:08:46 +0100 (CET)
Subject: Re: [PATCH BUGFIX IMPROVEMENT V2 7/9] block, bfq: print SHARED
 instead of pid for shared queues in logs
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        alessio.masola@gmail.com
References: <20190310181137.2604-1-paolo.valente@linaro.org>
 <20190310181137.2604-8-paolo.valente@linaro.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <491be7d2-cbe2-a1f1-e102-b449b3a8ace6@applied-asynchrony.com>
Date:   Mon, 11 Mar 2019 10:08:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190310181137.2604-8-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Guess what - more problems ;-)
This time when building without CONFIG_BFQ_GROUP_IOSCHED, see below..

On 3/10/19 7:11 PM, Paolo Valente wrote:
> From: Francesco Pollicino <fra.fra.800@gmail.com>
> 
> The function "bfq_log_bfqq" prints the pid of the process
> associated with the queue passed as input.
> 
> Unfortunately, if the queue is shared, then more than one process
> is associated with the queue. The pid that gets printed in this
> case is the pid of one of the associated processes.
> Which process gets printed depends on the exact sequence of merge
> events the queue underwent. So printing such a pid is rather
> useless and above all is often rather confusing because it
> reports a random pid between those of the associated processes.
> 
> This commit addresses this issue by printing SHARED instead of a pid
> if the queue is shared.
> 
> Signed-off-by: Francesco Pollicino <fra.fra.800@gmail.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>   block/bfq-iosched.c | 10 ++++++++++
>   block/bfq-iosched.h | 23 +++++++++++++++++++----
>   2 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 500b04df9efa..7d95d9c01036 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2590,6 +2590,16 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
>   	 *   assignment causes no harm).
>   	 */
>   	new_bfqq->bic = NULL;
> +	/*
> +	 * If the queue is shared, the pid is the pid of one of the associated
> +	 * processes. Which pid depends on the exact sequence of merge events
> +	 * the queue underwent. So printing such a pid is useless and confusing
> +	 * because it reports a random pid between those of the associated
> +	 * processes.
> +	 * We mark such a queue with a pid -1, and then print SHARED instead of
> +	 * a pid in logging messages.
> +	 */
> +	new_bfqq->pid = -1;
>   	bfqq->bic = NULL;
>   	/* release process reference to bfqq */
>   	bfq_put_queue(bfqq);
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 829730b96fb2..6410cc9a064d 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -32,6 +32,8 @@
>   #define BFQ_DEFAULT_GRP_IOPRIO	0
>   #define BFQ_DEFAULT_GRP_CLASS	IOPRIO_CLASS_BE
>   
> +#define MAX_PID_STR_LENGTH 12
> +
>   /*
>    * Soft real-time applications are extremely more latency sensitive
>    * than interactive ones. Over-raise the weight of the former to
> @@ -1016,13 +1018,23 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq);
>   /* --------------- end of interface of B-WF2Q+ ---------------- */
>   
>   /* Logging facilities. */
> +static void bfq_pid_to_str(int pid, char *str, int len)
> +{
> +	if (pid != -1)
> +		snprintf(str, len, "%d", pid);
> +	else
> +		snprintf(str, len, "SHARED-");
> +}
> +
>   #ifdef CONFIG_BFQ_GROUP_IOSCHED
>   struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
>   
>   #define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	do {			\
> +	char pid_str[MAX_PID_STR_LENGTH];	\
> +	bfq_pid_to_str((bfqq)->pid, pid_str, MAX_PID_STR_LENGTH);	\
>   	blk_add_cgroup_trace_msg((bfqd)->queue,				\
>   			bfqg_to_blkg(bfqq_group(bfqq))->blkcg,		\
> -			"bfq%d%c " fmt, (bfqq)->pid,			\
> +			"bfq%s%c " fmt, pid_str,			\
>   			bfq_bfqq_sync((bfqq)) ? 'S' : 'A', ##args);	\
>   } while (0)
>   
> @@ -1033,10 +1045,13 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
>   
>   #else /* CONFIG_BFQ_GROUP_IOSCHED */
>   
> -#define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	\
> -	blk_add_trace_msg((bfqd)->queue, "bfq%d%c " fmt, (bfqq)->pid,	\
> +#define bfq_log_bfqq(bfqd, bfqq, fmt, args...) do {	\
> +	char pid_str[MAX_PID_STR_LENGTH];	\
> +	bfq_pid_to_str((bfqq)->pid, pid_str, MAX_PID_STR_LENGTH);	\
> +	blk_add_trace_msg((bfqd)->queue, "bfq%s%c " fmt, pid_str,	\
>   			bfq_bfqq_sync((bfqq)) ? 'S' : 'A',		\
> -				##args)
> +				##args)		\
---------------------------------------^ compilation error due to missing ;

> +} while (0)
>   #define bfq_log_bfqg(bfqd, bfqg, fmt, args...)		do {} while (0)
^^^^^^^^^^^^^^^^^^^^^^^^
Here you re- and effectively undefine the previous new bfq_log_bfqq()
definition with an empty block; I think you wanted to delete the second
(empty) definition, otherwise the new code won't do much.

Finally there is now a warning at bfq-cgroup.c:25 that bfq_pid_to_str()
is defined but not used (in that compilation unit) since it is defined
unconditionally for both cases of CONFIG_BFQ_GROUP_IOSCHED, which is
required for bfq-cgroup.c. Since reordering the includes there won't work
due to ifdef overlaps, the easiest fix for that is to mark bfq_pid_to_str()
as "static inline", as already suggested by Oleksandr.

With those changes it builds.

cheers,
Holger
