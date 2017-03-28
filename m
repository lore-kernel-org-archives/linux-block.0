Return-Path: <msnitzer@redhat.com>
Date: Tue, 28 Mar 2017 15:33:54 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "agk@redhat.com" <agk@redhat.com>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
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
Subject: Re: [PATCH 03/23] sd: implement REQ_OP_WRITE_ZEROES
Message-ID: <20170328193354.GB21445@redhat.com>
References: <20170323143341.31549-1-hch@lst.de>
 <20170323143341.31549-4-hch@lst.de>
 <1490726988.2573.16.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490726988.2573.16.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 28 2017 at  2:50pm -0400,
Bart Van Assche <Bart.VanAssche@sandisk.com> wrote:

> On Thu, 2017-03-23 at 10:33 -0400, Christoph Hellwig wrote:
> > diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> > index af632e350ab4..b6f70a09a301 100644
> > --- a/drivers/scsi/sd.c
> > +++ b/drivers/scsi/sd.c
> > @@ -748,7 +748,7 @@ static int sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
> >  	return scsi_init_io(cmd);
> >  }
> >  
> > -static int sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd)
> > +static int sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd, bool unmap)
> >  {
> >  	struct scsi_device *sdp = cmd->device;
> >  	struct request *rq = cmd->request;
> > @@ -765,13 +765,14 @@ static int sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd)
> >  
> >  	cmd->cmd_len = 16;
> >  	cmd->cmnd[0] = WRITE_SAME_16;
> > -	cmd->cmnd[1] = 0x8; /* UNMAP */
> > +	if (unmap)
> > +		cmd->cmnd[1] = 0x8; /* UNMAP */
> >  	put_unaligned_be64(sector, &cmd->cmnd[2]);
> >  	put_unaligned_be32(nr_sectors, &cmd->cmnd[10]);
> 
> Hello Christoph,
> 
> A quote from SBC: "An OPTIMAL UNMAP GRANULARITY field set to a non-zero value
> indicates the optimal granularity in logical blocks for unmap requests (e.g.,
> an UNMAP command or a WRITE SAME (16) command with the UNMAP bit set to one).
> An unmap request with a number of logical blocks that is not a multiple of
> this value may result in unmap operations on fewer LBAs than requested."
> 
> This means that just like the start and end of a discard must be aligned on a
> discard_granularity boundary, WRITE SAME commands with the UNMAP bit set must
> also respect that granularity. I think this means that either
> __blkdev_issue_zeroout() has to be modified such that it rejects unaligned
> REQ_OP_WRITE_ZEROES operations or that blk_bio_write_same_split() has to be
> modified such that it generates REQ_OP_WRITEs for the unaligned start and tail.

That'd get DM thinp off the hook from having to zero the unaligned start
and tail...
