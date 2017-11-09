Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 3/5] nvme: track shared namespaces
To: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <jthumshirn@suse.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20171102183034.9320-1-hch@lst.de>
 <20171102183034.9320-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ddc19090-b69b-ffa1-fd85-497b410b2b94@grimberg.me>
Date: Thu, 9 Nov 2017 13:37:43 +0200
MIME-Version: 1.0
In-Reply-To: <20171102183034.9320-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> To allow lockless path lookup the list of nvme_ns structures per
> nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
> structure through call_srcu.

Can you remind me why isn't rcu sufficient? Can looking up a
path (ns from head->list) block?
