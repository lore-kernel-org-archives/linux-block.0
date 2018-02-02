Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 16/24] ibnbd: client: main functionality
To: Roman Pen <roman.penyaev@profitbricks.com>, linux-block@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Or Gerlitz <ogerlitz@mellanox.com>,
 Danil Kipnis <danil.kipnis@profitbricks.com>,
 Jack Wang <jinpu.wang@profitbricks.com>
References: <20180202140904.2017-1-roman.penyaev@profitbricks.com>
 <20180202140904.2017-17-roman.penyaev@profitbricks.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4f5c5941-c30f-51e8-619a-c03aa9e514b7@kernel.dk>
Date: Fri, 2 Feb 2018 08:11:53 -0700
MIME-Version: 1.0
In-Reply-To: <20180202140904.2017-17-roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/2/18 7:08 AM, Roman Pen wrote:
> This is main functionality of ibnbd-client module, which provides
> interface to map remote device as local block device /dev/ibnbd<N>
> and feeds IBTRS with IO requests.

Kill the legacy IO path for this, the driver should only support
blk-mq. Hence kill off your BLK_RQ part, that will eliminate
the dual path you have too.

-- 
Jens Axboe
