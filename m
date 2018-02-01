Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHv2 2/2] block: Handle merging discards in IO schedulers
To: Keith Busch <keith.busch@intel.com>,
 Linux Block <linux-block@vger.kernel.org>,
 Linux NVMe <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <20180201203158.24761-1-keith.busch@intel.com>
 <20180201203158.24761-3-keith.busch@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d2b2eb11-fb1c-91a9-604b-d2dddac88a45@kernel.dk>
Date: Thu, 1 Feb 2018 14:02:14 -0700
MIME-Version: 1.0
In-Reply-To: <20180201203158.24761-3-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/1/18 1:31 PM, Keith Busch wrote:
> This adds support for merging discard requests in all IO schedulers.

As per my last email, some of these aren't correct. Only the
blk-mq-sched change is correct/useful, so we should just do that
separately.

-- 
Jens Axboe
