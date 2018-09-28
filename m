Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for 4.19
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20180928154003.GA3163@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ad779853-fa07-698f-97aa-2db33aa77d8a@kernel.dk>
Date: Fri, 28 Sep 2018 09:42:32 -0600
MIME-Version: 1.0
In-Reply-To: <20180928154003.GA3163@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/28/18 9:40 AM, Christoph Hellwig wrote:
> The following changes since commit b228ba1cb95afbaeeb86cf06cd9fd6f6369c3b14:
> 
>   null_blk: fix zoned support for non-rq based operation (2018-09-12 18:21:11 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.19
> 
> for you to fetch changes up to bb830add192e9d8338082c0fc2c209e23b43d865:
> 
>   nvme: properly propagate errors in nvme_mpath_init (2018-09-25 16:21:40 -0700)
> 
> ----------------------------------------------------------------
> Hannes Reinecke (1):
>       nvme: count all ANA groups for ANA Log page

This one I already pulled a while back, only this one:

> Susobhan Dey (1):
>       nvme: properly propagate errors in nvme_mpath_init
is new.

-- 
Jens Axboe
