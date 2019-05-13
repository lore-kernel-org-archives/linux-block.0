Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AE7C04AA7
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 18:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBCF208C3
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 18:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEMSZh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 May 2019 14:25:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:50626 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725928AbfEMSZh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 14:25:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ABD7BADD5;
        Mon, 13 May 2019 18:25:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 May 2019 20:25:35 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] io_uring: fix infinite wait in khread_park() on
 io_finish_async()
In-Reply-To: <20190513182028.29912-1-rpenyaev@suse.de>
References: <20190513182028.29912-1-rpenyaev@suse.de>
Message-ID: <f3aa208b4fbbd3d1afa8a486ce078b3b@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

I forgot to mention that dead lock is quite well reproduced
if app is killed, when no IO is performed (i.e. polling thread
is scheduled out).

--
Roman


On 2019-05-13 20:20, Roman Penyaev wrote:
> This fixes couple of races which lead to infinite wait of park 
> completion
> with the following backtraces:
> 
>   [20801.303319] Call Trace:
>   [20801.303321]  ? __schedule+0x284/0x650
>   [20801.303323]  schedule+0x33/0xc0
>   [20801.303324]  schedule_timeout+0x1bc/0x210
>   [20801.303326]  ? schedule+0x3d/0xc0
>   [20801.303327]  ? schedule_timeout+0x1bc/0x210
>   [20801.303329]  ? preempt_count_add+0x79/0xb0
>   [20801.303330]  wait_for_completion+0xa5/0x120
>   [20801.303331]  ? wake_up_q+0x70/0x70
>   [20801.303333]  kthread_park+0x48/0x80
>   [20801.303335]  io_finish_async+0x2c/0x70
>   [20801.303336]  io_ring_ctx_wait_and_kill+0x95/0x180
>   [20801.303338]  io_uring_release+0x1c/0x20
>   [20801.303339]  __fput+0xad/0x210
>   [20801.303341]  task_work_run+0x8f/0xb0
>   [20801.303342]  exit_to_usermode_loop+0xa0/0xb0
>   [20801.303343]  do_syscall_64+0xe0/0x100
>   [20801.303349]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
>   [20801.303380] Call Trace:
>   [20801.303383]  ? __schedule+0x284/0x650
>   [20801.303384]  schedule+0x33/0xc0
>   [20801.303386]  io_sq_thread+0x38a/0x410
>   [20801.303388]  ? __switch_to_asm+0x40/0x70
>   [20801.303390]  ? wait_woken+0x80/0x80
>   [20801.303392]  ? _raw_spin_lock_irqsave+0x17/0x40
>   [20801.303394]  ? io_submit_sqes+0x120/0x120
>   [20801.303395]  kthread+0x112/0x130
>   [20801.303396]  ? kthread_create_on_node+0x60/0x60
>   [20801.303398]  ret_from_fork+0x35/0x40
> 
>  o kthread_park() waits for park completion, so io_sq_thread() loop
>    should check kthread_should_park() along with khread_should_stop(),
>    otherwise if kthread_park() is called before prepare_to_wait()
>    the following schedule() never returns.
> 
>  o if the flag ctx->sqo_stop is observed by the io_sq_thread() loop
>    it is quite possible, that kthread_should_park() check and the
>    following kthread_parkme() is never called, because kthread_park()
>    has not been yet called, but few moments later is is called and
>    waits there for park completion, which never happens, because
>    kthread has already exited.
> 
> It seems that parking here is not needed at all (thread is parked and
> then stopped and never unparked), so here in this patch I simply rely
> on kthread_should_stop() check and then exit the thread.
> 
> Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> ---
>  fs/io_uring.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 452e35357865..449c652bb334 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -231,7 +231,6 @@ struct io_ring_ctx {
>  	struct task_struct	*sqo_thread;	/* if using sq thread polling */
>  	struct mm_struct	*sqo_mm;
>  	wait_queue_head_t	sqo_wait;
> -	unsigned		sqo_stop;
> 
>  	struct {
>  		/* CQ ring */
> @@ -2028,7 +2027,7 @@ static int io_sq_thread(void *data)
>  	set_fs(USER_DS);
> 
>  	timeout = inflight = 0;
> -	while (!kthread_should_stop() && !ctx->sqo_stop) {
> +	while (!kthread_should_stop()) {
>  		bool all_fixed, mm_fault = false;
>  		int i;
> 
> @@ -2140,9 +2139,6 @@ static int io_sq_thread(void *data)
>  		mmput(cur_mm);
>  	}
> 
> -	if (kthread_should_park())
> -		kthread_parkme();
> -
>  	return 0;
>  }
> 
> @@ -2273,9 +2269,6 @@ static int io_sqe_files_unregister(struct
> io_ring_ctx *ctx)
>  static void io_sq_thread_stop(struct io_ring_ctx *ctx)
>  {
>  	if (ctx->sqo_thread) {
> -		ctx->sqo_stop = 1;
> -		mb();
> -		kthread_park(ctx->sqo_thread);
>  		kthread_stop(ctx->sqo_thread);
>  		ctx->sqo_thread = NULL;
>  	}

