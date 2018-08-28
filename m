Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] scsi: revert two commits for avoiding host-wide
 host_busy counter for scsi_mq
To: Omar Sandoval <osandov@osandov.com>
Cc: Ming Lei <ming.lei@redhat.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
 Don Brace <don.brace@microsemi.com>,
 Kashyap Desai <kashyap.desai@broadcom.com>, Mike Snitzer
 <snitzer@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Laurence Oberman <loberman@redhat.com>,
 Bart Van Assche <bart.vanassche@wdc.com>
References: <20180827072443.26920-1-ming.lei@redhat.com>
 <a0d4b20a-add0-8f47-b94d-070209477280@kernel.dk>
 <20180828175416.GA18173@vader>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <aaf936ca-4ea7-b972-be6d-492fb6b4b49a@kernel.dk>
Date: Tue, 28 Aug 2018 11:57:23 -0600
MIME-Version: 1.0
In-Reply-To: <20180828175416.GA18173@vader>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/28/18 11:54 AM, Omar Sandoval wrote:
> On Mon, Aug 27, 2018 at 08:52:34AM -0600, Jens Axboe wrote:
>> On 8/27/18 1:24 AM, Ming Lei wrote:
>>> Hi,
>>>
>>> There is fundamental issue in commit 328728630d9f2bf1 (scsi: core: avoid
>>> host-wide host_busy counter for scsi_mq) because SCSI's host busy counter
>>> may not be same with counter of blk-mq's inflight tags, especially in case
>>> of none io scheduler.
>>>
>>> So please revert the two commits.
>>
>> Please do, they break changing write cache mode on my SATA drives. You
>> can add my tested-by and/or reported-by to this.
> 
> Jens, how does it break? Could we add a blktest for it?

Yep, it's pretty easy:

# echo "write through" > /sys/block/sde/device/scsi_disk/4:0:0:0/cache_type

and it hangs. For a blktests test, probably check the current value and
ensure we set it to a different value, then restore it.

-- 
Jens Axboe
