Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v10 00/10] block, scsi, md: Improve suspend and resume
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Ming Lei <ming.lei@redhat.com>
References: <20171017232630.4264-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9c33db06-39e7-fd61-f146-4ae6df4302b5@kernel.dk>
Date: Tue, 17 Oct 2017 17:28:14 -0600
MIME-Version: 1.0
In-Reply-To: <20171017232630.4264-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/17/2017 05:26 PM, Bart Van Assche wrote:
> Hello Jens,
> 
> It is known that during the resume following a hibernate, especially when
> using an md RAID1 array created on top of SCSI devices, sometimes the system
> hangs instead of coming up properly. This patch series fixes that
> problem. These patches have been tested on top of the block layer for-next
> branch. Please consider these changes for kernel v4.15.

The folks that had trouble with this issue, have they tested the
patchset? I'd like to get a solution queued up for this sooner rather
than later, but I'd greatly prefer if we had some folks that have
tested and verified it.

-- 
Jens Axboe
