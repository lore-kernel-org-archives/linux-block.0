Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750790AbdJ0Fiz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Oct 2017 01:38:55 -0400
Date: Fri, 27 Oct 2017 13:38:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
        "osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Message-ID: <20171027053834.GA12858@ming.t460p>
References: <20171027044330.11921-1-ming.lei@redhat.com>
 <1509079996.3244.3.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509079996.3244.3.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Bart,

On Fri, Oct 27, 2017 at 04:53:18AM +0000, Bart Van Assche wrote:
> On Fri, 2017-10-27 at 12:43 +0800, Ming Lei wrote:
> > The 1st patch removes the RESTART for TAG-SHARED because SCSI handles it
> > by itself, and not necessary to waste CPU to do the expensive RESTART.
> > And Roman Pen reported that this RESTART cuts half of IOPS in his case.
> > 
> > The 2nd patch removes the RESTART when .get_budget returns BLK_STS_RESOURCE,
> > and this RESTART is handled by SCSI's RESTART(scsi_end_request()) too.
> 
> Hello Ming,
> 
> There are more block drivers than the SCSI core that share tags. If the

Could you share us what the other in-tree driver which share tags is?

If there are really more, and when all can share similar RESTART mechanism, I
think that is the time for considering the common RESTART.

> restart mechanism is removed from the blk-mq core, does that mean that all
> block drivers that share tags will have to follow the example of the SCSI
> core and implement a restart mechanism themselves? As far as I know there

If there are such drivers, there should have been their own restart mechanism
which works for long time before blk-mq comes, and more importantly each driver
has much more knowledge than generic block layer to handle the restart,
such as SCSI's restart, that means driver's implementation may be more efficient.

Also the RESTART for TAG-SHARED may never function as expected wrt. SCSI.

And more importantly the block's RESTART for TAG-SHARED has caused big performance
issue for people.

IMO, the above two reasons are enough to remove the current RESTART for shared-tag.

> is a strong preference in the Linux community to implement common mechanisms
> in the (block layer) core instead of in drivers. It seems to me like you are
> proposing the opposite, namely removing a general mechanism from the (block
> layer) core and moving it into a driver, namely the SCSI core?

Actually SCSI's RESTART is very thin, and it is just the per-host starved_list.


Thanks,
Ming
