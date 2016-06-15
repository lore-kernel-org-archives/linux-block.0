Return-Path: <hch@lst.de>
Date: Wed, 15 Jun 2016 12:07:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, mst@redhat.com, ooo@electrozaur.com,
	nab@linux-iscsi.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/7] block: ensure bios return from blk_get_request are
	properly initialized
Message-ID: <20160615100712.GA16425@lst.de>
References: <1465924564-14503-1-git-send-email-hch@lst.de> <1465924564-14503-4-git-send-email-hch@lst.de> <5761199A.1070400@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5761199A.1070400@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 15, 2016 at 11:02:18AM +0200, Jens Axboe wrote:
> On 06/14/2016 07:16 PM, Christoph Hellwig wrote:
>> blk_get_request is used for BLOCK_PC and similar passthrough requests.
>> Currently we always need to call blk_rq_set_block_pc or an open coded
>> version of it to allow appending bios using the request mapping helpers
>> later on, which is a somewhat awkward API.  Instead move the
>> initialization part of blk_rq_set_block_pc into blk_get_request, so that
>> we always have a safe to use request.
>
> This still puts the pc related memset() into the normal fast path...

Oops, I missed removing it from the alloc path when adding back
blk_rq_set_block_pc, will fix it up.

But I have to object to this actually being a fast path - it's not
used for any fs request, just BLOCK_PC, NVMe passthrough and various
driver specific little hacks.
