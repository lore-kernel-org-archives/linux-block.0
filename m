Return-Path: <hch@lst.de>
Date: Tue, 2 May 2017 09:23:28 +0200
From: "hch@lst.de" <hch@lst.de>
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: Bart Van Assche <Bart.VanAssche@sandisk.com>,
	"agk@redhat.com" <agk@redhat.com>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
	"snitzer@redhat.com" <snitzer@redhat.com>,
	"hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"shli@kernel.org" <shli@kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Subject: Re: [PATCH 25/27] block: remove the discard_zeroes_data flag
Message-ID: <20170502072328.GA11522@lst.de>
References: <20170405172125.22600-1-hch@lst.de> <20170405172125.22600-26-hch@lst.de> <1493671519.2665.15.camel@sandisk.com> <1493707425.23202.77.camel@haakon3.risingtidesystems.com> <1493709373.23202.79.camel@haakon3.risingtidesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493709373.23202.79.camel@haakon3.risingtidesystems.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 02, 2017 at 12:16:13AM -0700, Nicholas A. Bellinger wrote:
> Or, another options is use bdev_write_zeroes_sectors() to determine when
> dev_attrib->unmap_zeroes_data should be set.

Yes, that in combination with your patch to use bdev_write_zeroes_sectors
for zeroing from write same seems like the right fix.
