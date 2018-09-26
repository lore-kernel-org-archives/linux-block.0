Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v11 0/8] blk-mq: Implement runtime power management
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20180926210110.20362-1-bvanassche@acm.org>
 <3cc2cde0-150d-c3d7-aed4-5db7909b39c3@kernel.dk> <yq1mus4dkr4.fsf@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <337605e6-ae39-20cc-4c15-f1592b28c385@kernel.dk>
Date: Wed, 26 Sep 2018 15:22:06 -0600
MIME-Version: 1.0
In-Reply-To: <yq1mus4dkr4.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/26/18 3:14 PM, Martin K. Petersen wrote:
> 
> Jens,
> 
>>> One of the pieces that is missing before blk-mq can be made the default
>>> is implementing runtime power management support for blk-mq.  This patch
>>> series not only implements runtime power management for blk-mq but also
>>> fixes a starvation issue in the power management code for the legacy
>>> block layer. Please consider this patch series for the upstream kernel.
>>
>> Thanks Bart, applied for 4.20.
> 
> I have made a note to back out the ufs change for 4.20.

Thanks Martin, will be nice to have this finally all resolved.

-- 
Jens Axboe
