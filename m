Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for 4.14-rc2
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20170920212928.wfzm34jajrpzmmdy@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ca8b404a-10e8-9ec1-11b0-54c765b81b61@kernel.dk>
Date: Wed, 20 Sep 2017 15:37:12 -0600
MIME-Version: 1.0
In-Reply-To: <20170920212928.wfzm34jajrpzmmdy@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/20/2017 03:29 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> a couple nvme fixes for -rc2 are below:
> 
>  - fixes for the Fibre Channel host/target to fix spec compliance
>  - allow a zero keep alive timeout
>  - make the debug printk for broken SGLs work better
>  - fix queue zeroing during initialization

Pulled, thanks.

-- 
Jens Axboe
