Return-Path: <hch@lst.de>
Date: Thu, 9 Nov 2017 10:13:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 4/5] nvme: implement multipath access to nvme subsystems
Message-ID: <20171109091348.GA16793@lst.de>
References: <20171102183034.9320-1-hch@lst.de> <20171102183034.9320-5-hch@lst.de> <20171108085417.GA19990@lst.de> <70376777-56f1-76f8-84be-d2df4a855fa6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <70376777-56f1-76f8-84be-d2df4a855fa6@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Nov 08, 2017 at 12:18:32PM +0100, Hannes Reinecke wrote:
> On 11/08/2017 09:54 AM, Christoph Hellwig wrote:
> > Can I get a review for this one?  The only changes vs the previously
> > reviewed versions is that we don't use the multipath code at all for
> > subsystems that aren't multiported, and that there is an explicit
> > opt-out at compile and module load time, so it shouldn't be that hard
> > to review for those who reviewed the previous versions.
> > 
> The one thing I need to try is co-existence with dm-multipath, ie
> ensuring that dm-multipath stays out of the way if nvme multipathing is
> enabled.

For one it will work just fine on the single node.  Second you easily
check it from the sysfs layout.

> 
> I hope to get it done sometime later this week
> 
> And I'll see to get the other patches reviewed.

Please do so now - you've complained about things going slow for a
merge in this merge window, and now we're only waiting for you.
