Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH rfc 5/6] block: Add rdma affinity based queue mapping
 helper
To: Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <1491140492-25703-1-git-send-email-sagi@grimberg.me>
 <1491140492-25703-6-git-send-email-sagi@grimberg.me>
Cc: netdev@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>,
 Or Gerlitz <ogerlitz@mellanox.com>, Christoph Hellwig <hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ce263274-d814-6167-42a3-5d3cad170f18@kernel.dk>
Date: Wed, 5 Apr 2017 08:17:05 -0600
MIME-Version: 1.0
In-Reply-To: <1491140492-25703-6-git-send-email-sagi@grimberg.me>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/02/2017 07:41 AM, Sagi Grimberg wrote:
> Like pci and virtio, we add a rdma helper for affinity
> spreading. This achieves optimal mq affinity assignments
> according to the underlying rdma device affinity maps.

Reviewed-by: Jens Axboe <axboe@fb.com>

-- 
Jens Axboe
