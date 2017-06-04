Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH] nvme: fix hang in remove path
To: Rakesh Pandit <rakesh@tuxera.com>, Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Christoph Hellwig <hch@lst.de>, Johannes Thumshirn <jthumshirn@suse.de>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20170602083208.4518-1-ming.lei@redhat.com>
 <20170602180435.GA23335@dhcp-216.srv.tuxera.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <244bc065-92eb-c3e0-faa7-11569fc326d6@grimberg.me>
Date: Sun, 4 Jun 2017 18:24:09 +0300
MIME-Version: 1.0
In-Reply-To: <20170602180435.GA23335@dhcp-216.srv.tuxera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> It would make sense to still add:
> 
> if (ctrl->state == NVME_CTRL_DELETING || ctrl->state == NVME_CTRL_DEAD)
> 	return
> 
> inside nvme_configure_apst at the top irrespective of this change.

I'm not sure what is the value given that it is taken care of in
.queue_rq?
