Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for 4.20
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20181109065654.GA12805@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6b8d8562-a31d-bf11-557b-7f33a17d6e60@kernel.dk>
Date: Fri, 9 Nov 2018 06:16:09 -0700
MIME-Version: 1.0
In-Reply-To: <20181109065654.GA12805@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/8/18 11:56 PM, Christoph Hellwig wrote:
>  - revert an RDMA commit that didn't help but caused problems
>  - fix another minor P2P fallout
>  - make sure the multipath device inherits the devices limits of
>    the controllers below
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.20

This is based on 4.20-rc1 for some reason, not my for-linus. So I get
a few thousand extra commits... I pulled the patches and applied
manually.

-- 
Jens Axboe
