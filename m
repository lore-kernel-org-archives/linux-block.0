Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbdEaCwU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2017 22:52:20 -0400
Date: Wed, 31 May 2017 10:52:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v2 4/8] blk-mq: fix blk_mq_quiesce_queue
Message-ID: <20170531025207.GD12220@ming.t460p>
References: <20170527142126.26079-1-ming.lei@redhat.com>
 <20170527142126.26079-5-ming.lei@redhat.com>
 <1495921605.13651.2.camel@sandisk.com>
 <20170528104400.GB6488@ming.t460p>
 <1496172210.2627.24.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1496172210.2627.24.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 30, 2017 at 07:23:31PM +0000, Bart Van Assche wrote:
> On Sun, 2017-05-28 at 18:44 +0800, Ming Lei wrote:
> > First it is really a fix, and then a improvement, so could you tell me
> > where is wrong with the title and the description?
> 
> Hello Ming,
> 
> Can you explain me why you want to keep the�blk_mq_stop_hw_queues() call in
> nvme_suspend_queue()? Since immediately after that call the NVMe driver starts
> freeing resources, shouldn't that call be changed into a call of
> blk_mq_quiesce_queue()? I think the same comment also applies to the
> blk_mq_stop_hw_queues() calls in nvme_rdma_error_recovery_work() and
> nvme_rdma_shutdown_ctrl().

Not only NVMe, also other suspend cases in virito-blk, dm, and ...

But that doesn't belong to this patchset, and definitely a follow up.
The big purpose of this patchset is to make blk_mq_quiesce_queue() easy to use,
correct and avoiding potential races.

Then we can fix cases of canceling requests, and other cases like you
mentioned.


Thanks,
Ming
