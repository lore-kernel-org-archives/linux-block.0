Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq-sched: don't run the queue async from
 blk_mq_try_issue_directly()
To: Omar Sandoval <osandov@osandov.com>
References: <3ac4f49e-3bc0-7fc6-e93a-db9ec7ad21cf@kernel.dk>
 <20170314174837.GB2352@vader.DHCP.thefacebook.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9c6575ff-cb42-ce3a-313f-87f2e197d7f1@kernel.dk>
Date: Tue, 14 Mar 2017 11:51:29 -0600
MIME-Version: 1.0
In-Reply-To: <20170314174837.GB2352@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/14/2017 11:48 AM, Omar Sandoval wrote:
> On Tue, Mar 14, 2017 at 08:57:50AM -0600, Jens Axboe wrote:
>> If we have scheduling enabled, we jump directly to insert-and-run.
>> That's fine, but we run the queue async and we don't pass in information
>> on whether we can block from this context or not. Fixup both these
>> cases.
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> 
> Just one question: we call blk_mq_get_driver_tag() with wait=false in
> blk_mq_try_issue_directly(). Should we change that to wait=can_block?
> Maybe it's pointless to try a direct issue if we'd have to wait for a
> tag anyways, though.

Exactly, don't want to wait for a tag, at that point we are just
pointlessly stalling an app that could perhaps be submitting more IO.
So I don't think we should factor that in here, better to let the
blocking vs non-blocking drivers behave the same in that regard.

-- 
Jens Axboe
