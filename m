Return-Path: <nab@linux-iscsi.org>
Message-ID: <1494484582.16894.156.camel@haakon3.risingtidesystems.com>
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
Date: Wed, 10 May 2017 23:36:22 -0700
In-Reply-To: <20170511062630.GA18517@lst.de>
References: <20170405172125.22600-26-hch@lst.de>
	 <1493671519.2665.15.camel@sandisk.com>
	 <1493707425.23202.77.camel@haakon3.risingtidesystems.com>
	 <1493709373.23202.79.camel@haakon3.risingtidesystems.com>
	 <20170502072328.GA11522@lst.de>
	 <1493782395.23202.84.camel@haakon3.risingtidesystems.com>
	 <20170507092209.GA27370@lst.de>
	 <1494312374.16894.36.camel@haakon3.risingtidesystems.com>
	 <20170510140627.GA23759@lst.de>
	 <1494478235.16894.115.camel@haakon3.risingtidesystems.com>
	 <20170511062630.GA18517@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-05-11 at 08:26 +0200, hch@lst.de wrote:
> On Wed, May 10, 2017 at 09:50:35PM -0700, Nicholas A. Bellinger wrote:
> > 1) Expose a block_device or request_queue bit to signal 'real LBPRZ'
> > support up to IBLOCK, in order to maintain SCSI target feature
> > compatibility.
> 
> No way.  If you want to zero use REQ_OP_WRITE_ZEROES..

Yes, I understand that part and it's what the earlier conversion of
IBLOCK to use blkdev_issue_zeroout() already does.

Once the blkdev_issue_zeroout() conversion is in place then LBPRZ can
always be set to one for IBLOCK using blkdev_issue_zeroout().

The point is this is not in -rc1, which as-is breaks LBPRZ compat for a
release.
