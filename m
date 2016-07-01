Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Damien Le Moal <Damien.LeMoal@hgst.com>
To: Christoph Hellwig <hch@lst.de>
CC: Amir Goldstein <amir73il@gmail.com>,
	Ming Lei <ming.lei@canonical.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@fb.com>
Subject: Re: Question about loop device DIO/AIO and FLUSH
Date: Fri, 1 Jul 2016 05:00:18 +0000
Message-ID: <E8DEFE4F-67B6-4A9A-83F0-3AA554AEFFB1@hgst.com>
References: <CAOQ4uxhEzr=yaFPO4ZVzndct84VC6c57W5DNEtqUHUcBjdTjQg@mail.gmail.com>
 <20160701042510.GA381@lst.de>
In-Reply-To: <20160701042510.GA381@lst.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Christoph,

> On Jul 1, 2016, at 13:25, Christoph Hellwig <hch@lst.de> wrote:
> 
> On Thu, Jun 30, 2016 at 11:54:48PM +0300, Amir Goldstein wrote:
>> Hi Ming,
>> 
>> I was reading through the code of loop DIO/AIO
>> and I was wondering whether lo_req_flush() really
>> honors REQ_FLUSH by calling  vfs_fsync() on a backing file
>> that is open with O_DIRECT?
>> 
>> Shouldn't lo_req_flush() actually wait for completion of
>> all the in-flight loop AIO requests to complete?
>> Am I missing something?
> 
> Both fsync and flush semanrics only apply to I/O requests that have already
> completed.

Did you mean "...I/O requests that have already been fully submitted" ?
Flushing I/Os that have already completed does not seem
to make much sense. Or I am also missing something...

Best.

---
Damien Le Moal
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.

