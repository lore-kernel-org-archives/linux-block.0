Return-Path: <hch@lst.de>
Date: Thu, 30 Mar 2017 10:59:52 +0200
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "agk@redhat.com" <agk@redhat.com>,
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
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Subject: Re: [PATCH 11/23] block_dev: use blkdev_issue_zerout for hole
	punches
Message-ID: <20170330085952.GC12015@lst.de>
References: <20170323143341.31549-1-hch@lst.de> <20170323143341.31549-12-hch@lst.de> <1490719834.2573.9.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490719834.2573.9.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 28, 2017 at 04:50:47PM +0000, Bart Van Assche wrote:
> On Thu, 2017-03-23 at 10:33 -0400, Christoph Hellwig wrote:
> > This gets us support for non-discard efficient write of zeroes (e.g. NVMe)
> > and preparse for removing the discard_zeroes_data flag.
> 
> Hello Christoph,
> 
> "preparse" probably should have been "prepare"?

Yes, fixed.
