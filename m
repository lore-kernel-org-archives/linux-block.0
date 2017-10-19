Return-Path: <hch@lst.de>
Date: Thu, 19 Oct 2017 09:24:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 11/17] nvme: get rid of nvme_ctrl_list
Message-ID: <20171019072400.GA12233@lst.de>
References: <20171018165258.23212-1-hch@lst.de> <20171018165258.23212-12-hch@lst.de> <mqd60bb7gbi.fsf@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <mqd60bb7gbi.fsf@linux-x5ow.site>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 19, 2017 at 09:22:09AM +0200, Johannes Thumshirn wrote:
> I'm not sure if the removel of the major number module_param is good
> from an ABI POV. This could lead to some unexpected results for those
> poor souls that used it.

It's a completely broken interface, so I have no pity for them..
