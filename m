Return-Path: <anish.jhaveri@paviliondata.com>
Date: Tue, 12 Sep 2017 22:12:31 -0700
From: Anish Jhaveri <anish.jhaveri@paviliondata.com>
To: James Smart <james.smart@broadcom.com>, sagi@grimberg.me, hch@lst.de,
	keith.busch@intel.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 02/10] RDMA timeout triggers failover.
Message-ID: <20170913051230.vaq6drn4zjukyh7s@haynes>
References: <20170912042226.bwdalyhvqd5xc24n@haynes>
 <970e4fc8-398a-c42f-6a1e-67a8955b371b@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <970e4fc8-398a-c42f-6a1e-67a8955b371b@broadcom.com>
Return-Path: anish.jhaveri@paviliondata.com
List-ID: <linux-block@vger.kernel.org>


On Tue, Sep 12, 2017 at 08:48:58AM -0700, James Smart wrote:
> I don't know this is a good idea - just because there's a controller reset
> we need to failover a path ? Also putting failover smarts in the transport
> doesn't seem like a great idea. Also, there's more than just an rdma
> transport....
> 
> -- james
>
Sorry for late reply. Configuring email client took a while.

Trigger failover from controller reset path can be removed, as
keep_alive timer failure would trigger failover.

What if target controller resets and comes back up within timeframe
that keep-alive timer gets serviced. This will lead to aborting of 
all IO request after multiple retries and retries completed within
same time frame before another keep_alive would get serviced. 
This will not trigger fail over. 
