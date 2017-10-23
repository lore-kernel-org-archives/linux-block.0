Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: nvme multipath support V4
To: Guan Junxiong <guanjunxiong@huawei.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <jthumshirn@suse.de>, "Shenhong (C)"
 <shenhong09@huawei.com>, niuhaoxin <niuhaoxin@huawei.com>
References: <20171018165258.23212-1-hch@lst.de>
 <fbccc0db-77cd-fabc-0225-4b515729f214@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <495580b5-2dcf-b547-4c08-8a10fa4844a1@grimberg.me>
Date: Mon, 23 Oct 2017 09:33:35 +0300
MIME-Version: 1.0
In-Reply-To: <fbccc0db-77cd-fabc-0225-4b515729f214@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Guan,

> If per-controller block device nodes are hidden, how can the user-space tools
> such as multipath-tools and nvme-cli (if it supports) know status of each path of
> the multipath device?

if at all, the path state is reflected on the controller class device
node, not on the namespace block device node. However, this is not
something user-space can rely on as well.

> In some cases, the admin wants to know which path is in down state , in degraded
> state such as suffering intermittent IO error because of shaky link and he can fix
> the link or isolate such link from the normal path.

We have a ctrl_loss_tmo that will remove such a degraded controller
after timeout expiration (default is 600 seconds). When we remove
this controller we log this information so its available for a sysadmin
to fix this if needed/desired.

What we would probably need to do, is either to add a nvme-cli "rescan"
option to discover and connect to all unconnected controllers so the
sysadmin can run after fixing an issue, or introduce a daemon that does
this every say 60 seconds or something.
