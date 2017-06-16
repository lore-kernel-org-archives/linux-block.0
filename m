Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] NVMe updates for Linux 4.13
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20170616161118.a3h2vc5inincfrmq@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2d0ccf31-79b2-4b19-d44f-e8984cea6f55@kernel.dk>
Date: Fri, 16 Jun 2017 10:16:29 -0600
MIME-Version: 1.0
In-Reply-To: <20170616161118.a3h2vc5inincfrmq@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/16/2017 10:11 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> here is a large chunk of NVMe updates for 4.13.  I don't think we
> are quite done for this merge window yet, but I'd like to get
> this large batch into your tree and linux-next.
> 
> Highlights:
> 
>  - UUID identifier support from Johannes
>  - Lots of cleanups from Sagi
>  - Host Memory Buffer support from me
> 
> And lots of cleanups and smaller fixes of course.
> 
> Note that the UUID identifier changes are based on top of the uuid tree.
> I am the maintainer of that tree and will send it to Linus as soon as
> 4.12 is released as various other trees depend on it as well (and the
> diffstat includes those changes unfortunately)

Pulled in, thanks.

-- 
Jens Axboe
