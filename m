Return-Path: <tahsin@google.com>
MIME-Version: 1.0
In-Reply-To: <20170228224728.GJ15287@htj.duckdns.org>
References: <20170228024957.4314-1-tahsin@google.com> <20170228224728.GJ15287@htj.duckdns.org>
From: Tahsin Erdogan <tahsin@google.com>
Date: Tue, 28 Feb 2017 15:51:27 -0800
Message-ID: <CAAeU0aMMmWagAKc_nUoZj77EYiuiyhdtPZ35C4Yk6BPG-_=kxg@mail.gmail.com>
Subject: Re: [PATCH] blkcg: allocate struct blkcg_gq outside request queue spinlock
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 28, 2017 at 2:47 PM, Tejun Heo <tj@kernel.org> wrote:
>> +     if (!blkcg_policy_enabled(q, pol)) {
>> +             ret = -EOPNOTSUPP;
>> +             goto fail;
>
> Pulling this out of the queue_lock doesn't seem safe to me.  This
> function may end up calling into callbacks of disabled policies this
> way.

I will move this to within the lock. To make things safe, I am also
thinking of rechecking both blkcg_policy_enabled()  and
blk_queue_bypass() after reacquiring the locks in each iteration.

>> +             parent = blkcg_parent(blkcg);
>> +             while (parent && !__blkg_lookup(parent, q, false)) {
>> +                     pos = parent;
>> +                     parent = blkcg_parent(parent);
>> +             }
>
> Hmm... how about adding @new_blkg to blkg_lookup_create() and calling
> it with non-NULL @new_blkg until it succeeds?  Wouldn't that be
> simpler?
>
>> +
>> +             new_blkg = blkg_alloc(pos, q, GFP_KERNEL);

The challenge with that approach is creating a new_blkg with the right
blkcg before passing to blkg_lookup_create(). blkg_lookup_create()
walks down the hierarchy and will try to fill the first missing entry
and the preallocated new_blkg must have been created with the right
blkcg (feel free to send a code fragment if you think I am
misunderstanding the suggestion).
