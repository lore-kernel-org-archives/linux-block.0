Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] block: Polling completion performance optimization
To: Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-4-keith.busch@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5e69c9fe-b0ae-fc1a-637d-9a3816faa506@kernel.dk>
Date: Thu, 21 Dec 2017 13:57:37 -0700
MIME-Version: 1.0
In-Reply-To: <20171221204636.2924-4-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/21/17 1:46 PM, Keith Busch wrote:
> When a request completion is polled, the completion task wakes itself
> up. This is unnecessary, as the task can just set itself back to
> running.

Looks good to me, I can take it for 4.16 in the block tree.

-- 
Jens Axboe
