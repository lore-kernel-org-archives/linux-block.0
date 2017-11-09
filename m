Return-Path: <hch@lst.de>
Date: Thu, 9 Nov 2017 13:52:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/5] nvme: track shared namespaces
Message-ID: <20171109125214.GA21795@lst.de>
References: <20171102183034.9320-1-hch@lst.de> <20171102183034.9320-4-hch@lst.de> <ddc19090-b69b-ffa1-fd85-497b410b2b94@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ddc19090-b69b-ffa1-fd85-497b410b2b94@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 09, 2017 at 01:37:43PM +0200, Sagi Grimberg wrote:
>
>> To allow lockless path lookup the list of nvme_ns structures per
>> nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
>> structure through call_srcu.
>
> Can you remind me why isn't rcu sufficient? Can looking up a
> path (ns from head->list) block?

blk_mq_make_request can block.
