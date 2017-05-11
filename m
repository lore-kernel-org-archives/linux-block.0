Return-Path: <nab@linux-iscsi.org>
Message-ID: <1494478235.16894.115.camel@haakon3.risingtidesystems.com>
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
Date: Wed, 10 May 2017 21:50:35 -0700
In-Reply-To: <20170510140627.GA23759@lst.de>
References: <20170405172125.22600-1-hch@lst.de>
	 <20170405172125.22600-26-hch@lst.de> <1493671519.2665.15.camel@sandisk.com>
	 <1493707425.23202.77.camel@haakon3.risingtidesystems.com>
	 <1493709373.23202.79.camel@haakon3.risingtidesystems.com>
	 <20170502072328.GA11522@lst.de>
	 <1493782395.23202.84.camel@haakon3.risingtidesystems.com>
	 <20170507092209.GA27370@lst.de>
	 <1494312374.16894.36.camel@haakon3.risingtidesystems.com>
	 <20170510140627.GA23759@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-05-10 at 16:06 +0200, hch@lst.de wrote:
> On Mon, May 08, 2017 at 11:46:14PM -0700, Nicholas A. Bellinger wrote:
> > That said, simply propagating up q->limits.max_write_zeroes_sectors as
> > dev_attrib->unmap_zeroes_data following existing code still looks like
> > the right thing to do.
> 
> It is not.  Martin has decoupled write same/zeroes support from discard
> support.  Any device will claim to support it initially, and we'll
> only clear the flag if a Write Same command fails.
> 
> So even if LBPRZ is not set you can trivially get into a situation
> where discard is supported through UNMAP, and you'll incorrectly
> set LBPRZ and will cause data corruption.

In that case, there are two choices.

1) Expose a block_device or request_queue bit to signal 'real LBPRZ'
support up to IBLOCK, in order to maintain SCSI target feature
compatibility.

2) Or drop the LBPRZ bit usage for IBLOCK all-together.

Since I happen happen to support a block driver that has 'real LBPRZ'
support for all discards, I'd prefer the latter so this doesn't have to
be carried out-of-tree.

So what are the options for this in post v4.12..?
