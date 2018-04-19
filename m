Return-Path: <hch@lst.de>
Date: Thu, 19 Apr 2018 11:14:17 +0200
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "shaun@tancheff.com" <shaun@tancheff.com>,
	"hare@suse.com" <hare@suse.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] block: Avoid executing a report or reset zones while a
	queue is frozen
Message-ID: <20180419091417.GA22988@lst.de>
References: <20180417010034.28676-1-bart.vanassche@wdc.com> <20180417151857.GA25646@lst.de> <f966e56f3c2c9add48d0a93fb56321f7eb7ee33e.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f966e56f3c2c9add48d0a93fb56321f7eb7ee33e.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 17, 2018 at 05:35:07PM +0000, Bart Van Assche wrote:
> > Hmm.  I think we need to avoid clearing that data and update it using
> > RCU instead.  Calling blk_queue_enter before submitting bios is
> > something that would make zone reporting very different from any
> > other block layer user.
> 
> Hello Christoph,
> 
> Please have a look at generic_make_request(). I think that function shows
> that blk_queue_enter() is called anyway before .make_request_fn() is called.

Yes, that is the point.  We already call blk_queue_enter in
generic_make_request, which the zone report and reset ops pass through.
