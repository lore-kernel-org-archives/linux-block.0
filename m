Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V3 7/8] nvme: pci: recover controller reliably
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Laurence Oberman <loberman@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180503031716.31446-1-ming.lei@redhat.com>
 <20180503031716.31446-8-ming.lei@redhat.com>
 <32819b0a-acc8-fa76-5e58-8e75e2bc081b@oracle.com>
 <20180503100824.GA5078@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <ea98b607-9c8f-3b18-8314-cdcfd8bc5e96@oracle.com>
Date: Thu, 3 May 2018 23:46:56 +0800
MIME-Version: 1.0
In-Reply-To: <20180503100824.GA5078@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming

Thanks for your kindly response.

On 05/03/2018 06:08 PM, Ming Lei wrote:
> nvme_eh_reset() can move on, if controller state is either CONNECTING or
> RESETTING, nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING) won't
> be called in nvme_eh_reset(), and nvme_pre_reset_dev() will be called
> directly, then follows scheduling of the eh_reset_work.

We have to consider another context, nvme_reset_work.
There are two contexts that will invoke nvme_pre_reset_dev.
nvme_eh_reset could invoke nvme_pre_reset_dev even if the state is RESETTING or CONNECTING.

nvme_error_handler                nvme_reset_ctrl
                                    -> change state to RESETTING
                                    -> queue reset work
                                  nvme_reset_work          
  -> nvme_dev_disable                                     
  -> nvme_eh_reset
    -> nvme_pre_reset_dev          -> nvme_pre_reset_dev
      -> change state to CONNECTING   -> change state fails
                                   -> nvme_remove_dead_ctrl
There seems to be other race scenarios between them.

Just invoke nvme_dev_disable in nvme_error_handler context and hand over the other things
to nvme_reset_work as the v2 patch series seems clearer.
The primary target of nvme_error_handler is to drain IOs and disable controller.
reset_work could take over the left things of the recovery work

IMO, modify the nvme_reset_ctrl_sync in nvme_error_handler to nvme_reset_ctrl should be ok.
If the admin ios in reset_work timeout, the nvme_error_handler could also provide help to complete them.

> There are actually two issues here, both are covered in this patchset:
> 
> 1) when nvme_wait_freeze() is for draining IO, controller error may
> happen again, this patch can shutdown & reset controller again to
> recover it.
>

We could split the nvme_reset_work into two contexts instead of introduce another nvme_eh_reset.
Otherwise, the code looks really complicated.
In addition, this fix for this issue could be deferred after your great EH kthread solution is submitted.

Thanks
Jianchao

> 2) there is also another issue: queues may not be put into freeze state
> in nvme_dev_disable(), then nvme_wait_freeze() will wait forever. This
> issue is addressed by 4th patch.
> 
> Both two can be observed in blktests block/011 and verified by this patches.
> 
> Thanks for your great review, please let me know if there are other
> issues.
