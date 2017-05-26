Return-Path: <hch@lst.de>
Date: Fri, 26 May 2017 08:08:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 05/19] cdrom: Check private request size before
	attaching to a queue
Message-ID: <20170526060813.GE18424@lst.de>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com> <20170525184327.23570-6-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170525184327.23570-6-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 25, 2017 at 11:43:13AM -0700, Bart Van Assche wrote:
> Since the cdrom driver only supports request queues for which
> struct scsi_request is the first member of their private request
> data, refuse to register block layer queues for which this is
> not the case.

Hmm.  I think we have a deeper issue there.  The cdrom layer usually
sends packets commands through the cdrom ops ->generic_packet
method, but one function (cdrom_read_cdda_bpc) seems to directly
send a scsi passthrough request.  It is only used if the cdda_method
is not CDDA_OLD, which is set if the cdrom_device_info structure
does not have a gendisk pointer hanging off it.  It seems like
the legacy cdrom drivers fall into that category and would be
broken by this change.
