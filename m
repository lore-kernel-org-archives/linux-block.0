Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 2/3] nvme/pci: Remove cq_vector check in IO path
From: Sagi Grimberg <sagi@grimberg.me>
To: Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-3-keith.busch@intel.com>
 <95c8319b-3e01-07b5-88a8-864c5a8f60a5@grimberg.me>
Message-ID: <33f024c8-b4be-c8cb-decb-f36eb68fb99a@grimberg.me>
Date: Wed, 27 Dec 2017 23:01:48 +0200
MIME-Version: 1.0
In-Reply-To: <95c8319b-3e01-07b5-88a8-864c5a8f60a5@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> Awesome!
> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Wait, aren't we unquiesce queues also in nvme_dev_disable?

Doesn't that rely that the queues are suspended and queue_rq
will fail there?
