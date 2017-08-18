Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57370 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750923AbdHRHnV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2017 03:43:21 -0400
Subject: Re: [PATCH 1/2] loop: always return block size in LOOP_GET_STATUS
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com,
        Ming Lei <ming.lei@redhat.com>
References: <cover.1503036471.git.osandov@fb.com>
 <9ff9b291e3e872698a040a281549c39c0637565f.1503036471.git.osandov@fb.com>
 <c54bc65f-7106-0dee-77dc-32bbaf1a3d1d@suse.de> <20170818073838.GG2459@vader>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3f01f907-0443-4961-d4fd-a5a3ffe8e688@suse.de>
Date: Fri, 18 Aug 2017 09:43:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170818073838.GG2459@vader>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/18/2017 09:38 AM, Omar Sandoval wrote:
> On Fri, Aug 18, 2017 at 09:18:52AM +0200, Hannes Reinecke wrote:
>> On 08/18/2017 08:15 AM, Omar Sandoval wrote:
>>> From: Omar Sandoval <osandov@fb.com>
>>>
>>> When I was writing a test for the new loop device block size
>>> functionality, I realized that the interface is kind of dumb:
>>>
>>> - lo_init[0] is never filled in with the logical block size we
>>>   previously set
>>> - lo_flags returned from LOOP_GET_STATUS will have LO_FLAGS_BLOCKSIZE
>>>   set if we previously called LOOP_SET_STATUS with LO_FLAGS_BLOCKSIZE
>>>   set, which doesn't really mean anything
>>>
>>> Instead, for LOOP_GET_STATUS, let's always fill in lo_init[0] and set
>>> the LO_FLAGS_BLOCKSIZE flag to indicate we support it.
>>>
>>> Signed-off-by: Omar Sandoval <osandov@fb.com>
>>> ---
>>>  drivers/block/loop.c | 33 +++++++++++++++++----------------
>>>  1 file changed, 17 insertions(+), 16 deletions(-)
>>>
>> Phew. 'Dumb interface'.
>> 'tis wasn't me who designed the interface;
>> Backwards compability are the watchwords here.
>> Personally, I would have loved to design a new interface.
>>
>> I've got quite some flak for daring to break existing interfaces, most
>> notably setting logical and physical blocksize per default (which I
>> would _love_ to have done, seeing that it really makes sense here).
>> But as this would change the behaviour I've gone through pains (and
>> several _years_ of iterations) to get this sorted.
>>
>> So if you  design a blocktest for that ensure that
>> a) the sysfs attributes before and after the patch are _identical_
>> b) the sysfs attributes will only change if the 'LO_FLAGS_BLOCKSIZE'
>> flag has been set
>> and
>> c) validate the written blocksizes; this is required to be able to
>> install bootloaders there
>>
>> This whole interface was designed such that you can prepare bootable
>> diskimages for S/390 DASDs, which use a native 4k blocksize.
> 
> Hi, Hannes,
> 
> Wasn't insulting you at all, the only part of the interface I'm
> complaining about is LOOP_GET_STATUS missing information :)
> 
Sure. Just saying.
But please make sure only to return that information if the
LO_FLAGS_BLOCKSIZE flag is set; otherwise there's a rick of confusing
losetup.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
