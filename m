Return-Path: <nab@linux-iscsi.org>
Message-ID: <1494312374.16894.36.camel@haakon3.risingtidesystems.com>
Subject: Re: [PATCH 25/27] block: remove the discard_zeroes_data flag
From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
To: "hch@lst.de" <hch@lst.de>
Cc: Bart Van Assche <Bart.VanAssche@sandisk.com>, "agk@redhat.com"
 <agk@redhat.com>, "lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
 "snitzer@redhat.com" <snitzer@redhat.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>,  "philipp.reisner@linbit.com"
 <philipp.reisner@linbit.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "shli@kernel.org" <shli@kernel.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>,  "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Date: Mon, 08 May 2017 23:46:14 -0700
In-Reply-To: <20170507092209.GA27370@lst.de>
References: <20170405172125.22600-1-hch@lst.de>
	 <20170405172125.22600-26-hch@lst.de> <1493671519.2665.15.camel@sandisk.com>
	 <1493707425.23202.77.camel@haakon3.risingtidesystems.com>
	 <1493709373.23202.79.camel@haakon3.risingtidesystems.com>
	 <20170502072328.GA11522@lst.de>
	 <1493782395.23202.84.camel@haakon3.risingtidesystems.com>
	 <20170507092209.GA27370@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Sun, 2017-05-07 at 11:22 +0200, hch@lst.de wrote:
> On Tue, May 02, 2017 at 08:33:15PM -0700, Nicholas A. Bellinger wrote:
> > The larger target/iblock conversion patch looks like post v4.12 material
> > at this point, so to avoid breakage wrt to existing LBPRZ behavior, I'll
> > plan to push the following patch post -rc1.
> 
> I don't think this is safe.  If you want to do the aboe you also
> need to ensure ->execute_unmap always zeroes the data.  For actual
> files in the file backend we should be all fine, but for the block
> device case [1] and iblock we'd need to use blkdev_issue_zeroout
> instead of blkdev_issue_discard when unmap_zeroes_data is set.
> 
> [1] which btw already seems broken as it doesn't invalidate cached
> data when issuing a discard.

Mmm, for [1] that would appear to be true, but after a deeper look at
existing code I don't think this is the case.

The reason being is target backend attributes emulate_tpu and
emulate_tpws are strictly user configurable, and aren't automatically
set based upon the underlying IBLOCK block_device support for either
one.

According to pre v4.12-rc1 code, q->limits.discard_zeroes_data was only
enabled by drivers/scsi/sd.c:sd_config_discard() for
sdkp->provisioning_mode WRITE_SAME with LBPRZ = 1 or explicit ZERO, and
for NVME for devices that supported NVME_QUIRK_DISCARD_ZEROES.  Eg: Only
real DISCARD + ZERO support.

In your changes to v4.12-rc1, this logic to signal real DISCARD + zero
support for SCSI and NVMe via q->limits.max_write_zeroes_sectors has not
changed..

So AFAICT, regardless if the user sets emulate_tpu or emulate_tpws for a
IBLOCK backend, SCSI host code will have to choose sdkp->zeroing_mode
WRITE_SAME with LBPRZ or explicit ZERO, and NVMe host code will have to
chose a ctrl NVME_QUIRK_DEALLOCATE_ZEROES before
q->limits.max_write_zeroes_sectors != 0 is propagated up to target code,
and LBPRZ = 1 is signaled via READ_CAPACITY_16 and EVPD = 0xb2.

That said, simply propagating up q->limits.max_write_zeroes_sectors as
dev_attrib->unmap_zeroes_data following existing code still looks like
the right thing to do.
