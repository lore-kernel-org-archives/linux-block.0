Return-Path: <hch@lst.de>
Date: Mon, 28 Aug 2017 13:54:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 08/10] block: provide a generic_make_request_fast helper
Message-ID: <20170828115445.GA17731@lst.de>
References: <20170823175815.3646-1-hch@lst.de> <20170823175815.3646-9-hch@lst.de> <326ee3b3-441f-e093-6d6f-7356e1ff8487@grimberg.me> <20170828085447.GB4358@lst.de> <7ff339f0-e9bc-514f-18a0-596d8e409436@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7ff339f0-e9bc-514f-18a0-596d8e409436@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 28, 2017 at 02:01:16PM +0300, Sagi Grimberg wrote:
>> That being said ->make_request basically doesn't care about actual
>> limits at all, it mostly care about support features (e.g. discard, fua,
>> etc).  So I think a lot of these limits could porbably be lifted,
>> but I'd need to add the check to generic_make_request_checks back.
>
> Different virt_boundary capabilities will trigger bio splits which
> can make make_request blocking (due to lack of tags).

All the bio splitting is done in blk_queue_split, and other things
related to limits are done even later in blk_mq_make_request when
building the request.  For normal make_request based stacking drivers
nothing of this matters, although a few drivers t call blk_queue_split
manually from their make_request method.
