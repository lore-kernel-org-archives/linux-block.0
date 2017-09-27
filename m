Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] bcache: use llist_for_each_entry_safe() in
 __closure_wake_up()
To: Coly Li <i@coly.li>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20170926095412.74028-1-colyli@suse.de>
 <20170926095412.74028-2-colyli@suse.de>
 <4c14e77e-577f-b7b7-d63a-b4b3a4d9e757@coly.li>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5986f13b-013d-5252-fc70-51dcd40e7335@kernel.dk>
Date: Wed, 27 Sep 2017 22:27:47 +0200
MIME-Version: 1.0
In-Reply-To: <4c14e77e-577f-b7b7-d63a-b4b3a4d9e757@coly.li>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/27/2017 09:16 PM, Coly Li wrote:
> Hi Jens,
> 
> Could you please take a look on this patch? It will be helpful if we can
> have it in 4.14, then we can fix a bug introduced in 4.14-rc1.
> 
> This patch is reported by Michael Lyle, reviewed by Byungchul Park, and
> finally verified by Michael Lyle after I posted the patch.

It looks fine to me, I'll get it queued up. BTW, it's technically
a use-after-free bug, not a race condition.

-- 
Jens Axboe
