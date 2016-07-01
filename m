Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Damien Le Moal <Damien.LeMoal@hgst.com>
To: Christoph Hellwig <hch@lst.de>
CC: Amir Goldstein <amir73il@gmail.com>,
	Ming Lei <ming.lei@canonical.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@fb.com>
Subject: Re: Question about loop device DIO/AIO and FLUSH
Date: Fri, 1 Jul 2016 05:17:28 +0000
Message-ID: <3D8F3502-8EA7-4568-882B-90E48C8F6BCF@hgst.com>
References: <CAOQ4uxhEzr=yaFPO4ZVzndct84VC6c57W5DNEtqUHUcBjdTjQg@mail.gmail.com>
 <20160701042510.GA381@lst.de> <E8DEFE4F-67B6-4A9A-83F0-3AA554AEFFB1@hgst.com>
 <20160701050455.GA828@lst.de>
In-Reply-To: <20160701050455.GA828@lst.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Christoph,

> On Jul 1, 2016, at 14:04, Christoph Hellwig <hch@lst.de> wrote:
> 
> On Fri, Jul 01, 2016 at 05:00:18AM +0000, Damien Le Moal wrote:
>> Did you mean "...I/O requests that have already been fully submitted" ?
> 
> No.
> 
>> Flushing I/Os that have already completed does not seem
>> to make much sense. Or I am also missing something...
> 
> With a volatile write cache this makes a lot of sense.  And fsync
> flushes the volatile fs metadata to disk, while flush flushes the
> volatile disk write cache.

Thank you for the clarification. Makes sense.
Just to be picky though, I think that "completed I/Os" applies only
to flush in this case (flush of the volatile device cache to media).
fsync of the host cache (page cache most of the time) to the device
will issue new BIOs, and those will be waited for until completed.
Right ?

Best.

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.

