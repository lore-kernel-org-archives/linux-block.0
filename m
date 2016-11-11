Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: Reduced latency is killing performance
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>, "Christoph
 Hellwig" <hch@lst.de>
References: <72489f3f-d181-09a2-fc17-27ba36ad9620@suse.de>
CC: SCSI Mailing List <linux-scsi@vger.kernel.org>,
	<linux-block@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <711f875e-4bfa-168f-647d-49fd51729284@sandisk.com>
Date: Fri, 11 Nov 2016 09:15:09 -0800
MIME-Version: 1.0
In-Reply-To: <72489f3f-d181-09a2-fc17-27ba36ad9620@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 11/10/2016 08:04 AM, Hannes Reinecke wrote:
> this really feels like a follow-up to the discussion we've had in Santa
> Fe, but finally I'm able to substantiate it with some numbers.

Hello Hannes,

Since for the sequential read test the difference between the 50th 
percentile sequential read completion time (2.7 ms) and the average 
completion time (52 ms) is large I assume that you ran the ssd-test.fio 
job on top of a hard disk or hard disk array? How many hardware queues 
were active during your test? If multiple hardware queues were active, 
can you repeat your test with a single hardware queue? The plan for 
adding I/O scheduling support to blk-mq is - at least initially - only 
to perform I/O scheduling if there is only a single hardware queue.

Bart.
