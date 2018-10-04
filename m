Return-Path: <aherrmann@suse.com>
Date: Thu, 4 Oct 2018 10:24:55 +0200
From: Andreas Herrmann <aherrmann@suse.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jan Kara <jack@suse.cz>, Linus Walleij <linus.walleij@linaro.org>,
	Paolo Valente <paolo.valente@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	linux-mmc <linux-mmc@vger.kernel.org>,
	linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Richard Weinberger <richard@nod.at>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>, mgorman@suse.com,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
Message-ID: <20181004082455.ulk37hzmyuo4byw2@suselix>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <CACRpkdaeYU+Crr75T49WftyOHqCrsyBLBPDBBsJF-RCjmAQEdw@mail.gmail.com>
 <20181003132554.GC21043@quack2.suse.cz>
 <20181004074535.GB6682@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20181004074535.GB6682@linux-x5ow.site>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 04, 2018 at 09:45:35AM +0200, Johannes Thumshirn wrote:
> On Wed, Oct 03, 2018 at 03:25:54PM +0200, Jan Kara wrote:
> > On Wed 03-10-18 08:53:37, Linus Walleij wrote:
> > > On Wed, Oct 3, 2018 at 8:29 AM Paolo Valente <paolo.valente@linaro.org> wrote:
> > > 
> > > > So, I do understand your need for conservativeness, but, after so much
> > > > evidence on single-queue devices, and so many years! :), what's the
> > > > point in keeping Linux worse for virtually everybody, by default?
> > > 
> > > I understand if we need to ease things in as well, I don't intend this
> > > change for the current merge window or anything, since v4.19
> > > will notably have this patch:
> > > 
> > > commit d5038a13eca72fb216c07eb717169092e92284f1
> > > Author: Johannes Thumshirn <jthumshirn@suse.de>
> > > Date:   Wed Jul 4 10:53:56 2018 +0200
> > > 
> > >     scsi: core: switch to scsi-mq by default
> > > 
> > >     It has been more than one year since we tried to change the default from
> > >     legacy to multi queue in SCSI with commit c279bd9e406 ("scsi: default to
> > >     scsi-mq"). But due to issues with suspend/resume and performance problems
> > >     it had been reverted again with commit cbe7dfa26eee ("Revert "scsi: default
> > >     to scsi-mq"").
> > > 
> > >     In the meantime there have been a substantial amount of performance
> > >     improvements and suspend/resume got fixed as well, thus we can re-enable
> > >     scsi-mq without a significant performance penalty.
> > > 
> > >     Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> > >     Reviewed-by: Hannes Reinecke <hare@suse.com>
> > >     Reviewed-by: Ming Lei <ming.lei@redhat.com>
> > >     Acked-by: John Garry <john.garry@huawei.com>
> > >     Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> > > 
> > > I guess that patch can be a bit scary by itself. But IIUC it all went
> > > fine this time!
> > > 
> > > But hey, if that works, that means $SUBJECT patch will enable BFQ on all
> > > libata devices and any SCSI that is single queue as well, not just
> > > "obscure" stuff like MMC/SD and UBI, and that is
> > > indeed a massive crowd of legacy devices. But we're talking
> > > v4.21 here.
> > > 
> > > Johannes, you might be interested in $SUBJECT patch.
> > > It'd be nice to hear what SUSE people have to add, since they
> > > are pretty proactive in this area.
> > 
> > So we do have a udev rules in our distro which sets the IO scheduler based
> > on device parameters (rotational at least, with blk-mq we might start
> > considering number of queues as well, plus we have some exceptions like
> > virtio, loop, etc.). So the kernel default doesn't concern us too much as a
> > distro.
> > 
> > I personally would consider bfq a safer default for single-queue devices
> > (loop probably needs exception) but I don't feel too strongly about it.
> 
> [Full quote for context]
> 
> What about resurrecting CONFIG_DEFAULT_IOSCHED for MQ as well and
> leave it default to mq-deadline but give bfq, kyber and none as a
> choice as well?

I second this -- introduction of a CONFIG_DEFAULT_MQ_IOSCHED.
Having a default I/O scheduler kernel config option for MQ allows to
build a kernel suitable for specific use w/o userspace
dependencies.
(But it still allows to reconfigure things via userspace.)

> The question is shall we only do it for single queue devices or for
> native MQ devices as well if we go down that road?

Good question. I am not yet sure about this.
I'd start with using the default for single queue devices.

Andreas

> I understand the embedded floks will want a different interface than
> udev, but from the non-embedded point of view I'm with Jens and Jan
> here, let udev do the job.
> 
>       Johannes
> -- 
> Johannes Thumshirn                                          Storage
> jthumshirn@suse.de                                +49 911 74053 689
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
> GF: Felix Imendörffer, Jane Smithard, Graham Norton
> HRB 21284 (AG Nürnberg)
> Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
