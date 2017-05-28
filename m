Return-Path: <hch@lst.de>
Date: Sun, 28 May 2017 10:32:55 +0200
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 05/19] cdrom: Check private request size before
	attaching to a queue
Message-ID: <20170528083255.GA13083@lst.de>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com> <20170525184327.23570-6-bart.vanassche@sandisk.com> <20170526060813.GE18424@lst.de> <1495813840.2634.1.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495813840.2634.1.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 26, 2017 at 03:50:42PM +0000, Bart Van Assche wrote:
> On Fri, 2017-05-26 at 08:08 +0200, Christoph Hellwig wrote:
> > On Thu, May 25, 2017 at 11:43:13AM -0700, Bart Van Assche wrote:
> > > Since the cdrom driver only supports request queues for which
> > > struct scsi_request is the first member of their private request
> > > data, refuse to register block layer queues for which this is
> > > not the case.
> > 
> > Hmm.  I think we have a deeper issue there.  The cdrom layer usually
> > sends packets commands through the cdrom ops ->generic_packet
> > method, but one function (cdrom_read_cdda_bpc) seems to directly
> > send a scsi passthrough request.  It is only used if the cdda_method
> > is not CDDA_OLD, which is set if the cdrom_device_info structure
> > does not have a gendisk pointer hanging off it.  It seems like
> > the legacy cdrom drivers fall into that category and would be
> > broken by this change.
> 
> Hello Christoph,
> 
> How about moving the check into cdrom_read_cdda_bpc()? As far as I can see
> that function is only called if a CDROMREADAUDIO ioctl is submitted. Although
> Documentation/cdrom/cdrom-standard.tex mentions that that ioctl is unsupported
> applications like cdparanoia use it.

I guess that's fine for now.  In the long run we can probably replace
the current users of generic_packet method with direct scsi passthrough
requests, but that can be left for later.
