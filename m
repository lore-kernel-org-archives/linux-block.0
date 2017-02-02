Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751206AbdBBVKQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Feb 2017 16:10:16 -0500
Date: Thu, 2 Feb 2017 16:10:14 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: split scsi passthrough fields out of struct request V2
Message-ID: <20170202211014.GA27604@redhat.com>
References: <9198f024-9d55-3a28-9f77-ecbca42873b5@kernel.dk>
 <1485967586.2560.1.camel@sandisk.com>
 <7e963480-edf9-5687-25f3-83890373a26f@kernel.dk>
 <1485986472.2560.14.camel@sandisk.com>
 <1486056424.2816.4.camel@sandisk.com>
 <20170202183334.GB26910@redhat.com>
 <1486060991.2816.8.camel@sandisk.com>
 <20170202191330.GA27107@redhat.com>
 <1486064795.2816.14.camel@sandisk.com>
 <20170202210434.GA27548@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170202210434.GA27548@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 02 2017 at  4:04pm -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Thu, Feb 02 2017 at  2:46pm -0500,
> Bart Van Assche <Bart.VanAssche@sandisk.com> wrote:
> 
> > On Thu, 2017-02-02 at 14:13 -0500, Mike Snitzer wrote:
> > > On Thu, Feb 02 2017 at  1:43pm -0500, Bart Van Assche <Bart.VanAssche@sandisk.com> wrote:
> > > > On Thu, 2017-02-02 at 13:33 -0500, Mike Snitzer wrote:
> > > > > I'll go back over hch's changes to see if I can spot anything.  But is
> > > > > this testing using dm_mod.use_bk_mq=Y or are you testing old .request_fn
> > > > > dm-multipath?
> > > > 
> > > > The srp-test software tests multiple configurations: dm-mq on scsi-mq, dm-sq
> > > > on scsi-mq and dm-sq on scsi-sq. I have not yet checked which of these
> > > > three configurations triggers the kernel crash.
> > > 
> > > OK, such info is important to provide for crashes like this.  Please let
> > > me know once you do.
> > 
> > Hello Mike,
> > 
> > Apparently it's the large I/O test (using dm-mq on scsi-mq) that triggers the
> > crash:
> 
> I've gone over Christoph's "dm: always defer request allocation to the
> owner of the request_queue" commit yet again.  Most of that commit's
> changes are just mechanical.  I didn't see any problems.
> 
> In general, dm_start_request() calls dm_get(md) to take a reference on
> the mapped_device.  And rq_completed() calls dm_put(md) to drop the
> reference.  The DM device's request_queue (md->queue) should _not_ ever
> be torn down before all references on the md have been dropped. But I'll
> have to look closer on how/if that is enforced anywhere by coordinating
> with block core.
> 
> In any case, the crash you reported was that the mapped_device was being
> dereferenced after it was freed (at line 187's md->queue).  Which seems
> to imply a dm_get/dm_put reference count regression.  But I'm not seeing
> where at this point.

Maybe it isn't a regression but something about Christoph's changes
causes a race to present itself?

Care to try moving the dm_get(md) at the end of dm_start_request() to
the beginning of dm_start_request() and report back on whether it helps
at all?

Thanks,
Mike
