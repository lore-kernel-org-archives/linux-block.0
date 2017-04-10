Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:32773 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbdDJRrd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2017 13:47:33 -0400
Received: by mail-lf0-f45.google.com with SMTP id h125so74721174lfe.0
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2017 10:47:32 -0700 (PDT)
Subject: Re: [PATCH v3] lightnvm: physical block device (pblk) target
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
        "jg@lightnvm.io" <jg@lightnvm.io>
References: <1491591015-7554-1-git-send-email-javier@cnexlabs.com>
 <1491591015-7554-2-git-send-email-javier@cnexlabs.com>
 <CY1PR0401MB1536AD7F70C960D62DCA6983810F0@CY1PR0401MB1536.namprd04.prod.outlook.com>
 <E42A544D-D09C-4DDB-800A-9FCED4CBBD28@lightnvm.io>
 <1491839741.4199.7.camel@sandisk.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <7f8a2c0c-8a06-1036-164f-168924ec2a3f@lightnvm.io>
Date: Mon, 10 Apr 2017 19:47:08 +0200
MIME-Version: 1.0
In-Reply-To: <1491839741.4199.7.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/10/2017 05:55 PM, Bart Van Assche wrote:
> On Sun, 2017-04-09 at 11:15 +0200, Javier Gonz�lez wrote:
>> On 8 Apr 2017, at 22.56, Bart Van Assche <bart.vanassche@sandisk.com> wrote:
>>> On 04/07/17 11:50, Javier Gonz�lez wrote:
>> struct ppa_addr, which is the physical address format is not affected,
>> but pblk's internal L2P address representation (pblk_addr) is. You can
>> see that the type either represents struct ppa_addr or ppa_addr_32. How
>> would you define a type that can either be u64 or u32 with different bit
>> offsets at run-time? Note that address conversions to this type is in
>> the fast path and this format allows us to only use bit shifts.
>
> Selecting the appropriate representation at run-time would require to pass
> pblk_addr by reference instead of by value to any function that expects a
> pblk_addr. It would also require to have two versions of every data structure
> that depends on pblk_addr and to use casts to convert to the appropritate
> version. However, this approach is probably only worth to be implemented if
> it doesn't introduce too much additional complexity.
>

Hi Bart, thanks for the feedback!

I've spent the time today to implement it such that 32bit entries are 
used if the device addressing can fit. We do see a slight overhead, 
however not enough to be a deal-breaker. We'll post an updated version 
with the flag removed.

>>>> +#ifdef CONFIG_NVM_DEBUG
>>>> +	atomic_add(nr_entries, &pblk->inflight_writes);
>>>> +	atomic_add(nr_entries, &pblk->req_writes);
>>>> +#endif
>>>
>>> Has it been considered to use the "static key" feature such that
>>> consistency checks can be enabled at run-time instead of having to
>>> rebuild the kernel to enable CONFIG_NVM_DEBUG?
>>
>> I haven't considered it. I'll look into it. I would like to have this
>> counters and the corresponding sysfs entry only available on debug mode
>> since it allows us to have a good picture of the FTL state.
>
> If there are sysfs entries that depend on CONFIG_NVM_DEBUG then the static
> key mechanism is probably not a good alternative for CONFIG_NVM_DEBUG.
>
>>> Has it been considered to add support for keeping a subset of the L2P
>>> translation table in memory instead of keeping it in memory in its entirety?
>>
>> Yes. L2P caching is on our roadmap and will be included in the future.
>
> That's great. This will also help with reducing the time between discovery of
> a lightnvm device and the time at which I/O can start since the L2P table must
> be available before I/O can start.

Definitely. I would love if one could jump in and implement it. We have 
a bunch of features that we want in before implementing a translation cache.
>
> Bart.
>
