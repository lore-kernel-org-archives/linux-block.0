Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:47894 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbcKICTh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2016 21:19:37 -0500
Subject: Re: BUG: Hung task timeouts in for-4.10/dio
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
References: <8eed541f-b4c2-37c9-6650-216f3d0aa92f@fb.com>
 <21f0cddd-28d9-790d-b4fc-4635cca77ea8@deltatee.com>
 <9fe151a1-2d9f-28ef-25a7-bbcb01d8d972@fb.com>
 <c2d69ddc-28c9-bf26-5b06-74d00e88a700@deltatee.com>
 <6997fb64-aaac-208f-fa89-b8b4567f7321@fb.com>
 <a74de948-3026-d9b3-6b2e-b9cc1f3c05d4@deltatee.com>
 <6d532d4a-8d35-f610-65ed-efef949a3686@fb.com>
 <84693d82-b8dc-42b3-03da-055def7499a0@deltatee.com>
 <1e0e590b-fde3-a86d-bc60-8e5465928533@fb.com>
 <84cf8089-7d6d-0146-49fb-91a2d08650b2@wdc.com>
 <20161109010959.GA32126@lst.de>
 <b3d8c5fa-b930-b21f-3986-1ff94611c7f9@wdc.com>
 <a6d1d368-04a2-e999-a610-abd96add81a9@fb.com>
 <03cda65e-3a82-6ccd-861b-67a55888eb19@kernel.dk>
CC: Logan Gunthorpe <logang@deltatee.com>,
        <linux-block@vger.kernel.org>, Mike Snitzer <snitzer@redhat.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <98e85291-21b6-e961-dfa8-abdc6b2fbb68@wdc.com>
Date: Wed, 9 Nov 2016 11:17:53 +0900
MIME-Version: 1.0
In-Reply-To: <03cda65e-3a82-6ccd-861b-67a55888eb19@kernel.dk>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Jens,

On 11/9/16 11:02, Jens Axboe wrote:
> It smells like an accounting error. One thing that I don't like with the
> current scheme is the implicit knowledge that certain flags imply sync
> as well. If we clear any of those flags, then we screw up accounting at
> the end.
> 
> Does this make a difference?
> 
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index c486b7aa62ee..d70983e28115 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -395,6 +395,8 @@ void blk_insert_flush(struct request *rq)
>   	if (!(fflags & (1UL << QUEUE_FLAG_FUA)))
>   		rq->cmd_flags &= ~REQ_FUA;
> 
> +	rq->cmd_flags |= REQ_SYNC;
> +
>   	/*
>   	 * An empty flush handed down from a stacking driver may
>   	 * translate into nothing if the underlying device does not

That worked. Still seeing hangs/failures at boot with the latest
for-4.10/block (networkmanager failing, no login shell, etc) but with
the above patch, I get a clean boot and login with network working.
Once booted, simple tests on ext4 and xfs do not show any problem, but
that was only very light testing.

Best regards.

-- 
Damien Le Moal, Ph.D.
Sr. Manager, System Software Research Group,
Western Digital Corporation
Damien.LeMoal@wdc.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
