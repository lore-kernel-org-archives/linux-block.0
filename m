Return-Path: <jack@suse.cz>
Date: Wed, 3 Oct 2018 15:25:54 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Paolo Valente <paolo.valente@linaro.org>,
	Johannes Thumshirn <jthumshirn@suse.de>, aherrmann@suse.com,
	Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	linux-mmc <linux-mmc@vger.kernel.org>,
	linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Richard Weinberger <richard@nod.at>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Jan Kara <jack@suse.cz>,
	mgorman@suse.com, Chunyan Zhang <zhang.chunyan@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
Message-ID: <20181003132554.GC21043@quack2.suse.cz>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <CACRpkdaeYU+Crr75T49WftyOHqCrsyBLBPDBBsJF-RCjmAQEdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACRpkdaeYU+Crr75T49WftyOHqCrsyBLBPDBBsJF-RCjmAQEdw@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed 03-10-18 08:53:37, Linus Walleij wrote:
> On Wed, Oct 3, 2018 at 8:29 AM Paolo Valente <paolo.valente@linaro.org> wrote:
> 
> > So, I do understand your need for conservativeness, but, after so much
> > evidence on single-queue devices, and so many years! :), what's the
> > point in keeping Linux worse for virtually everybody, by default?
> 
> I understand if we need to ease things in as well, I don't intend this
> change for the current merge window or anything, since v4.19
> will notably have this patch:
> 
> commit d5038a13eca72fb216c07eb717169092e92284f1
> Author: Johannes Thumshirn <jthumshirn@suse.de>
> Date:   Wed Jul 4 10:53:56 2018 +0200
> 
>     scsi: core: switch to scsi-mq by default
> 
>     It has been more than one year since we tried to change the default from
>     legacy to multi queue in SCSI with commit c279bd9e406 ("scsi: default to
>     scsi-mq"). But due to issues with suspend/resume and performance problems
>     it had been reverted again with commit cbe7dfa26eee ("Revert "scsi: default
>     to scsi-mq"").
> 
>     In the meantime there have been a substantial amount of performance
>     improvements and suspend/resume got fixed as well, thus we can re-enable
>     scsi-mq without a significant performance penalty.
> 
>     Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
>     Reviewed-by: Hannes Reinecke <hare@suse.com>
>     Reviewed-by: Ming Lei <ming.lei@redhat.com>
>     Acked-by: John Garry <john.garry@huawei.com>
>     Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> 
> I guess that patch can be a bit scary by itself. But IIUC it all went
> fine this time!
> 
> But hey, if that works, that means $SUBJECT patch will enable BFQ on all
> libata devices and any SCSI that is single queue as well, not just
> "obscure" stuff like MMC/SD and UBI, and that is
> indeed a massive crowd of legacy devices. But we're talking
> v4.21 here.
> 
> Johannes, you might be interested in $SUBJECT patch.
> It'd be nice to hear what SUSE people have to add, since they
> are pretty proactive in this area.

So we do have a udev rules in our distro which sets the IO scheduler based
on device parameters (rotational at least, with blk-mq we might start
considering number of queues as well, plus we have some exceptions like
virtio, loop, etc.). So the kernel default doesn't concern us too much as a
distro.

I personally would consider bfq a safer default for single-queue devices
(loop probably needs exception) but I don't feel too strongly about it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
