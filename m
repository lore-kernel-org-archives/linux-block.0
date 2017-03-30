Return-Path: <hch@lst.de>
Date: Thu, 30 Mar 2017 10:53:43 +0200
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
Subject: Re: [PATCH 01/23] block: renumber REQ_OP_WRITE_ZEROES
Message-ID: <20170330085343.GB12015@lst.de>
References: <20170323143341.31549-1-hch@lst.de> <20170323143341.31549-2-hch@lst.de> <1490717553.2573.4.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490717553.2573.4.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 28, 2017 at 04:12:46PM +0000, Bart Van Assche wrote:
> Since REQ_OP_WRITE_ZEROES was introduced in kernel v4.10, do we need
> "Cc: stable" and "Fixes: a6f0788ec2881" tags for this patch?

No.  This just works around the way scsi_setup_cmnd sets up the data
direction.  Before this series it's not an issue because no one used
the req_op data direction for setting up the dma direction.
