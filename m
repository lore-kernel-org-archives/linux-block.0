Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33005 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbcJFQG2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2016 12:06:28 -0400
Received: by mail-pf0-f193.google.com with SMTP id i85so1354984pfa.0
        for <linux-block@vger.kernel.org>; Thu, 06 Oct 2016 09:06:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161005165127.GA4812@localhost.localdomain>
References: <20160926230030.GB24200@localhost.localdomain> <20160927172536.53a1315f@tom-ThinkPad-T450>
 <20161003220040.GA1259@localhost.localdomain> <CACVXFVOrQHdZkqq+F159pd67iaj=Cx2hRG=uj-Mfr_m1OV9t+Q@mail.gmail.com>
 <20161005165127.GA4812@localhost.localdomain>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 7 Oct 2016 00:06:27 +0800
Message-ID: <CACVXFVO_YqeQae3FCpK=wKHZ_U5vHtj=KMowAt5vJDpq43hcrA@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: Return invalid cookie if bio was split
To: Keith Busch <keith.busch@intel.com>
Cc: linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Keith,

On Thu, Oct 6, 2016 at 12:51 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Wed, Oct 05, 2016 at 11:19:39AM +0800, Ming Lei wrote:
>> But .poll() need to check if the specific request is completed or not,
>> then blk_poll() can set 'current' as RUNNING if it is completed.
>>
>> blk_poll():
>>                 ...
>>                 ret = q->mq_ops->poll(hctx, blk_qc_t_to_tag(cookie));
>>                 if (ret > 0) {
>>                         hctx->poll_success++;
>>                         set_current_state(TASK_RUNNING);
>>                         return true;
>>                 }
>
>
> Right, but the task could be waiting on a whole lot more than just that
> one tag, so setting the task to running before knowing those all complete
> doesn't sound right.
>
>> I am glad to take a look the patch if you post it out.
>
> Here's what I got for block + nvme. It relies on all the requests to
> complete to set the task back to running.

Yeah, but your patch doesn't add that change, and looks 'task_struct *'
in submission path need to be stored in request or somewhere else.

There are some issues with current polling approach:
- in dio, one dio may include lots of bios, but only the last submitted bio
is polled
- one bio can be splitted into several bios, but submit_bio() only returns
one cookie for polling

Looks your approach via polling current state can fix this issue.

>
> ---
> diff --git a/block/blk-core.c b/block/blk-core.c
> index b993f88..3c1cfbf 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -3342,6 +3342,8 @@ EXPORT_SYMBOL(blk_finish_plug);
>  bool blk_poll(struct request_queue *q, blk_qc_t cookie)
>  {
>         struct blk_plug *plug;
> +       struct blk_mq_hw_ctx *hctx;
> +       unsigned int queue_num;
>         long state;
>
>         if (!q->mq_ops || !q->mq_ops->poll || !blk_qc_t_valid(cookie) ||
> @@ -3353,27 +3355,15 @@ bool blk_poll(struct request_queue *q, blk_qc_t cookie)
>                 blk_flush_plug_list(plug, false);
>
>         state = current->state;
> +       queue_num = blk_qc_t_to_queue_num(cookie);
> +       hctx = q->queue_hw_ctx[queue_num];
>         while (!need_resched()) {
> -               unsigned int queue_num = blk_qc_t_to_queue_num(cookie);
> -               struct blk_mq_hw_ctx *hctx = q->queue_hw_ctx[queue_num];
> -               int ret;
> -
> -               hctx->poll_invoked++;
> -
> -               ret = q->mq_ops->poll(hctx, blk_qc_t_to_tag(cookie));
> -               if (ret > 0) {
> -                       hctx->poll_success++;
> -                       set_current_state(TASK_RUNNING);
> -                       return true;
> -               }
> +               q->mq_ops->poll(hctx);
>
>                 if (signal_pending_state(state, current))
>                         set_current_state(TASK_RUNNING);
> -
>                 if (current->state == TASK_RUNNING)
>                         return true;
> -               if (ret < 0)
> -                       break;
>                 cpu_relax();
>         }

Then looks the whole hw queue is polled and only the queue num
in cookie matters.

In theory, there might be one race:

- one dio need to submit several bios(suppose there are two bios: A and B)
- A is submitted to hardware queue M
- B is submitted to hardware queue N because the current task is migrated
to another CPU
- then only hardware queue N is polled

>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index befac5b..2e359e0 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -649,7 +651,7 @@ static inline bool nvme_cqe_valid(struct nvme_queue *nvmeq, u16 head,
>         return (le16_to_cpu(nvmeq->cqes[head].status) & 1) == phase;
>  }
>
> -static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
> +static void nvme_process_cq(struct nvme_queue *nvmeq)
>  {
>         u16 head, phase;
>
> @@ -665,9 +667,6 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
>                         phase = !phase;
>                 }
>
> -               if (tag && *tag == cqe.command_id)
> -                       *tag = -1;
> -
>                 if (unlikely(cqe.command_id >= nvmeq->q_depth)) {
>                         dev_warn(nvmeq->dev->ctrl.device,
>                                 "invalid id %d completed on queue %d\n",
> @@ -711,11 +710,6 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
>         nvmeq->cqe_seen = 1;
>  }
>
> -static void nvme_process_cq(struct nvme_queue *nvmeq)
> -{
> -       __nvme_process_cq(nvmeq, NULL);
> -}
> -
>  static irqreturn_t nvme_irq(int irq, void *data)
>  {
>         irqreturn_t result;
> @@ -736,20 +730,15 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
>         return IRQ_NONE;
>  }
>
> -static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
> +static void nvme_poll(struct blk_mq_hw_ctx *hctx)
>  {
>         struct nvme_queue *nvmeq = hctx->driver_data;
>
>         if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
>                 spin_lock_irq(&nvmeq->q_lock);
> -               __nvme_process_cq(nvmeq, &tag);
> +               nvme_process_cq(nvmeq);
>                 spin_unlock_irq(&nvmeq->q_lock);
> -
> -               if (tag == -1)
> -                       return 1;
>         }
> -
> -       return 0;
>  }
>
>  static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl, int aer_idx)
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 2498fdf..a723af9 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -100,7 +100,7 @@ typedef void (exit_request_fn)(void *, struct request *, unsigned int,
>  typedef void (busy_iter_fn)(struct blk_mq_hw_ctx *, struct request *, void *,
>                 bool);
>  typedef void (busy_tag_iter_fn)(struct request *, void *, bool);
> -typedef int (poll_fn)(struct blk_mq_hw_ctx *, unsigned int);
> +typedef void (poll_fn)(struct blk_mq_hw_ctx *);
>
>
>  struct blk_mq_ops {
> --



-- 
Ming Lei
