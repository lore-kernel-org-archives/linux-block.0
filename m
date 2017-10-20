Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for 4.14
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20171020131739.nffgzny5465tboba@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ca329eec-ce4c-5899-4a32-419859196a22@kernel.dk>
Date: Fri, 20 Oct 2017 09:04:42 -0500
MIME-Version: 1.0
In-Reply-To: <20171020131739.nffgzny5465tboba@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/20/2017 08:17 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> below are two regression fixes each for RDMA and FC, and a fix for a SQHD
> update race in the target.
> 
> The following changes since commit 639812a1ed9bf49ae2c026086fbf975339cd1eef:
> 
>   nbd: don't set the device size until we're connected (2017-10-09 12:29:22 -0600)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.14

Pulled, thanks.

-- 
Jens Axboe
