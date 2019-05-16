Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94E5C04E87
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9723D20862
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfEPIyL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 04:54:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:34228 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726778AbfEPIyK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 04:54:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F881AE8A;
        Thu, 16 May 2019 08:54:09 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH v2 1/1] io_uring: fix infinite wait in khread_park() on io_finish_async()
Date:   Thu, 16 May 2019 10:53:57 +0200
Message-Id: <20190516085357.30801-1-rpenyaev@suse.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This fixes couple of races which lead to infinite wait of park completion
with the following backtraces:

  [20801.303319] Call Trace:
  [20801.303321]  ? __schedule+0x284/0x650
  [20801.303323]  schedule+0x33/0xc0
  [20801.303324]  schedule_timeout+0x1bc/0x210
  [20801.303326]  ? schedule+0x3d/0xc0
  [20801.303327]  ? schedule_timeout+0x1bc/0x210
  [20801.303329]  ? preempt_count_add+0x79/0xb0
  [20801.303330]  wait_for_completion+0xa5/0x120
  [20801.303331]  ? wake_up_q+0x70/0x70
  [20801.303333]  kthread_park+0x48/0x80
  [20801.303335]  io_finish_async+0x2c/0x70
  [20801.303336]  io_ring_ctx_wait_and_kill+0x95/0x180
  [20801.303338]  io_uring_release+0x1c/0x20
  [20801.303339]  __fput+0xad/0x210
  [20801.303341]  task_work_run+0x8f/0xb0
  [20801.303342]  exit_to_usermode_loop+0xa0/0xb0
  [20801.303343]  do_syscall_64+0xe0/0x100
  [20801.303349]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

  [20801.303380] Call Trace:
  [20801.303383]  ? __schedule+0x284/0x650
  [20801.303384]  schedule+0x33/0xc0
  [20801.303386]  io_sq_thread+0x38a/0x410
  [20801.303388]  ? __switch_to_asm+0x40/0x70
  [20801.303390]  ? wait_woken+0x80/0x80
  [20801.303392]  ? _raw_spin_lock_irqsave+0x17/0x40
  [20801.303394]  ? io_submit_sqes+0x120/0x120
  [20801.303395]  kthread+0x112/0x130
  [20801.303396]  ? kthread_create_on_node+0x60/0x60
  [20801.303398]  ret_from_fork+0x35/0x40

 o kthread_park() waits for park completion, so io_sq_thread() loop
   should check kthread_should_park() along with khread_should_stop(),
   otherwise if kthread_park() is called before prepare_to_wait()
   the following schedule() never returns:

   CPU#0                    CPU#1

   io_sq_thread_stop():     io_sq_thread():

                               while(!kthread_should_stop() && !ctx->sqo_stop) {

      ctx->sqo_stop = 1;
      kthread_park()

	                            prepare_to_wait();
                                    if (kthread_should_stop() {
				    }
                                    schedule();   <<< nobody checks park flag,
				                  <<< so schedule and never return

 o if the flag ctx->sqo_stop is observed by the io_sq_thread() loop
   it is quite possible, that kthread_should_park() check and the
   following kthread_parkme() is never called, because kthread_park()
   has not been yet called, but few moments later is is called and
   waits there for park completion, which never happens, because
   kthread has already exited:

   CPU#0                    CPU#1

   io_sq_thread_stop():     io_sq_thread():

      ctx->sqo_stop = 1;
                               while(!kthread_should_stop() && !ctx->sqo_stop) {
                                   <<< observe sqo_stop and exit the loop
			       }

			       if (kthread_should_park())
			           kthread_parkme();  <<< never called, since was
					              <<< never parked

      kthread_park()           <<< waits forever for park completion

In the current patch we quit the loop by only kthread_should_park()
check (kthread_park() is synchronous, so kthread_should_stop() is
never observed), and we abandon ->sqo_stop flag, since it is racy.
At the end of the io_sq_thread() we unconditionally call parmke(),
since we've exited the loop by the park flag.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 fs/io_uring.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 452e35357865..64e75577be54 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -231,7 +231,6 @@ struct io_ring_ctx {
 	struct task_struct	*sqo_thread;	/* if using sq thread polling */
 	struct mm_struct	*sqo_mm;
 	wait_queue_head_t	sqo_wait;
-	unsigned		sqo_stop;
 
 	struct {
 		/* CQ ring */
@@ -2028,7 +2027,7 @@ static int io_sq_thread(void *data)
 	set_fs(USER_DS);
 
 	timeout = inflight = 0;
-	while (!kthread_should_stop() && !ctx->sqo_stop) {
+	while (!kthread_should_park()) {
 		bool all_fixed, mm_fault = false;
 		int i;
 
@@ -2090,7 +2089,7 @@ static int io_sq_thread(void *data)
 			smp_mb();
 
 			if (!io_get_sqring(ctx, &sqes[0])) {
-				if (kthread_should_stop()) {
+				if (kthread_should_park()) {
 					finish_wait(&ctx->sqo_wait, &wait);
 					break;
 				}
@@ -2140,8 +2139,7 @@ static int io_sq_thread(void *data)
 		mmput(cur_mm);
 	}
 
-	if (kthread_should_park())
-		kthread_parkme();
+	kthread_parkme();
 
 	return 0;
 }
@@ -2273,8 +2271,11 @@ static int io_sqe_files_unregister(struct io_ring_ctx *ctx)
 static void io_sq_thread_stop(struct io_ring_ctx *ctx)
 {
 	if (ctx->sqo_thread) {
-		ctx->sqo_stop = 1;
-		mb();
+		/*
+		 * The park is a bit of a work-around, without it we get
+		 * warning spews on shutdown with SQPOLL set and affinity
+		 * set to a single CPU.
+		 */
 		kthread_park(ctx->sqo_thread);
 		kthread_stop(ctx->sqo_thread);
 		ctx->sqo_thread = NULL;
-- 
2.21.0

