Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 8 Feb 2018 09:40:17 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq: Fix race between resetting the timer and
 completion handling
Message-ID: <20180208174017.GR695913@devbig577.frc2.facebook.com>
References: <1518027251.2870.53.camel@wdc.com>
 <20180207200724.GD695913@devbig577.frc2.facebook.com>
 <1518047297.2870.80.camel@wdc.com>
 <1518052193.2870.90.camel@wdc.com>
 <20180208153940.GM695913@devbig577.frc2.facebook.com>
 <1518107501.3611.19.camel@wdc.com>
 <20180208170010.GP695913@devbig577.frc2.facebook.com>
 <1518109843.3611.25.camel@wdc.com>
 <20180208171934.GQ695913@devbig577.frc2.facebook.com>
 <1518111465.3611.36.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518111465.3611.36.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Feb 08, 2018 at 05:37:46PM +0000, Bart Van Assche wrote:
> On Thu, 2018-02-08 at 09:19 -0800, tj@kernel.org wrote:
> > Hello, Bart.
> > 
> > On Thu, Feb 08, 2018 at 05:10:45PM +0000, Bart Van Assche wrote:
> > > I think "dereferencing a pointer" means reading the memory location that pointer points
> > > at? Anyway, I think we both interpret the crash report in the same way, namely that it
> > > means that scmd->device == NULL.
> > 
> > No, what I'm trying to say is that it's is the device->host reference
> > not the scmd->device reference.
> 
> Again, I think that means that we agree about the interpretation of the crash
> report. The big question here is what the next step should be to analyze this
> further and/or to avoid that this crash can occur?

Heh, sorry about not being clear.  What I'm trying to say is that
scmd->device != NULL && device->host == NULL.  Or was this what you
were saying all along?

Thanks.

-- 
tejun
