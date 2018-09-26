Return-Path: <martin.petersen@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v11 0/8] blk-mq: Implement runtime power management
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180926210110.20362-1-bvanassche@acm.org>
	<3cc2cde0-150d-c3d7-aed4-5db7909b39c3@kernel.dk>
Date: Wed, 26 Sep 2018 17:14:23 -0400
In-Reply-To: <3cc2cde0-150d-c3d7-aed4-5db7909b39c3@kernel.dk> (Jens Axboe's
	message of "Wed, 26 Sep 2018 15:12:05 -0600")
Message-ID: <yq1mus4dkr4.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Jens,

>> One of the pieces that is missing before blk-mq can be made the default
>> is implementing runtime power management support for blk-mq.  This patch
>> series not only implements runtime power management for blk-mq but also
>> fixes a starvation issue in the power management code for the legacy
>> block layer. Please consider this patch series for the upstream kernel.
>
> Thanks Bart, applied for 4.20.

I have made a note to back out the ufs change for 4.20.

-- 
Martin K. Petersen	Oracle Linux Engineering
