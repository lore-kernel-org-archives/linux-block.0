Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: note about cloned bios and
 bio_for_each_segment_all
To: Filipe Manana <fdmanana@suse.com>, dsterba@suse.cz,
 Ming Lei <tom.leiming@gmail.com>
Cc: Liu Bo <bo.li.liu@oracle.com>, linux-block <linux-block@vger.kernel.org>
References: <20170714134051.22756-1-dsterba@suse.com>
 <CACVXFVP_a5kofmW-Wfx1FT_kyqFKdatf57RfKLrh+Jte1J8ZmA@mail.gmail.com>
 <20170714150313.GJ2866@suse.cz>
 <21cf4261-70b4-f7ee-5db3-9aece0e18a41@suse.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d10886f1-87b5-eff3-c1fa-99cb2d9407b2@kernel.dk>
Date: Fri, 14 Jul 2017 12:19:46 -0600
MIME-Version: 1.0
In-Reply-To: <21cf4261-70b4-f7ee-5db3-9aece0e18a41@suse.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/14/2017 11:56 AM, Filipe Manana wrote:
> 
> 
> On 07/14/2017 04:03 PM, David Sterba wrote:
>> On Fri, Jul 14, 2017 at 09:47:30PM +0800, Ming Lei wrote:
>>> On Fri, Jul 14, 2017 at 9:40 PM, David Sterba <dsterba@suse.com> wrote:
>>>> We've switched to cloned bios in btrfs and hit a nasty bug leading to
>>>> corruptions, when cloned bios are iterated by bio_for_each_segment_all.
>>>
>>> No, you simply can't use bio_for_each_segment_all on cloned bio, and the
>>> reason is obviously.
>>
>> This was not obvious to us, speaking for the btrfs developers trying to
>> make more use of the of the bio API, so we had to find out the hard way.
> 
> Yep, it might be obvious to those familiar with the block layer's
> internals, but for those not so familiar, it's not. There's no mention
> in bio_clone_fast() that the cloned bio's bi_vcnt shouldn't be used,
> and after finding that, one has to check which bio APIs use it and
> which don't. In this specific btrfs issue, it lead to silent write
> corruptions, making it harder to find (as opposed to crashes or other
> immediate failures).

It's hard to circulate info like that, but the WARN_ON() should have
been there from the get-go. I just need someone to test that patch
triggers for the problematic case, then I'd be happy to get it queued
up.

-- 
Jens Axboe
