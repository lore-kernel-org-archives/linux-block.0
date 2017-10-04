Return-Path: <ming.lei@redhat.com>
Date: Wed, 4 Oct 2017 23:31:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 0/8] block, scsi, md: Improve suspend and resume
Message-ID: <20171004153149.GD9713@ming.t460p>
References: <20171002225218.18548-1-bart.vanassche@wdc.com>
 <20171004065607.GA20879@lst.de>
 <20171004075326.GA17729@ming.t460p>
 <1507130324.3583.9.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507130324.3583.9.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 04, 2017 at 03:18:45PM +0000, Bart Van Assche wrote:
> On Wed, 2017-10-04 at 15:53 +0800, Ming Lei wrote:
> > I have commented on Bart's patchset before, but my comments
> > never gets addressed:
> > 
> > 1) no MD changes required on this issue
> 
> I did not address that comment because you have another view on how suspend
> and resume should work than the rest of the kernel community. See also the
> detailed explanation in https://marc.info/?l=linux-block&m=150695879309606.
> See also Luis' cover letter "[RFC 0/5] fs: replace kthread freezing with
> filesystem freeze/thaw" (https://marc.info/?l=linux-block&m=150705690302420).

That is still in discussion, and once SCSI quiesce is safe, these two
MD change isn't necessary, that is why my patchset focuses on making
SCSI quiesce safe only. That is why I suggest to not include these two
patches in this patchset, because isn't necessary simply.

I also replied Luis already.

> 
> > 2) RCU read lock is missed in fast path
> 
> Did you really post this as a review comment on my patch series? Anyway, this
> is easy to address.

https://marc.info/?l=linux-block&m=150641481732572&w=2


> 
> > 3) bad patch title:
> > 
> > - such as :  'scsi-mq: Reduce suspend latency'
> > 	this is very misleading since it is actually bug fix
> > 
> > - such as : "Make SCSI device suspend and resume work reliably"
> > 	also a bit not accurate
> 
> Same here - had you posted this as a review comment before? Anyway, this is
> also easy to address.

I have mentioned lots of times, the root cause is only in SCSI quiesce,
actually not related with suspend/resume directly. But you never
consider my comment, that is why you post out these patches with
wrong title(or very misleading) again and again.

> 
> > Also holding sdev->state_mutex before freezing queue might
> > cause deadlock since this lock can be acquired in eh handler(
> > scsi_eh_offline_sdevs())
> 
> Had you posted this as a comment before? Anyway, I will address this comment
> too.

This one is what I just posted out, so you see it isn't marked as 4).

-- 
Ming
