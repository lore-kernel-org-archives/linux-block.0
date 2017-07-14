Return-Path: <linux-block-owner@vger.kernel.org>
Received: from prv3-mh.provo.novell.com ([137.65.250.26]:47174 "EHLO
        prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbdGNR47 (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Fri, 14 Jul 2017 13:56:59 -0400
Subject: Re: [PATCH] block: note about cloned bios and
 bio_for_each_segment_all
To: dsterba@suse.cz, Ming Lei <tom.leiming@gmail.com>
Cc: Liu Bo <bo.li.liu@oracle.com>,
        linux-block <linux-block@vger.kernel.org>
References: <20170714134051.22756-1-dsterba@suse.com>
 <CACVXFVP_a5kofmW-Wfx1FT_kyqFKdatf57RfKLrh+Jte1J8ZmA@mail.gmail.com>
 <20170714150313.GJ2866@suse.cz>
From: Filipe Manana <fdmanana@suse.com>
Message-ID: <21cf4261-70b4-f7ee-5db3-9aece0e18a41@suse.com>
Date: Fri, 14 Jul 2017 18:56:44 +0100
MIME-Version: 1.0
In-Reply-To: <20170714150313.GJ2866@suse.cz>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 07/14/2017 04:03 PM, David Sterba wrote:
> On Fri, Jul 14, 2017 at 09:47:30PM +0800, Ming Lei wrote:
>> On Fri, Jul 14, 2017 at 9:40 PM, David Sterba <dsterba@suse.com> wrote:
>>> We've switched to cloned bios in btrfs and hit a nasty bug leading to
>>> corruptions, when cloned bios are iterated by bio_for_each_segment_all.
>>
>> No, you simply can't use bio_for_each_segment_all on cloned bio, and the
>> reason is obviously.
> 
> This was not obvious to us, speaking for the btrfs developers trying to
> make more use of the of the bio API, so we had to find out the hard way.

Yep, it might be obvious to those familiar with the block layer's
internals, but for those not so familiar, it's not. There's no mention
in bio_clone_fast() that the cloned bio's bi_vcnt shouldn't be used, and
after finding that, one has to check which bio APIs use it and which
don't. In this specific btrfs issue, it lead to silent write
corruptions, making it harder to find (as opposed to crashes or other
immediate failures).

> 
> The proposed WARN_ON, possibly more sanity checks or documentation would
> help us not to trip over similar problems in the future. I try to take
> great care when dealing with code changing bios on our side so I read
> the headers, and partially the implementation, but still can miss
> something.
> 
