Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/7] block: ensure bios return from blk_get_request are
 properly initialized
To: Christoph Hellwig <hch@lst.de>
References: <1465924564-14503-1-git-send-email-hch@lst.de>
 <1465924564-14503-4-git-send-email-hch@lst.de>
Cc: mst@redhat.com, ooo@electrozaur.com, nab@linux-iscsi.org,
 linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5761199A.1070400@kernel.dk>
Date: Wed, 15 Jun 2016 11:02:18 +0200
MIME-Version: 1.0
In-Reply-To: <1465924564-14503-4-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/14/2016 07:16 PM, Christoph Hellwig wrote:
> blk_get_request is used for BLOCK_PC and similar passthrough requests.
> Currently we always need to call blk_rq_set_block_pc or an open coded
> version of it to allow appending bios using the request mapping helpers
> later on, which is a somewhat awkward API.  Instead move the
> initialization part of blk_rq_set_block_pc into blk_get_request, so that
> we always have a safe to use request.

This still puts the pc related memset() into the normal fast path...

-- 
Jens Axboe
