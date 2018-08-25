Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: "Steve Wise" <swise@opengridcomputing.com>
To: "'Sagi Grimberg'" <sagi@grimberg.me>,
	"'Ming Lei'" <ming.lei@redhat.com>
References: <20180820205420.25908-1-sagi@grimberg.me>
 <20180821020434.GA24247@ming.t460p>
 <e82f994b-76ec-2a04-b575-acb4439e4d5b@grimberg.me>
In-Reply-To: <e82f994b-76ec-2a04-b575-acb4439e4d5b@grimberg.me>
Subject: RE: [PATCH v2] block: fix rdma queue mapping
Date: Sat, 25 Aug 2018 07:18:43 -0500
Message-ID: <005801d43c6d$c4afbba0$4e0f32e0$@opengridcomputing.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-rdma@vger.kernel.org, linux-block@vger.kernel.org,
 'Christoph Hellwig' <hch@lst.de>, linux-nvme@lists.infradead.org,
 'Max Gurtovoy' <maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

> > I guess this way still can't fix the request allocation crash issue
> > triggered by using blk_mq_alloc_request_hctx(), in which one hw queue
> may
> > not be mapped from any online CPU.
> 
> Not really. I guess we will need to simply skip queues that are
> mapped to an offline cpu.
> 
> > Maybe this patch isn't for this issue, but it is closely related.
> 
> Yes, another patch is still needed.
> 
> Steve, do you still have that patch? I don't seem to
> find it anywhere.

I have no such patch.  I don't remember this issue.

Steve.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
