Return-Path: <msnitzer@redhat.com>
Date: Sat, 28 Oct 2017 10:17:45 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
Message-ID: <20171028141745.GA32039@redhat.com>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-7-hch@lst.de>
 <20171024213959.GB23307@redhat.com>
 <20171028063825.GA14261@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171028063825.GA14261@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Sat, Oct 28 2017 at  2:38am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Oct 24, 2017 at 05:40:00PM -0400, Mike Snitzer wrote:
> > Having the NVme driver go to such lengths to hide its resources from
> > upper layers is certainly the work of an evil genius experiencing some
> > serious territorial issues.  Not sugar-coating it.. you wouldn't.
> 
> I'm pretty surre Hannes will appreciate being called an evil genius :)

Well, to be fair.. it doesn't take that much brain power to arrive at
isolationism.

And pretty sure Hannes had a better idea with using the blkdev_get
(holders/claim) interface but you quickly dismissed that.  Despite it
being the best _existing_ way to ensure mutual exclusion with the rest
of the block layer.

> > I kept meaning to reply to your earlier iterations on this series to
> > ask: can we please get a CONFIG_NVME_MULTIPATHING knob to make it so
> > that the NVMe driver doesn't implicitly consume (and hide) all
> > per-controler devices?
> 
> I thought about adding it, but mostly for a different reason: it's
> quite a bit of code, and we now start to see NVMe in deeply embedded
> contexts, e.g. the latest Compact Flash spec is based on NVMe, so it
> might be a good idea to give people a chance to avoid the overhead.

OK, so please add it.

> > Ah well.  There is only one correct way to do NVMe multipathing after
> > all right?
> 
> I don't think you'll get very useful results, even if you try.  But I
> guess we'll just have to tell people to use SuSE if they want NVMe
> multipathing to work then :)

Don't do that.  Don't assume you know it all.  Don't fabricate vendor
wars in your head and then project it out to the rest of the community.
We're all in this together.

Fact is Hannes and I have exchanged private mail (in response to this
very thread) and we agree that your approach is currently not suitable
for enterprise deployment.  Hannes needs to also deal with the coming
duality of Linux multipathing and you aren't making it easy.  Just
because you're able to be myopic doesn't mean the rest of us with way
more direct customers behind us can be.

You're finding your way with this new multipath model and I'm happy to
see that happen.  But what I'm not happy about is the steps you're
taking to be actively disruptive.  There were so many ways this all
could've gone and sadly you've elected to stand up an architecture that
doesn't even allow the prospect of reuse.  And for what?  Because doing
so takes 10% more work?  Well we can backfill that work if you'll grant
us an open-mind.

I'm really not against you.  I just need very basic controls put into
the NVMe multipathing code that allows it to be disabled (yet reused).
Not that I have immediate plans to actually _use_ it.  My hope is I can
delegate NVMe multipathing to NVMe!  But I need the latitude to find my
way with the requirements I am, or will be, needing to consider.

Please don't paint me and others in my position into a corner.

Mike
