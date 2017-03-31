Return-Path: <hch@lst.de>
Date: Fri, 31 Mar 2017 09:18:44 +0200
From: "hch@lst.de" <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "hch@lst.de" <hch@lst.de>, Bart Van Assche <Bart.VanAssche@sandisk.com>,
	"agk@redhat.com" <agk@redhat.com>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
	"snitzer@redhat.com" <snitzer@redhat.com>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"shli@kernel.org" <shli@kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Subject: Re: [PATCH 12/23] sd: handle REQ_UNMAP
Message-ID: <20170331071844.GB3308@lst.de>
References: <20170323143341.31549-1-hch@lst.de> <20170323143341.31549-13-hch@lst.de> <1490719722.2573.8.camel@sandisk.com> <20170330090201.GD12015@lst.de> <yq1h92a3hsv.fsf@oracle.com> <20170330173020.GB24229@lst.de> <yq17f36yypg.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq17f36yypg.fsf@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 30, 2017 at 10:19:55PM -0400, Martin K. Petersen wrote:
> > If you manually change the provisioning mode to WS10 on a device that
> > must use WRITE SAME (16) to be able to address all blocks you're already
> > screwed right now, and with this patch you can screw yourself through
> > the WRITE_ZEROES path in addition to the DISCARD path.
> 
> Oh, I see. We only had the LBA sanity check in place for write same, not
> for discard.

And btw, I'd be happy to add such a check, I'd just rather keep it out
of this patch.  It might be a good idea if you give it a turn after
this series given that you have all the devices that have weird
provisioning modes while I don't..
