Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for 4.18
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20180726141640.GA7156@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a98e6d60-68ff-c044-2b68-364d1e3a3aed@kernel.dk>
Date: Thu, 26 Jul 2018 10:49:25 -0700
MIME-Version: 1.0
In-Reply-To: <20180726141640.GA7156@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/26/18 7:16 AM, Christoph Hellwig wrote:
> Two small fixes each for the FC code and the target.
> 
> 
> The following changes since commit 8f3ea35929a0806ad1397db99a89ffee0140822a:
> 
>   nbd: handle unexpected replies better (2018-07-16 10:14:40 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.18
> 
> for you to fetch changes up to 405a7519607e7a364114896264440c0f87b325c0:
> 
>   nvmet: only check for filebacking on -ENOTBLK (2018-07-25 13:14:04 +0200)
> 
> ----------------------------------------------------------------
> Hannes Reinecke (2):
>       nvmet: fixup crash on NULL device path
>       nvmet: only check for filebacking on -ENOTBLK
> 
> James Smart (2):
>       nvmet-fc: fix target sgl list on large transfers
>       nvme: if_ready checks to fail io to deleting controller

Pulled, thanks.

-- 
Jens Axboe
