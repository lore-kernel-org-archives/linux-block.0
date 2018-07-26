Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] virtio_scsi pi_bytes{out,in} miscalculated on 4 KiB
 devices
To: Greg Edwards <gedwards@ddn.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180725142259.20562-1-gedwards@ddn.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <dfbd3d7b-055e-5edc-80a6-89423a7c3683@kernel.dk>
Date: Thu, 26 Jul 2018 14:49:59 -0700
MIME-Version: 1.0
In-Reply-To: <20180725142259.20562-1-gedwards@ddn.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/25/18 7:22 AM, Greg Edwards wrote:
> When the VIRTIO_SCSI_F_T10_PI feature bit is enabled, the virtio_scsi driver
> does not correctly calculate pi_bytes{out,in} when the underlying device has a
> 4 KiB logical block size.  The current code assumes a 512 byte logical block
> size and protection interval exponent of 0 (512 bytes + 8 bytes PI).
> 
> The first patch moves bio_integrity_intervals() and bio_integrity_bytes() into
> blkdev.h so drivers can make use of them.  The second patch modifies
> virtio_scsi to call bio_integrity_bytes() to get the values for
> pi_bytes{out,in}.

Applied, thanks.

-- 
Jens Axboe
