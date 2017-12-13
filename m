Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbdLMGn3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Dec 2017 01:43:29 -0500
Date: Wed, 13 Dec 2017 14:43:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 6/6] nvme: remove .init_request callback
Message-ID: <20171213064151.GA1693@ming.t460p>
References: <20171212110232.12495-1-ming.lei@redhat.com>
 <20171212110232.12495-7-ming.lei@redhat.com>
 <20171212141358.GB7849@lst.de>
 <20171212151032.GA15078@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171212151032.GA15078@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Dec 12, 2017 at 11:10:32PM +0800, Ming Lei wrote:
> On Tue, Dec 12, 2017 at 03:13:58PM +0100, Christoph Hellwig wrote:
> > On Tue, Dec 12, 2017 at 07:02:32PM +0800, Ming Lei wrote:
> > > It may cause race by setting 'nvmeq' in nvme_init_request()
> > > because .init_request is called inside switching io scheduler, which
> > > may happen when the NVMe device is being resetted and its nvme queues
> > > are being freed and created. We don't have any sync between the two
> > > pathes.
> > > 
> > > This patch removes the .init_request callback and sets the nvmeq runtime,
> > > and fixes the following bug:
> > 
> > If ->init_request doesn't work for NVMe it won't work for any other
> > driver either, so we need to remove it entirely if we can't fix it.
> > 
> > I'd much rather try to fix it first, though.
> 
> Just checked all this uses, and it is a NVMe specific issue, because only
> NVMe's .init_request() associates reference of one variable to the request,
> and the variable itself may change during the request's lifetime.
> 
> And all the following .init_request() have this issue:
> 
> 	nvme_fc_init_request()
> 	nvme_rdma_init_request()
> 	nvme_loop_init_request()

After taking a close look, there isn't such issue actually on the above
three cases because the lifetime of ctl->queues(and each element) are
same with 'nvme_ctr/nvme_rdma_ctrl/nvme_loop_ctrl'. Not like nvme-pci,
->queues(and each element) won't be reallocated.

So it is a nvme-pci specific issue.

Thanks,
Ming
