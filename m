Return-Path: <hare@suse.de>
Subject: Re: [PATCH 4/5] nvme: implement multipath access to nvme subsystems
To: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Johannes Thumshirn <jthumshirn@suse.de>
References: <20171102183034.9320-1-hch@lst.de>
 <20171102183034.9320-5-hch@lst.de> <20171108085417.GA19990@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <70376777-56f1-76f8-84be-d2df4a855fa6@suse.de>
Date: Wed, 8 Nov 2017 12:18:32 +0100
MIME-Version: 1.0
In-Reply-To: <20171108085417.GA19990@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/08/2017 09:54 AM, Christoph Hellwig wrote:
> Can I get a review for this one?  The only changes vs the previously
> reviewed versions is that we don't use the multipath code at all for
> subsystems that aren't multiported, and that there is an explicit
> opt-out at compile and module load time, so it shouldn't be that hard
> to review for those who reviewed the previous versions.
> 
The one thing I need to try is co-existence with dm-multipath, ie
ensuring that dm-multipath stays out of the way if nvme multipathing is
enabled.

I hope to get it done sometime later this week

And I'll see to get the other patches reviewed.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
