Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Fix front merge check
To: Damien Le Moal <damien.lemoal@hgst.com>, Jens Axboe <axboe@fb.com>,
 linux-block@vger.kernel.org, hch@lst.de, hare@suse.de
References: <1468387413-2754-1-git-send-email-damien.lemoal@hgst.com>
 <57866A2B.5000403@fb.com> <8a365634-e2e7-45d9-a86d-10894212a4d2@hgst.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9cc4fbbe-4cdd-d9b0-41ca-5dcb13cc6409@kernel.dk>
Date: Wed, 20 Jul 2016 21:38:43 -0600
MIME-Version: 1.0
In-Reply-To: <8a365634-e2e7-45d9-a86d-10894212a4d2@hgst.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 07/13/2016 07:23 PM, Damien Le Moal wrote:
>
> Jens,
>
> On 7/14/16 01:19, Jens Axboe wrote:
>> On 07/12/2016 10:23 PM, Damien Le Moal wrote:
>>> For a front merge, the maximum number of sectors of the
>>> request must be checked against the front merge BIO sector,
>>> not the current sector of the request.
>>
>> Why does this matter? The merging should only happen before we start the
>> request, hence rq pos and first bio should be one and the same.
>
> The block device of SMR drives is set up as chunked with the chunk size
> equal to the drive zone size. Since write requests directed to
> sequential zones cannot cross zone boundaries, both the front merge code
> and the back merge code must ensure that requests resulting from a merge
> do not cross chunk boundaries.
>
> The back merge code does this well, but the front merge code fails to
> prevent merging when the BIO is the last write in a zone and the request
> is the first write in the following (empty) zone. The check against the
> request LBA does not prevent the merge as the request+bio size fit in
> the empty zone. The check must be against the BIO LBA to detect the
> chunk boundary crossing.

Ah that makes sense, it's on adding the new bio, not against the 
existing rq->bio. Applied for 4.8.

-- 
Jens Axboe
