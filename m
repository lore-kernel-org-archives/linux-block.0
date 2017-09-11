Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for 4.14, take 2
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20170911215512.GA9661@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fdc40d9b-dd0e-68fb-66a5-5eb35b7ca2c4@kernel.dk>
Date: Mon, 11 Sep 2017 16:00:52 -0600
MIME-Version: 1.0
In-Reply-To: <20170911215512.GA9661@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/11/2017 03:55 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> below are a few small fixes for the current merge window:
> 
>  - fix string.h compilation failures with the new memcpy_and_pad
>    helper (Martin Wilck)
>  - fix incorrect dereference of a PCI data structure in the lightnvm
>    support code (me)
>  - HMB fixes (Akinobu Mita and me)
> 
> The following changes since commit 09c2c359be546df45be0b158ea1d3cc8ea83c876:
> 
>   block: fix integer overflow in __blkdev_sectors_to_bio_pages() (2017-09-11 09:46:49 -0600)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.14
> 
> for you to fetch changes up to 1359798f9d4082eb04575efdd19512fbd9c28464:
> 
>   string.h: un-fortify memcpy_and_pad (2017-09-11 12:29:41 -0400)

LGTM, pulled.

-- 
Jens Axboe
