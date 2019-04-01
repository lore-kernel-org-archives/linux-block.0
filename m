Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A6CC43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 02:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FE820870
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 02:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfDACAw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Mar 2019 22:00:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfDACAw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Mar 2019 22:00:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 746AD308FF2D;
        Mon,  1 Apr 2019 02:00:51 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C62860185;
        Mon,  1 Apr 2019 02:00:42 +0000 (UTC)
Date:   Mon, 1 Apr 2019 10:00:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 0/5] blk-mq: allow to run queue if queue refcount is held
Message-ID: <20190401020036.GB30776@ming.t460p>
References: <20190331030954.22320-1-ming.lei@redhat.com>
 <10c8ed10-3c96-b73c-18d8-114773b1d675@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10c8ed10-3c96-b73c-18d8-114773b1d675@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 01 Apr 2019 02:00:51 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 31, 2019 at 08:27:35AM -0700, Bart Van Assche wrote:
> On 3/30/19 8:09 PM, Ming Lei wrote:
> > Since 45a9c9d909b2 ("blk-mq: Fix a use-after-free"), run queue isn't
> > allowed during cleanup queue even though queue refcount is held.
> > 
> > This change has caused lots of kernel oops triggered in run queue path,
> > turns out it isn't easy to fix them all.
> > 
> > So move freeing of hw queue resources into queue's release handler, then
> > the above issue is fixed. Meantime, this way is safe given freeing hw
> > queue resource doesn't require to use tags.
> 
> I'm not sure the approach of this patch series is really the direction we
> should pursue. There are many block driver that free resources immediately

Please see scsi_run_queue(), and the queue refcount is always held
before run queue. That said this way has been working well for long time.
However, 45a9c9d909b2 ("blk-mq: Fix a use-after-free") breaks this behaviour,
and causes kernel oops.

> after blk_cleanup_queue() returns. An example from the brd driver:
> 
> static void brd_free(struct brd_device *brd)
> {
> 	put_disk(brd->brd_disk);
> 	blk_cleanup_queue(brd->brd_queue);
> 	brd_free_pages(brd);
> 	kfree(brd);
> }

Once blk_cleanup_queue() is returned, especially queue is frozen, there
isn't any request to be queued to driver, so it isn't a problem wrt.
freeing driver resource because we won't call into driver any more
under this situation.

This patch fixes the race between cleanup queue and run queue:

1) run queue may happen before the queue is frozen, however blk_mq_run_hw_queues()
may not be done when blk_freeze_queue() returns.

2) run queue may happen after blk_freeze_queue() returns

> 
> I'd like to avoid having to modify all block drivers that free resources
> immediately after blk_cleanup_queue() has returned. Have you considered to
> modify blk_mq_run_hw_queues() such that it becomes safe to call that
> function while blk_cleanup_queue() is in progress, e.g. by inserting a
> percpu_ref_tryget_live(&q->q_usage_counter) /
> percpu_ref_put(&q->q_usage_counter) pair?

It can't work because blk_mq_run_hw_queues may happen after
percpu_ref_exit() is done.

However, if we move percpu_ref_exit() into queue's release handler, we
don't need to grab q->q_usage_counter any more in blk_mq_run_hw_queues(),
and we still have to free hw queue resources in queue's release handler,
that is exactly what this patchset is doing.

In short, getting q->q_usage_counter doesn't make a difference on this
issue.

Thanks,
Ming
