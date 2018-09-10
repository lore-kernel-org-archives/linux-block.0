Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fix for 4.19
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20180910060230.GA27071@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b0d29a09-aa5d-2e57-5fb6-66c824975417@kernel.dk>
Date: Mon, 10 Sep 2018 08:17:56 -0600
MIME-Version: 1.0
In-Reply-To: <20180910060230.GA27071@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/10/18 12:02 AM, Christoph Hellwig wrote:
> The following changes since commit bc811f05d77f47059c197a98b6ad242eb03999cb:
> 
>   nbd: don't allow invalid blocksize settings (2018-09-04 11:54:58 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.19
> 
> for you to fetch changes up to 8407879c4e0d7731f6e7e905893cecf61a7762c7:
> 
>   nvmet-rdma: fix possible bogus dereference under heavy load (2018-09-05 12:18:01 -0700)
> 
> ----------------------------------------------------------------
> Sagi Grimberg (1):
>       nvmet-rdma: fix possible bogus dereference under heavy load

Pulled, thanks.

-- 
Jens Axboe
