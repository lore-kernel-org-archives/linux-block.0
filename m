Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v11 0/7] block, scsi, md: Improve suspend and resume
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "martin@lichtvoll.de" <martin@lichtvoll.de>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <20171030224205.25212-1-bart.vanassche@wdc.com>
 <15255980.N0RxqQ3jgM@natalenko.name> <1510246471.2608.11.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5e91482c-16f5-13c8-e42d-cbe8dda355ad@kernel.dk>
Date: Thu, 9 Nov 2017 09:55:58 -0700
MIME-Version: 1.0
In-Reply-To: <1510246471.2608.11.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/09/2017 09:54 AM, Bart Van Assche wrote:
> On Thu, 2017-11-09 at 07:16 +0100, Oleksandr Natalenko wrote:
>> is this something known to you, or it is just my fault applying this series to 
>> v4.13? Except having this warning, suspend/resume works for me:
>>
>> [   27.383846] sd 0:0:0:0: [sda] Starting disk
>> [   27.383976] sd 1:0:0:0: [sdb] Starting disk
>> [   27.451218] sdb: Attempt to allocate non-preempt request in preempt-only 
>> mode.
>> [   27.459640] ------------[ cut here ]------------
>> [   27.464521] WARNING: CPU: 0 PID: 172 at block/blk-core.c:823 blk_queue_enter+0x222/0x280
> 
> Hello Oleksandr,
> 
> Thanks for the testing. The warning that you reported is expected. Maybe it
> should be left out to avoid that users get confused.

If the warning is expected, then it should be removed. It'll just confuse
users and cause useless bug reports.

> Jens, this patch series still applies cleanly on top of your for-4.15/block
> branch. Are you fine with this patch series or do you perhaps want me to
> repost it with Oleksandr's Tested-by tag added to each patch?

Since you need to kill the warning anyway, let's get it respun.

-- 
Jens Axboe
