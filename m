Return-Path: <hare@suse.de>
Subject: Re: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
To: Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-7-hch@lst.de> <20171024213959.GB23307@redhat.com>
 <20171028063825.GA14261@lst.de> <20171028141745.GA32039@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ae4180e2-4c1b-a5f0-5c26-7cec692e6d50@suse.de>
Date: Sun, 29 Oct 2017 11:01:54 +0100
MIME-Version: 1.0
In-Reply-To: <20171028141745.GA32039@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/28/2017 04:17 PM, Mike Snitzer wrote:
> On Sat, Oct 28 2017 at  2:38am -0400,
> Christoph Hellwig <hch@lst.de> wrote:
> 
>> On Tue, Oct 24, 2017 at 05:40:00PM -0400, Mike Snitzer wrote:
[ .. ]
>>> Ah well.  There is only one correct way to do NVMe multipathing after
>>> all right?
>>
>> I don't think you'll get very useful results, even if you try.  But I
>> guess we'll just have to tell people to use SuSE if they want NVMe
>> multipathing to work then :)
> 
> Don't do that.  Don't assume you know it all.  Don't fabricate vendor
> wars in your head and then project it out to the rest of the community.
> We're all in this together.
> 
> Fact is Hannes and I have exchanged private mail (in response to this
> very thread) and we agree that your approach is currently not suitable
> for enterprise deployment.  Hannes needs to also deal with the coming
> duality of Linux multipathing and you aren't making it easy.  Just
> because you're able to be myopic doesn't mean the rest of us with way
> more direct customers behind us can be.
> 
> You're finding your way with this new multipath model and I'm happy to
> see that happen.  But what I'm not happy about is the steps you're
> taking to be actively disruptive.  There were so many ways this all
> could've gone and sadly you've elected to stand up an architecture that
> doesn't even allow the prospect of reuse.  And for what?  Because doing
> so takes 10% more work?  Well we can backfill that work if you'll grant
> us an open-mind.
> 
> I'm really not against you.  I just need very basic controls put into
> the NVMe multipathing code that allows it to be disabled (yet reused).
> Not that I have immediate plans to actually _use_ it.  My hope is I can
> delegate NVMe multipathing to NVMe!  But I need the latitude to find my
> way with the requirements I am, or will be, needing to consider.
> 
> Please don't paint me and others in my position into a corner.
> 
To add my some cents from the SUSE perspective:
We have _quite_ some deployments on dm-multipathing, and most of our
customers are quite accustomed to setting up deployments with that.
It will be impossible to ensure that all customers and installation
scripts will _not_ try starting up multipathing, and for some scenarios
even preferring to use dm-multipath just because their tooling is geared
up for that.
So we absolutely need peaceful coexistence between dm-multipathing and
nvme multipathing. The precise level can be discussed (whether it being
a global on/off switch or some more fine-grained thingie), but we simply
cannot declare nvme multipathing being the one true way for NVMe.
The support-calls alone will kill us.

Note: this has _nothing_ to do with performance. I'm perfectly fine to
accept that dm-multipath has sub-optimal performance.
But that should not imply that it cannot be used for NVMe.

After all, Linux is about choice, not about forcing users to do things
in one way only.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
