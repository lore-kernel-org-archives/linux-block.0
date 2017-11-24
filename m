Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for Linux 4.15
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20171123144438.wfs2fo64l6vwgfxj@infradead.org>
 <514cf7e6-f651-112e-c8bb-e5ad837d4394@kernel.dk>
 <1dcadbce-8a97-9578-686a-c43bd8dc06fc@kernel.dk>
 <20171124083259.GA10952@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1e686d99-ca88-cb56-4b5e-de1642395bb6@kernel.dk>
Date: Fri, 24 Nov 2017 10:15:07 -0700
MIME-Version: 1.0
In-Reply-To: <20171124083259.GA10952@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/24/2017 01:32 AM, Christoph Hellwig wrote:
> On Thu, Nov 23, 2017 at 10:04:55PM -0700, Jens Axboe wrote:
>>> +       NVME_FC_Q_LIVE = (1 << 1),                                              
>>> }; 
>>>
>>> for flags that are used with set_bit() and friends? That's just
>>> misleading, should be 0, 1, etc, not a shift.
>>>
>>> The rest looks pretty straight forward, but the above is an eye sore.
> 
> Yes, it is misleading, but so far harmless.

Yeah, but it just takes a few more bits...

> Your fixup looks good to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks, I've added it.

-- 
Jens Axboe
