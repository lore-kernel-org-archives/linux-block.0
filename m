Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
To: Jan Kara <jack@suse.cz>
Cc: Tejun Heo <tj@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>, linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz>
 <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
 <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz>
 <20180611172053.GR1351649@devbig577.frc2.facebook.com>
 <20180612155754.x5k2yndh5t6wlmpy@quack2.suse.cz>
 <b210e55c-b06a-41ff-8592-0dbe21875779@i-love.sakura.ne.jp>
 <20180613144606.nvbcyg2rdjpxhf7s@quack2.suse.cz>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <7f4ae045-dfe4-6677-7418-f6f60b6c26f1@i-love.sakura.ne.jp>
Date: Thu, 14 Jun 2018 01:20:16 +0900
MIME-Version: 1.0
In-Reply-To: <20180613144606.nvbcyg2rdjpxhf7s@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 2018/06/13 23:46, Jan Kara wrote:
> On Wed 13-06-18 19:43:47, Tetsuo Handa wrote:
>> Can't we utilize RCU grace period (like shown below) ?
> 
> Honestly, the variant 1 looks too ugly to me. However variant 2 looks
> mostly OK. We can also avoid the schedule_timeout_uninterruptible(HZ / 10)
> from your patch by careful handling of the bit waitqueues. Also I'd avoid
> the addition argument to wb_writeback() and split the function instead. The
> patch resulting from your and mine ideas is attached. Thoughts?
> 
> 								Honza
> 

+static bool cgwb_start_shutdown(struct bdi_writeback *wb)
+	__releases(cgwb_lock)
+{
+	if (!wb_start_shutdown(wb)) {
+		DEFINE_WAIT(wait);
+		wait_queue_head_t *wqh = bit_waitqueue(&wb->state,
+						       WB_shutting_down);
+		bool sleep;
+
+		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+		sleep = test_bit(WB_shutting_down, &wb->state);
+		spin_unlock_irq(&cgwb_lock);
+		if (sleep)
+			schedule();
+		return false;
+	}
+	spin_unlock_irq(&cgwb_lock);
+	return true;
+}

Since multiple addresses share bit_wait_table[256], isn't it possible that
cgwb_start_shutdown() prematurely returns false due to wake_up_bit() by
hash-conflicting addresses (i.e. not limited to clear_and_wake_up_bit() from
wb_shutdown())? I think that we cannot be sure without confirming that
test_bit(WB_shutting_down, &wb->state) == false after returning from schedule().
