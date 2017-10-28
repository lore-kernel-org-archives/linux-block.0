Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbdJ1Prv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Oct 2017 11:47:51 -0400
Date: Sat, 28 Oct 2017 23:47:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Roman Penyaev <roman.penyaev@profitbricks.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "osandov@fb.com" <osandov@fb.com>,
        "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Message-ID: <20171028154732.GB564@ming.t460p>
References: <20171027044330.11921-1-ming.lei@redhat.com>
 <1509079996.3244.3.camel@wdc.com>
 <20171027053834.GA12858@ming.t460p>
 <CAJrWOzD0LoFhKhFf-BrCtWipVEteT3uUqUc30_qr8E8wNeESGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJrWOzD0LoFhKhFf-BrCtWipVEteT3uUqUc30_qr8E8wNeESGg@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Roman,

On Fri, Oct 27, 2017 at 07:55:33PM +0200, Roman Penyaev wrote:
> Hi Ming,
> 
> On Fri, Oct 27, 2017 at 7:38 AM, Ming Lei <ming.lei@redhat.com> wrote:
> > Hello Bart,
> >
> > On Fri, Oct 27, 2017 at 04:53:18AM +0000, Bart Van Assche wrote:
> >> On Fri, 2017-10-27 at 12:43 +0800, Ming Lei wrote:
> >> > The 1st patch removes the RESTART for TAG-SHARED because SCSI handles it
> >> > by itself, and not necessary to waste CPU to do the expensive RESTART.
> >> > And Roman Pen reported that this RESTART cuts half of IOPS in his case.
> >> >
> >> > The 2nd patch removes the RESTART when .get_budget returns BLK_STS_RESOURCE,
> >> > and this RESTART is handled by SCSI's RESTART(scsi_end_request()) too.
> >>
> >> Hello Ming,
> >>
> >> There are more block drivers than the SCSI core that share tags. If the
> >
> > Could you share us what the other in-tree driver which share tags is?
> >
> > If there are really more, and when all can share similar RESTART mechanism, I
> > think that is the time for considering the common RESTART.
> >
> >> restart mechanism is removed from the blk-mq core, does that mean that all
> >> block drivers that share tags will have to follow the example of the SCSI
> >> core and implement a restart mechanism themselves? As far as I know there
> >
> > If there are such drivers, there should have been their own restart mechanism
> > which works for long time before blk-mq comes, and more importantly each driver
> > has much more knowledge than generic block layer to handle the restart,
> > such as SCSI's restart, that means driver's implementation may be more efficient.
> 
> Personally I would be happier if block layer would do restarts for me.  My eyes
> are bleeding when I see chunks of my own code which do this juggling with hctx,
> enqueuing or dequeuing from a percpu lists, etc inside IBNBD driver.

The issue is that the current block's RESTART for TAG-SHARED isn't efficient, and
never functions as expected. And no one uses that at all actually.

Firstly we have handled cross-queue RESTART via BLK_MQ_S_TAG_WAITING already when
getting driver tag.

Secondly as you see, SCSI handles this kind of RESTART much more efficient and
simply via one linked list, I believe your IBNBD can do this in similar way,
right? If you can't figure out one easy way to do that, I am happy to
provide one patchset[1](which was done via sbitmap weeks ago) to do that
efficiently in block layer, but not the current approach, when you upstream your
IBNBD patchset.

https://github.com/ming1/linux/commits/blk_mq_improve_restart_V1-rc1

Finally you reported that the RESTART for TAG-SHARED has degraded your
IO performance by half, and that can't be accepted, IMO. I found the
similar performance issue in my test too.

> 
> > Also the RESTART for TAG-SHARED may never function as expected wrt. SCSI.
> 
> E.g. new BLK_MQ_F_NO_RESTARTS flag can help to disable restarts when they
> are not needed.

This flag is only needed iff there are more than one in-tree drivers which need
the RESTART for TAG-SHARED.

Also I have mentioned the current RESTART for TAG-SHARED has big performance issue.

> 
> > And more importantly the block's RESTART for TAG-SHARED has caused big performance
> > issue for people.
> 
> That's just a bug in code, not a in issue with restarts, which can be fixed
> if we put hctx which are needed to be restarted in percpu lists and avoid
> long loops and contentions.

Again no in-tree driver uses RESTART for TAG-SHARED now, so not necessary to fix
anything in the RESTART for TAG-SHARED.

If there is driver which need this kind of RESTART in future, one more efficient
implementation can be figured out at that time, but not now. As you see,
I already have one.

Thanks,
Ming
