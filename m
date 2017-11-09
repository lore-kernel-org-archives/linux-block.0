Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:37463 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753227AbdKINUr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Nov 2017 08:20:47 -0500
Date: Thu, 9 Nov 2017 14:20:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/5] nvme: track shared namespaces
Message-ID: <20171109132046.GA22728@lst.de>
References: <20171102183034.9320-1-hch@lst.de> <20171102183034.9320-4-hch@lst.de> <ddc19090-b69b-ffa1-fd85-497b410b2b94@grimberg.me> <20171109125214.GA21795@lst.de> <1a4292d3-b9c6-976c-69aa-a42f84469cb2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1a4292d3-b9c6-976c-69aa-a42f84469cb2@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Nov 09, 2017 at 02:59:50PM +0200, Sagi Grimberg wrote:
>
>>>> To allow lockless path lookup the list of nvme_ns structures per
>>>> nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
>>>> structure through call_srcu.
>>>
>>> Can you remind me why isn't rcu sufficient? Can looking up a
>>> path (ns from head->list) block?
>>
>> blk_mq_make_request can block.
>
> Oh I see, so can you explain why srcu should cover direct_make_request?
>
> What if we were to do:
> --
> 	rcu_read_lock();
> 	ns = nvme_find_path(head);
> 	rcu_read_unlock();
> 	if (likely(ns)) {
> 		...
> --

That way we'd have to take and release a namespace reference for every I/O.
