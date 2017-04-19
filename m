Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 4/5] block: Inline blk_rq_set_prio()
To: Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>
References: <20170418231037.3968-1-bart.vanassche@sandisk.com>
 <20170418231037.3968-5-bart.vanassche@sandisk.com>
 <20170419062051.GD6412@lst.de>
Cc: linux-block@vger.kernel.org, =?UTF-8?Q?Matias_Bj=c3=b8rling?=
 <m@bjorling.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <352b4d72-d6ed-692b-a3d9-a664f445ad76@kernel.dk>
Date: Wed, 19 Apr 2017 08:38:50 -0600
MIME-Version: 1.0
In-Reply-To: <20170419062051.GD6412@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/19/2017 12:20 AM, Christoph Hellwig wrote:
>> +	req->ioprio = ioprio_valid(bio_prio(bio)) ? bio_prio(bio) : ioc ?
>> +		ioc->ioprio : IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
> 
> I think this would be a tad cleaner with a traditional if / else if / else
> chain, e.g.
> 
> 	if (ioprio_valid(bio_prio(bio)))
> 		req->ioprio = bio_prio(bio);
> 	else if (ioc)
> 		req->ioprio = ioc->ioprio;
> 	else
> 		req->ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);

Agree, I hate ternaries with a vengeance, and a doubly nested one is
almost a shooting offense.

Bart, care to respin with this fixed and the GPL export modification?

-- 
Jens Axboe
