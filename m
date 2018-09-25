Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:27590 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbeIYUqX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Sep 2018 16:46:23 -0400
Date: Tue, 25 Sep 2018 08:39:16 -0600
From: Keith Busch <keith.busch@intel.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
        Linux Block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Allow blocking queue tag iter callbacks
Message-ID: <20180925143916.GB11657@localhost.localdomain>
References: <20180924210919.9995-1-keith.busch@intel.com>
 <45fc0cf9-92b2-2380-d11b-428613a470c2@oracle.com>
 <fc9d3a15-b136-478c-c35f-74a9a3479fb7@acm.org>
 <4de9e32b-18a0-bc37-1454-def9486fe3e0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4de9e32b-18a0-bc37-1454-def9486fe3e0@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 25, 2018 at 10:39:46AM +0800, jianchao.wang wrote:
> Hi Bart
> 
> On 09/25/2018 10:20 AM, Bart Van Assche wrote:
> > On 9/24/18 7:11 PM, jianchao.wang wrote:
> >> Hi Keith
> >>
> >> On 09/25/2018 05:09 AM, Keith Busch wrote:
> >>> -��� /* A deadlock might occur if a request is stuck requiring a
> >>> -���� * timeout at the same time a queue freeze is waiting
> >>> -���� * completion, since the timeout code would not be able to
> >>> -���� * acquire the queue reference here.
> >>> -���� *
> >>> -���� * That's why we don't use blk_queue_enter here; instead, we use
> >>> -���� * percpu_ref_tryget directly, because we need to be able to
> >>> -���� * obtain a reference even in the short window between the queue
> >>> -���� * starting to freeze, by dropping the first reference in
> >>> -���� * blk_freeze_queue_start, and the moment the last request is
> >>> -���� * consumed, marked by the instant q_usage_counter reaches
> >>> -���� * zero.
> >>> -���� */
> >>> -��� if (!percpu_ref_tryget(&q->q_usage_counter))
> >>> +��� if (!blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next))
> >>> ��������� return;
> >>
> >> We cannot discard the percpu_ref_tryget here.
> >>
> >> There following code in blk_mq_timeout_work still need it:
> >>
> >> ����if (next != 0) {
> >> ������� mod_timer(&q->timeout, next);
> >> ����} else {
> >> ������� queue_for_each_hw_ctx(q, hctx, i) {
> >> ����������� /* the hctx may be unmapped, so check it here */
> >> ����������� if (blk_mq_hw_queue_mapped(hctx))
> >> ��������������� blk_mq_tag_idle(hctx);
> >> ������� }
> >> ����}
> > 
> > Hi Jianchao,
> > 
> > Had you noticed that the percpu_ref_tryget() call has been moved into
> > blk_mq_queue_tag_busy_iter()?
> > 
> 
> Yes.
> 
> But the issue is the left part of blk_mq_timeout_work is moved out of protection of q refcount.

I'm not sure what you mean by "left part". The only part that isn't
outside the reference with this patch is the part Bart pointed out.

This looks like it may be fixed by either moving the refcount back up a
level to all the callers of blk_mq_queue_tag_busy_iter, or add
cancel_work_sync(&q->timeout_work) to __blk_mq_update_nr_hw_queues after
the freeze.
