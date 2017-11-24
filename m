Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for Linux 4.15
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20171123144438.wfs2fo64l6vwgfxj@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <514cf7e6-f651-112e-c8bb-e5ad837d4394@kernel.dk>
Date: Thu, 23 Nov 2017 21:54:33 -0700
MIME-Version: 1.0
In-Reply-To: <20171123144438.wfs2fo64l6vwgfxj@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/23/2017 07:44 AM, Christoph Hellwig wrote:
> Sagi Grimberg (3):
>       nvme-fc: check if queue is ready in queue_rq
>       nvme-loop: check if queue is ready in queue_rq

The nvme-loop part looks fine, but why is the nvme-fc part using:

enum nvme_fc_queue_flags {                                                     
        NVME_FC_Q_CONNECTED = (1 << 0),                                         
+       NVME_FC_Q_LIVE = (1 << 1),                                              
}; 

for flags that are used with set_bit() and friends? That's just
misleading, should be 0, 1, etc, not a shift.

The rest looks pretty straight forward, but the above is an eye sore.

-- 
Jens Axboe
