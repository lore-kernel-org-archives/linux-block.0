Return-Path: <hch@lst.de>
Date: Tue, 29 May 2018 10:24:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 08/14] nvmet: implement the changed namespaces log
Message-ID: <20180529082400.GA1631@lst.de>
References: <20180526102735.31404-1-hch@lst.de> <20180526102735.31404-9-hch@lst.de> <20180528065342.hi74ewwbvkoqsj6x@linux-x5ow.site> <20180529081712.GD1416@lst.de> <20180529081631.mct6zjk54xjl4d6p@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180529081631.mct6zjk54xjl4d6p@linux-x5ow.site>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 29, 2018 at 10:16:31AM +0200, Johannes Thumshirn wrote:
> The "full rescan" part was what I couldn't read out of the spec.

The spec part is: something changed (AEN + some content in the log page)
+ too much changed (all-f first entry).  The rest is host policy, but
except for the full scan I can't think of anything else useful.
