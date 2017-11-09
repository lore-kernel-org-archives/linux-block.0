Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v12 0/7] block, scsi: Improve suspend and resume
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Ming Lei <ming.lei@redhat.com>, Martin Steigerwald <martin@lichtvoll.de>
References: <20171109184959.4617-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <253ed84c-8395-846a-43cd-0d4c5df8c416@kernel.dk>
Date: Thu, 9 Nov 2017 14:00:28 -0700
MIME-Version: 1.0
In-Reply-To: <20171109184959.4617-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/09/2017 11:49 AM, Bart Van Assche wrote:
> Hello Jens,
> 
> It is known that during the resume following a hibernate, especially when
> using an md RAID1 array created on top of SCSI devices, sometimes the system
> hangs instead of resuming up properly. This patch series fixes that
> problem. These patches have been tested on top of the block layer for-next
> branch. Please consider these changes for kernel v4.15.

Applied, thanks Bart.

-- 
Jens Axboe
