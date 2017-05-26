Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 05/19] cdrom: Check private request size before attaching
 to a queue
Date: Fri, 26 May 2017 15:50:42 +0000
Message-ID: <1495813840.2634.1.camel@sandisk.com>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com>
	 <20170525184327.23570-6-bart.vanassche@sandisk.com>
	 <20170526060813.GE18424@lst.de>
In-Reply-To: <20170526060813.GE18424@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-05-26 at 08:08 +0200, Christoph Hellwig wrote:
> On Thu, May 25, 2017 at 11:43:13AM -0700, Bart Van Assche wrote:
> > Since the cdrom driver only supports request queues for which
> > struct scsi_request is the first member of their private request
> > data, refuse to register block layer queues for which this is
> > not the case.
>=20
> Hmm.  I think we have a deeper issue there.  The cdrom layer usually
> sends packets commands through the cdrom ops ->generic_packet
> method, but one function (cdrom_read_cdda_bpc) seems to directly
> send a scsi passthrough request.  It is only used if the cdda_method
> is not CDDA_OLD, which is set if the cdrom_device_info structure
> does not have a gendisk pointer hanging off it.  It seems like
> the legacy cdrom drivers fall into that category and would be
> broken by this change.

Hello Christoph,

How about moving the check into cdrom_read_cdda_bpc()? As far as I can see
that function is only called if a CDROMREADAUDIO ioctl is submitted. Althou=
gh
Documentation/cdrom/cdrom-standard.tex mentions that that ioctl is unsuppor=
ted
applications like cdparanoia use it.

Bart.=
