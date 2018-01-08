Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V9 0/7] blk-mq support for ZBC disks
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>, linux-scsi@vger.kernel.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <Bart.VanAssche@wdc.com>
References: <20171221064344.6228-1-damien.lemoal@wdc.com>
 <20180105162150.GA16978@kernel.dk> <yq1vagcpcu1.fsf@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <76006cca-d93f-4bc6-6408-fb86d7470dcc@kernel.dk>
Date: Mon, 8 Jan 2018 09:07:56 -0700
MIME-Version: 1.0
In-Reply-To: <yq1vagcpcu1.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/8/18 8:52 AM, Martin K. Petersen wrote:
> 
> Jens,
> 
>> This looks OK for me for 4.16. I can grab all of them, or I can leave
>> the last two for Martin to apply if he prefers that, though that will
>> add a block tree dependency for SCSI.
> 
> I already have a block dependency for 4.16. But it doesn't matter much.

Completely up to you - I already have 1-5, I can add 6/7 as well, or
just can do it in your tree. Let me know what you prefer.


-- 
Jens Axboe
