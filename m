Return-Path: <axboe@kernel.dk>
Subject: Re: INFO: task hung in wb_shutdown (2)
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 torvalds@linux-foundation.org
Cc: jack@suse.cz, tj@kernel.org,
 syzbot+c0cf869505e03bdf1a24@syzkaller.appspotmail.com,
 christophe.jaillet@wanadoo.fr, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
 zhangweiping@didichuxing.com, akpm@linux-foundation.org, dvyukov@google.com,
 linux-block@vger.kernel.org
References: <94eb2c05b2d83650030568cc8bd9@google.com>
 <e56c1600-8923-dd6b-d065-c2fd2a720404@I-love.SAKURA.ne.jp>
 <43302799-1c50-4cab-b974-9fe1ca584813@I-love.SAKURA.ne.jp>
 <CA+55aFxaa_+uZ=bOVdevcUwG7ncue7O+i06q4Kb=bWACGwCBjQ@mail.gmail.com>
 <bd3e8460-9794-6b57-e7d6-7e18ea34ac0c@kernel.dk>
 <201805020714.FDD52145.OOJtOFVFSMLQFH@I-love.SAKURA.ne.jp>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9cafa39a-aa2e-f4f0-02ae-a11e7ddace8d@kernel.dk>
Date: Thu, 3 May 2018 09:25:13 -0600
MIME-Version: 1.0
In-Reply-To: <201805020714.FDD52145.OOJtOFVFSMLQFH@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/1/18 4:14 PM, Tetsuo Handa wrote:
>>>From 1b90d7f71d60e743c69cdff3ba41edd1f9f86f93 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Wed, 2 May 2018 07:07:55 +0900
> Subject: [PATCH v2] bdi: wake up concurrent wb_shutdown() callers.
> 
> syzbot is reporting hung tasks at wait_on_bit(WB_shutting_down) in
> wb_shutdown() [1]. This seems to be because commit 5318ce7d46866e1d ("bdi:
> Shutdown writeback on all cgwbs in cgwb_bdi_destroy()") forgot to call
> wake_up_bit(WB_shutting_down) after clear_bit(WB_shutting_down).
> 
> Introduce a helper function clear_and_wake_up_bit() and use it, in order
> to avoid similar errors in future.

Queued up, thanks Tetsuo!

-- 
Jens Axboe
