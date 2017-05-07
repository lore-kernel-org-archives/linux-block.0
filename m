Return-Path: <hch@lst.de>
Date: Sun, 7 May 2017 11:22:09 +0200
From: "hch@lst.de" <hch@lst.de>
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: "hch@lst.de" <hch@lst.de>, Bart Van Assche <Bart.VanAssche@sandisk.com>,
	"agk@redhat.com" <agk@redhat.com>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
	"snitzer@redhat.com" <snitzer@redhat.com>,
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
Message-ID: <20170507092209.GA27370@lst.de>
References: <20170405172125.22600-1-hch@lst.de> <20170405172125.22600-26-hch@lst.de> <1493671519.2665.15.camel@sandisk.com> <1493707425.23202.77.camel@haakon3.risingtidesystems.com> <1493709373.23202.79.camel@haakon3.risingtidesystems.com> <20170502072328.GA11522@lst.de> <1493782395.23202.84.camel@haakon3.risingtidesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493782395.23202.84.camel@haakon3.risingtidesystems.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 02, 2017 at 08:33:15PM -0700, Nicholas A. Bellinger wrote:
> The larger target/iblock conversion patch looks like post v4.12 material
> at this point, so to avoid breakage wrt to existing LBPRZ behavior, I'll
> plan to push the following patch post -rc1.

I don't think this is safe.  If you want to do the aboe you also
need to ensure ->execute_unmap always zeroes the data.  For actual
files in the file backend we should be all fine, but for the block
device case [1] and iblock we'd need to use blkdev_issue_zeroout
instead of blkdev_issue_discard when unmap_zeroes_data is set.

[1] which btw already seems broken as it doesn't invalidate cached
data when issuing a discard.
