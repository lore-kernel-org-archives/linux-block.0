Return-Path: <SRS0=Dkg2=TO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DE7C04AB4
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 09:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B561204FD
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 09:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfENJRV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 May 2019 05:17:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:51906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726058AbfENJRV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 May 2019 05:17:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D28A2AF01;
        Tue, 14 May 2019 09:17:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 May 2019 11:17:19 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] io_uring: fix infinite wait in khread_park() on
 io_finish_async()
In-Reply-To: <bcf3f935-e2c0-6bcf-92fb-760583ff5500@kernel.dk>
References: <20190513182028.29912-1-rpenyaev@suse.de>
 <bcf3f935-e2c0-6bcf-92fb-760583ff5500@kernel.dk>
Message-ID: <18e65f75e5a3972bec42d830ac397501@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-05-13 20:52, Jens Axboe wrote:
> On 5/13/19 12:20 PM, Roman Penyaev wrote:
>> This fixes couple of races which lead to infinite wait of park 
>> completion
>> with the following backtraces:
>> 
>>   [20801.303319] Call Trace:
>>   [20801.303321]  ? __schedule+0x284/0x650
>>   [20801.303323]  schedule+0x33/0xc0
>>   [20801.303324]  schedule_timeout+0x1bc/0x210
>>   [20801.303326]  ? schedule+0x3d/0xc0
>>   [20801.303327]  ? schedule_timeout+0x1bc/0x210
>>   [20801.303329]  ? preempt_count_add+0x79/0xb0
>>   [20801.303330]  wait_for_completion+0xa5/0x120
>>   [20801.303331]  ? wake_up_q+0x70/0x70
>>   [20801.303333]  kthread_park+0x48/0x80
>>   [20801.303335]  io_finish_async+0x2c/0x70
>>   [20801.303336]  io_ring_ctx_wait_and_kill+0x95/0x180
>>   [20801.303338]  io_uring_release+0x1c/0x20
>>   [20801.303339]  __fput+0xad/0x210
>>   [20801.303341]  task_work_run+0x8f/0xb0
>>   [20801.303342]  exit_to_usermode_loop+0xa0/0xb0
>>   [20801.303343]  do_syscall_64+0xe0/0x100
>>   [20801.303349]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> 
>>   [20801.303380] Call Trace:
>>   [20801.303383]  ? __schedule+0x284/0x650
>>   [20801.303384]  schedule+0x33/0xc0
>>   [20801.303386]  io_sq_thread+0x38a/0x410
>>   [20801.303388]  ? __switch_to_asm+0x40/0x70
>>   [20801.303390]  ? wait_woken+0x80/0x80
>>   [20801.303392]  ? _raw_spin_lock_irqsave+0x17/0x40
>>   [20801.303394]  ? io_submit_sqes+0x120/0x120
>>   [20801.303395]  kthread+0x112/0x130
>>   [20801.303396]  ? kthread_create_on_node+0x60/0x60
>>   [20801.303398]  ret_from_fork+0x35/0x40
>> 
>>  o kthread_park() waits for park completion, so io_sq_thread() loop
>>    should check kthread_should_park() along with khread_should_stop(),
>>    otherwise if kthread_park() is called before prepare_to_wait()
>>    the following schedule() never returns.
>> 
>>  o if the flag ctx->sqo_stop is observed by the io_sq_thread() loop
>>    it is quite possible, that kthread_should_park() check and the
>>    following kthread_parkme() is never called, because kthread_park()
>>    has not been yet called, but few moments later is is called and
>>    waits there for park completion, which never happens, because
>>    kthread has already exited.
>> 
>> It seems that parking here is not needed at all (thread is parked and
>> then stopped and never unparked), so here in this patch I simply rely
>> on kthread_should_stop() check and then exit the thread.
> 
> The park is a bit of a work-around, without it we get warning spews on
> shutdown with SQPOLL set and affinity set to a single CPU.
> 
> Also see:
> 
> commit 06058632464845abb1af91521122fd04dd3daaec
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Sat Apr 13 09:26:03 2019 -0600
> 
>     io_uring: park SQPOLL thread if it's percpu

I see.  Do you think it makes sense to fix this is kthread?  With 
something
as the following:

diff --git a/kernel/kthread.c b/kernel/kthread.c
index be4e8795561a..191f8be5c9e0 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -472,6 +472,10 @@ void kthread_unpark(struct task_struct *k)
  {
         struct kthread *kthread = to_kthread(k);

+       if (!__kthread_should_park(k))
+               /* Nop if thread was never parked */
+               break;
+



Nevertheless, the other way is to fix io_uring: we quit loop by
only kthread_should_park() check (kthread_park() is synchronous,
so kthread_should_stop() is never observed), and we abandon
->sqo_stop flag, because it is racy. At the end we always parkme(),
because we've exited the loop by park flag.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 452e35357865..9401ac1bbd46 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -231,7 +231,6 @@ struct io_ring_ctx {
         struct task_struct      *sqo_thread;    /* if using sq thread 
polling */
         struct mm_struct        *sqo_mm;
         wait_queue_head_t       sqo_wait;
-       unsigned                sqo_stop;

         struct {
                 /* CQ ring */
@@ -2028,7 +2027,7 @@ static int io_sq_thread(void *data)
         set_fs(USER_DS);

         timeout = inflight = 0;
-       while (!kthread_should_stop() && !ctx->sqo_stop) {
+       while (!kthread_should_park()) {
                 bool all_fixed, mm_fault = false;
                 int i;

@@ -2090,7 +2089,7 @@ static int io_sq_thread(void *data)
                         smp_mb();

                         if (!io_get_sqring(ctx, &sqes[0])) {
-                               if (kthread_should_stop()) {
+                               if (kthread_should_park()) {
                                         finish_wait(&ctx->sqo_wait, 
&wait);
                                         break;
                                 }
@@ -2140,8 +2139,7 @@ static int io_sq_thread(void *data)
                 mmput(cur_mm);
         }

-       if (kthread_should_park())
-               kthread_parkme();
+       kthread_parkme();

         return 0;
  }
@@ -2273,8 +2271,11 @@ static int io_sqe_files_unregister(struct 
io_ring_ctx *ctx)
  static void io_sq_thread_stop(struct io_ring_ctx *ctx)
  {
         if (ctx->sqo_thread) {
-               ctx->sqo_stop = 1;
-               mb();
+               /*
+                * The park is a bit of a work-around, without it we get
+                * warning spews on shutdown with SQPOLL set and 
affinity
+                * set to a single CPU.
+                */
                 kthread_park(ctx->sqo_thread);
                 kthread_stop(ctx->sqo_thread);
                 ctx->sqo_thread = NULL;


Makes sense?


--
Roman





