Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 08/10] block: provide a generic_make_request_fast helper
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-9-hch@lst.de>
 <326ee3b3-441f-e093-6d6f-7356e1ff8487@grimberg.me>
 <20170828085447.GB4358@lst.de>
 <7ff339f0-e9bc-514f-18a0-596d8e409436@grimberg.me>
 <20170828115445.GA17731@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d2d93491-5196-4c9d-9990-3b4ef7147467@grimberg.me>
Date: Mon, 28 Aug 2017 15:38:44 +0300
MIME-Version: 1.0
In-Reply-To: <20170828115445.GA17731@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>>> That being said ->make_request basically doesn't care about actual
>>> limits at all, it mostly care about support features (e.g. discard, fua,
>>> etc).  So I think a lot of these limits could porbably be lifted,
>>> but I'd need to add the check to generic_make_request_checks back.
>>
>> Different virt_boundary capabilities will trigger bio splits which
>> can make make_request blocking (due to lack of tags).
> 
> All the bio splitting is done in blk_queue_split, and other things
> related to limits are done even later in blk_mq_make_request when
> building the request.  For normal make_request based stacking drivers
> nothing of this matters, although a few drivers t call blk_queue_split
> manually from their make_request method.

Maybe I misunderstood the change log comment, but didn't it said that
the caller is not allowed to submit a bio that might split?
