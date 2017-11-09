Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 3/5] nvme: track shared namespaces
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
 Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20171102183034.9320-1-hch@lst.de>
 <20171102183034.9320-4-hch@lst.de>
 <ddc19090-b69b-ffa1-fd85-497b410b2b94@grimberg.me>
 <20171109125214.GA21795@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1a4292d3-b9c6-976c-69aa-a42f84469cb2@grimberg.me>
Date: Thu, 9 Nov 2017 14:59:50 +0200
MIME-Version: 1.0
In-Reply-To: <20171109125214.GA21795@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>>> To allow lockless path lookup the list of nvme_ns structures per
>>> nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
>>> structure through call_srcu.
>>
>> Can you remind me why isn't rcu sufficient? Can looking up a
>> path (ns from head->list) block?
> 
> blk_mq_make_request can block.

Oh I see, so can you explain why srcu should cover direct_make_request?

What if we were to do:
--
	rcu_read_lock();
	ns = nvme_find_path(head);
	rcu_read_unlock();
	if (likely(ns)) {
		...
--
