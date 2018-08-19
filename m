Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: Re: [PATCH] block: fix rdma queue mapping
To: Sagi Grimberg <sagi@grimberg.me>, <linux-block@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-nvme@lists.infradead.org>
References: <20180817223823.19566-1-sagi@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <5973cbfe-1466-cf44-c33e-d9b0dbcc9ca6@mellanox.com>
Date: Sun, 19 Aug 2018 15:45:07 +0300
MIME-Version: 1.0
In-Reply-To: <20180817223823.19566-1-sagi@grimberg.me>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Israel Rukshin <israelr@mellanox.com>,
 Steve Wise <swise@opengridcomputing.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Hi Sagi,
did you have a chance to look on Israel's and mine fixes that we 
attached to the first thread ?

there are few issues with this approach. For example in case you don't 
have a "free" cpu in the mask for Qi and you take cpu from Qi+j mask.

Also in case we have a non-symetrical affinity for 2 queues e.g. and the 
system has 32 cpus, the mapping is 16 for each (and not according to the 
user affinity...).

-Max.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
