Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 3 Mar 2017 11:23:25 -0800
From: Tejun Heo <tj@kernel.org>
To: Tahsin Erdogan <tahsin@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blkcg: allocate struct blkcg_gq outside request queue
 spinlock
Message-ID: <20170303192325.GB22962@wtj.duckdns.org>
References: <20170301165501.GB3662@htj.duckdns.org>
 <20170301234319.29584-1-tahsin@google.com>
 <20170302193205.GB8519@wtj.duckdns.org>
 <CAAeU0aO5hD8DHKOyGmskK5icCqf5U8hdMEZSfn6eLcHeL-YH7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAAeU0aO5hD8DHKOyGmskK5icCqf5U8hdMEZSfn6eLcHeL-YH7g@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Tahsin.

On Thu, Mar 02, 2017 at 02:33:11PM -0800, Tahsin Erdogan wrote:
> > And let blkg_create() verify these conditions after releasing and
> > regrabbing the lock.
> >
> > This also means that the init path can simply pass in GFP_KERNEL.
> 
> I tried that approach, but I encountered two issues that complicate things:
> 
> 1) Pushing down blk_queue_bypass(q) check in blkg_create() doesn't
> quite work because when blkcg_init_queue() calls blkg_create(), the
> queue is still in bypassing mode.
>
> 2) Pushing down blkcg_policy_enabled() doesn't work well either,
> because blkcg_init_queue() doesn't have a policy to pass down. We
> could let it pass a NULL parameter but that would make blkg_create
> more ugly.

I see.  It kinda really bothers me that we'll have two different modes
for non-atomic allocations.  Can't we bind both to the policy
parameter?  Skip the checks if policy is NULL?

Thanks.

-- 
tejun
