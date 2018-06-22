Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
To: Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20180618134658.32302-1-jack@suse.cz>
 <20180618174014.GY1351649@devbig577.frc2.facebook.com>
 <20180622085249.afwqhomhxkwepq5q@quack2.suse.cz>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8d2371b8-987e-5b10-2f34-2b62de45e88a@kernel.dk>
Date: Fri, 22 Jun 2018 12:08:20 -0600
MIME-Version: 1.0
In-Reply-To: <20180622085249.afwqhomhxkwepq5q@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/22/18 2:52 AM, Jan Kara wrote:
> On Mon 18-06-18 10:40:14, Tejun Heo wrote:
>> On Mon, Jun 18, 2018 at 03:46:58PM +0200, Jan Kara wrote:
>>> syzbot is reporting NULL pointer dereference at wb_workfn() [1] due to
>>> wb->bdi->dev being NULL. And Dmitry confirmed that wb->state was
>>> WB_shutting_down after wb->bdi->dev became NULL. This indicates that
>>> unregister_bdi() failed to call wb_shutdown() on one of wb objects.
>>>
>>> The problem is in cgwb_bdi_unregister() which does cgwb_kill() and thus
>>> drops bdi's reference to wb structures before going through the list of
>>> wbs again and calling wb_shutdown() on each of them. This way the loop
>>> iterating through all wbs can easily miss a wb if that wb has already
>>> passed through cgwb_remove_from_bdi_list() called from wb_shutdown()
>>> from cgwb_release_workfn() and as a result fully shutdown bdi although
>>> wb_workfn() for this wb structure is still running. In fact there are
>>> also other ways cgwb_bdi_unregister() can race with
>>> cgwb_release_workfn() leading e.g. to use-after-free issues:
>>>
>>> CPU1                            CPU2
>>>                                 cgwb_bdi_unregister()
>>>                                   cgwb_kill(*slot);
>>>
>>> cgwb_release()
>>>   queue_work(cgwb_release_wq, &wb->release_work);
>>> cgwb_release_workfn()
>>>                                   wb = list_first_entry(&bdi->wb_list, ...)
>>>                                   spin_unlock_irq(&cgwb_lock);
>>>   wb_shutdown(wb);
>>>   ...
>>>   kfree_rcu(wb, rcu);
>>>                                   wb_shutdown(wb); -> oops use-after-free
>>>
>>> We solve these issues by synchronizing writeback structure shutdown from
>>> cgwb_bdi_unregister() with cgwb_release_workfn() using a new mutex. That
>>> way we also no longer need synchronization using WB_shutting_down as the
>>> mutex provides it for CONFIG_CGROUP_WRITEBACK case and without
>>> CONFIG_CGROUP_WRITEBACK wb_shutdown() can be called only once from
>>> bdi_unregister().
>>>
>>> Reported-by: syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>
>>> Signed-off-by: Jan Kara <jack@suse.cz>
>>
>> Acked-by: Tejun Heo <tj@kernel.org>
> 
> OK, Jens, can you please pick up the fix? Thanks!

Applied, thanks!

-- 
Jens Axboe
