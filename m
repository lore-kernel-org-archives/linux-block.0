Return-Path: <hch@lst.de>
Date: Tue, 29 Aug 2017 15:12:27 +0200
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hare@suse.com" <hare@suse.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: Call .initialize_rq_fn() also for filesystem
	requests
Message-ID: <20170829131227.GB29153@lst.de>
References: <20170825190057.15592-1-bart.vanassche@wdc.com> <20170828081017.GC2851@lst.de> <1503945091.2841.50.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503945091.2841.50.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hi Bart,

this isn't just about performance - it's about understanability of
the I/O path.

The legacy request path already has the prep_fn, which is intended
for exactly this sort of prep work, but even that led to a lot
of confusion.  For blk-mq we decided to not add it but let the called
driver in control.  I really don't want to move away from that.

The passthrough requests using blk_get_requst are a special case
as the caller allocates the requests, stuffs data into them and only
then hands control to the driver, and thus we need some way to
initialize the request before handing controller to the driver in
this particular special case.  And if needed would could actually
do that with explicit calls instead of the callback, although you
changed it to save a bit of code.
