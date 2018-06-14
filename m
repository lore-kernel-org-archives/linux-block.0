Return-Path: <lurodriguez@suse.de>
Date: Thu, 14 Jun 2018 19:44:11 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"mwilck@suse.com" <mwilck@suse.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"agk@redhat.com" <agk@redhat.com>, "hare@suse.de" <hare@suse.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"yuchao0@huawei.com" <yuchao0@huawei.com>,
	"ghe@suse.com" <ghe@suse.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"tchvatal@suse.com" <tchvatal@suse.com>,
	"zren@suse.com" <zren@suse.com>
Subject: Re: [PATCH] dm-zoned-tools: add zoned disk udev rules for scheduler
 / dmsetup
Message-ID: <20180614174411.GJ5527@wotan.suse.de>
References: <20180614001147.1545-1-mcgrof@kernel.org>
 <64d7d5386d6171a9a551f22db86524cf7a595af5.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <64d7d5386d6171a9a551f22db86524cf7a595af5.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 14, 2018 at 04:19:23PM +0000, Bart Van Assche wrote:
> On Wed, 2018-06-13 at 17:11 -0700, Luis R. Rodriguez wrote:
> > This tries to put a bit of this tribal knowledge into an initial udev
> > rule for development with the hopes Linux distributions can later
> > deploy. Three rule are added. One rule is optional for now, it should be
> > extended later to be more distribution-friendly and then I think this
> > may be ready for consideration for integration on distributions.
> > 
> > 1) scheduler setup
> > 2) backlist f2fs devices
> > 3) run dmsetup for the rest of devices
> 
> Hello Luis,
> 
> I think it is wrong to package the zoned block device scheduler rule in the
> dm-zoned-tools package. That udev rule should be activated whether or not the
> dm-zoned-tools package has been installed. Have you considered to submit the
> zoned block device scheduler rule to the systemd project since today that
> project includes all base udev rules?

Nope, this is a udev rule intended for developers wishing to brush up on our
state of affairs. All I wanted to do is to get my own drive to work at home in
a reasonably reliable and generic form, which also allowed me to hop around
kernels without a fatal issue.

Clearly there is much to discuss still and a roadmap to illustrate. We should
update the documentation to reflect this first, and based on that enable then
distributions based on that discussion. We should have short term and long term
plans. That discussion may have taken place already so forgive me for not
knowing about it, I did try to read as much from the code and existing tools
and just didn't find anything else to be clear on it.

> > +# Zoned disks can only work with the deadline or mq-deadline scheduler. This is
> > +# mandated for all SMR drives since v4.16. It has been determined this must be
> > +# done through a udev rule, and the kernel should not set this up for disks.
> > +# This magic will have to live for *all* zoned disks.
> > +# XXX: what about distributions that want mq-deadline ? Probably easy for now
> > +#      to assume deadline and later have a mapping file to enable
> > +#      mq-deadline for specific serial devices?
> > +ACTION=="add|change", KERNEL=="sd*[!0-9]", ATTRS{queue/zoned}=="host-managed", \
> > +	ATTR{queue/scheduler}="deadline"
> 
> I think it is wrong to limit this rule to SCSI disks only. Work is ongoing to
> add zoned block device support to the null_blk driver. That is a block driver
> and not a SCSI driver. I think the above udev rule should apply to that block
> driver too.

Sure patches welcomed :)

> Regarding blk-mq, from the mq-deadline source code:
> 	.elevator_alias = "deadline",
> 
> In other words, the name "deadline" should work both for legacy and for blk-mq
> block devices.

Groovy that helps.

  Luis
