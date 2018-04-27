Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Subject: Re: write call hangs in kernel space after virtio hot-remove
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, tj@kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz
References: <f0787b79-1e50-5f55-a400-44f715451777@linux.ibm.com>
 <20180426185052.GM1911913@devbig577.frc2.facebook.com>
 <201804270610.FFH64587.OLVtHJFFFQOSOM@I-love.SAKURA.ne.jp>
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Fri, 27 Apr 2018 17:10:41 -0300
MIME-Version: 1.0
In-Reply-To: <201804270610.FFH64587.OLVtHJFFFQOSOM@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Message-Id: <199dda3d-807e-232b-4df6-2534a555e898@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 2018-04-26 18:10, Tetsuo Handa wrote:

> Anyway, since Fabiano has a reproducer, I appreciate trying a patch at
> https://groups.google.com/forum/#!msg/syzkaller-bugs/qeR_1VM0UvU/1zcLE0Y4BAAJ .

Regarding the "INFO: task hung in wb_shutdown (2)" report mentioned above, I
can't find a relation with the issue I'm seeing. I observe the livelock at
'balance_dirty_pages' in a different task and after 'wb_shutdown' has already
finished.

> Also, Fabiano's attempt might be somewhat related to a NULL pointer race condition
> at https://groups.google.com/forum/#!msg/syzkaller-bugs/bVx4WExoTDw/G68X4kPcAQAJ .

About "general protection fault in wb_workfn", I see that 'bdi_unregister' both
clears the 'WB_registered' bit (via wb_shutdown) and sets bdi->dev = NULL:

void bdi_unregister(struct backing_dev_info *bdi)
{
        /* make sure nobody finds us on the bdi_list anymore */
        bdi_remove_from_list(bdi);
->      wb_shutdown(&bdi->wb);
        cgwb_bdi_unregister(bdi);

        if (bdi->dev) {
                bdi_debug_unregister(bdi);
                device_unregister(bdi->dev);
->              bdi->dev = NULL;
        }
(...)
}


so I believe Jan's patch makes use of that correlation to avoid executing
'wb_workfn' when bdi->dev == NULL thus avoiding the null access:

(from "5acda9d bdi: avoid oops on device removal")

static void wb_wakeup(struct bdi_writeback *wb)
{
        spin_lock_bh(&wb->work_lock);
        if (test_bit(WB_registered, &wb->state))
                mod_delayed_work(bdi_wq, &wb->dwork, 0); <-- wb_workfn
        spin_unlock_bh(&wb->work_lock);
}


Therefore looking at my issue and the syzcaller report, I thinking maybe we shouldn't
avoid running 'wb_workfn' after a device removal but instead fix bdi->dev ==
NULL somewhere else (this is what my code snippet does, as a proof of concept).
