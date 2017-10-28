Return-Path: <hch@lst.de>
Date: Sat, 28 Oct 2017 09:42:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guan Junxiong <guanjunxiong@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	niuhaoxin <niuhaoxin@huawei.com>,
	"Shenhong (C)" <shenhong09@huawei.com>
Subject: Re: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
Message-ID: <20171028074245.GA15510@lst.de>
References: <20171023145126.2471-1-hch@lst.de> <20171023145126.2471-7-hch@lst.de> <20171024213959.GB23307@redhat.com> <20171028063825.GA14261@lst.de> <dc988a8a-8c88-fe20-34a0-de5cdd615b6b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dc988a8a-8c88-fe20-34a0-de5cdd615b6b@huawei.com>
List-ID: <linux-block@vger.kernel.org>

On Sat, Oct 28, 2017 at 03:20:07PM +0800, Guan Junxiong wrote:
> Think of some current advanced features of DM-Multipath combined with multipath-tools
> such as path-latency priority grouping, intermittent IO error accounting for path
> degradation, delayed or immediate or follow-over failback feature.
> Those features, which is significant in some scenario, need to use per-controller block devices.
> Therefore, I think it is worthy adding a CONFIG_NVME_MULTIPATHING knob to
> hide or show per-controller block devices.
> 
> How about let me to add this this CONFIG_NVME_MULTIPATHING knob?

There is defintively not going to be a run-time nob, sorry.  You've
spent this work on dm-multipath after the nvme group pretty clearly
said that this is not what we are going to support, and we have not
interest in supporting this.  Especially as proper path discovery,
asymetic namespaces states and similar can only be supported properly
with the in-kernel code.
