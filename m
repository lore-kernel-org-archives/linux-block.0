Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] bdi: Fix oops in wb_workfn()
To: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Tejun Heo <tj@kernel.org>
References: <20180503162626.27753-1-jack@suse.cz>
 <20180509103135.akgp2u5pzkahji6n@quack2.suse.cz>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2a885953-41e5-0621-06db-0f22d4c4807d@kernel.dk>
Date: Wed, 9 May 2018 08:42:56 -0600
MIME-Version: 1.0
In-Reply-To: <20180509103135.akgp2u5pzkahji6n@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/9/18 4:31 AM, Jan Kara wrote:
> On Thu 03-05-18 18:26:26, Jan Kara wrote:
>> Syzbot has reported that it can hit a NULL pointer dereference in
>> wb_workfn() due to wb->bdi->dev being NULL. This indicates that
>> wb_workfn() was called for an already unregistered bdi which should not
>> happen as wb_shutdown() called from bdi_unregister() should make sure
>> all pending writeback works are completed before bdi is unregistered.
>> Except that wb_workfn() itself can requeue the work with:
>>
>> 	mod_delayed_work(bdi_wq, &wb->dwork, 0);
>>
>> and if this happens while wb_shutdown() is waiting in:
>>
>> 	flush_delayed_work(&wb->dwork);
>>
>> the dwork can get executed after wb_shutdown() has finished and
>> bdi_unregister() has cleared wb->bdi->dev.
>>
>> Make wb_workfn() use wakeup_wb() for requeueing the work which takes all
>> the necessary precautions against racing with bdi unregistration.
>>
>> CC: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> CC: Tejun Heo <tj@kernel.org>
>> Fixes: 839a8e8660b6777e7fe4e80af1a048aebe2b5977
>> Reported-by: syzbot <syzbot+9873874c735f2892e7e9@syzkaller.appspotmail.com>
>> Signed-off-by: Jan Kara <jack@suse.cz>
>> ---
>>  fs/fs-writeback.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Jens, can you please pick up this patch? Probably for the next merge window
> (I don't see a reason to rush this at this point in release cycle). Thanks!

Looks like I never replied that back, but I did pick it up, and it did
in fact go out last week for this series. So we should be all good. I
didn't see a need to postpone it, it's obviously correct and fixes
a real issue.

-- 
Jens Axboe
