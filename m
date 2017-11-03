Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme updates for Linux 4.15
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20171103121703.kupyb5rvuyvaevsr@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1b8f7a21-af73-d1d6-200e-a4f6b8fdd3a1@kernel.dk>
Date: Fri, 3 Nov 2017 10:29:54 -0600
MIME-Version: 1.0
In-Reply-To: <20171103121703.kupyb5rvuyvaevsr@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/03/2017 06:17 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> below are the currently queue nvme updates for Linux 4.15.  There are
> a few more things that could make it for this merge window, but I'd
> like to get things into linux-next, especially for the unlikely case
> that Linus decided to cut -rc8.
> 
> Highlights:
>  - support for SGLs in the PCIe driver (Chaitanya Kulkarni)
>  - disable I/O schedulers for the admin queue (Israel Rukshin)
>  - various Fibre Channel fixes and enhancements (James Smart)
>  - various refactoring for better code sharing between transports
>    (Sagi Grimberg and me)
> 
> as well as lots of little bits from various contributors.

Pulled, thanks.

-- 
Jens Axboe
