Return-Path: <ming.lei@redhat.com>
Date: Thu, 6 Sep 2018 21:07:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, jsmart2021@gmail.com,
	sagi@grimberg.me, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, keith.busch@intel.com,
	jthumshirn@suse.de, bart.vanassche@wdc.com
Subject: Re: [PATCH 3/3] nvme-pci: use queue close instead of queue freeze
Message-ID: <20180906130715.GB31250@ming.t460p>
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
 <1536120586-3378-4-git-send-email-jianchao.w.wang@oracle.com>
 <20180905220910.GC21352@ming.t460p>
 <8ba97c77-0c3b-75df-0259-3c97ef7b774e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8ba97c77-0c3b-75df-0259-3c97ef7b774e@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 06, 2018 at 09:28:46AM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 09/06/2018 06:09 AM, Ming Lei wrote:
> > nvme_dev_add() still may call freeze & unfreeze queue, so your patch
> > can't avoid draining queue completely here.
> 
> Yes, I know this. We still need to freeze queue when update nr_hw_queues.
> But we move forward a step at least. :)
> We don't need to drain request queue in normal case of nvme_reset_work.

It is hard to say who is the normal case. In case of CPU hotplug, it is quite
easy to trigger updating nr_hw_queues.

> 
> As for updating nr_hw_queues, we could try some other method on it next.

The thing is that draining queue may be inevitable inside reset work
function because of updating nr_hw_queues, that means the approach in
this patchset is just a partial solution

Or it may not make sense to do that because we may never remove the draining
queue in the code path of updating nr_hw_queues.

Given they belong to same issue, I suggest to solve them all.

Thanks,
Ming
