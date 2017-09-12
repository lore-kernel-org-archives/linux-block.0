Return-Path: <ming.lei@redhat.com>
Date: Tue, 12 Sep 2017 10:17:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 0/5] Make SCSI device suspend work reliably
Message-ID: <20170912021707.GA31533@ming.t460p>
References: <20170908235226.26622-1-bart.vanassche@wdc.com>
 <20170909103859.GA29285@ming.t460p>
 <1505147128.2802.36.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505147128.2802.36.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 11, 2017 at 04:25:30PM +0000, Bart Van Assche wrote:
> On Sat, 2017-09-09 at 18:39 +0800, Ming Lei wrote:
> > - the issue is not suspend/resume only, it is about SCSI quiesce vs.
> > RQF_PREEMPT.
> 
> The only in-kernel user of the SCSI quiesce/resume functionality next to
> runtime power management I know of is the SPI transport, namely
> spi_dv_device(). Nobody has ever reported a hang in spi_dv_device() as far
> as I know. Since the number of users of the SCSI parallel transport is very
> small I propose to wait with fixing spi_dv_device() until someone shows that
> it is possible to trigger that hang. If we have to address a hang in
> spi_dv_device() I propose to address it in the same way as my patch series
> addresses power management requests, namely by letting previously submitted
> requests complete and by making blk_get_request() callers wait until the
> quiesced SCSI device has been resumed.

As I mentioned in V4 cover letter, Cathy saw this I/O hang issue, and
she has verified that my revised patchset V3 can fix the issue.

> 
> > I don't see the issue above addressed by this patchset, so maybe
> > you are trying to fix another PM specific issue(not reported by
> > Oleksandr), I am just confused.
> 
> That's correct - I'm only trying to address the PM issues. I will mention
> that explicitly when I repost this patch series.

Unfortunately it isn't enough, and the approach you took is wrong too,
I will comment it in your patch 4.

-- 
Ming
