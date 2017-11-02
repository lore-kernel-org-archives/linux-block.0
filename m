Return-Path: <BATV+adf086a54a2d754d8a83+5184+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 2 Nov 2017 11:22:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Guan Junxiong <guanjunxiong@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	"Shenhong (C)" <shenhong09@huawei.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	niuhaoxin <niuhaoxin@huawei.com>
Subject: Re: [PATCH 16/17] nvme: implement multipath access to nvme subsystems
Message-ID: <20171102182234.GB29558@infradead.org>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-17-hch@lst.de>
 <70b681c5-5fae-ae40-2ff6-60cf75d52616@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <70b681c5-5fae-ae40-2ff6-60cf75d52616@huawei.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 30, 2017 at 11:37:55AM +0800, Guan Junxiong wrote:
> > +	head->disk->flags = GENHD_FL_EXT_DEVT;
> > +	sprintf(head->disk->disk_name, "nvme%dn%d",
> > +			ctrl->subsys->instance, nsid);
> 
> Is it okay to use head->instance instead of nsid for disk name nvme#n# ?
> Becuase _nsid_ sets are not continuous sometimes, so disk name is ugly in that case.

This actually was supposed to be the ns_head instance, that's why the
ns_ida moved to the subsystem.  I've fixed it up.
