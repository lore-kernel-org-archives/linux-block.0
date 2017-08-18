Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58089 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750920AbdHRH42 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2017 03:56:28 -0400
Subject: Re: [PATCH 1/2] loop: always return block size in LOOP_GET_STATUS
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com,
        Ming Lei <ming.lei@redhat.com>
References: <cover.1503036471.git.osandov@fb.com>
 <9ff9b291e3e872698a040a281549c39c0637565f.1503036471.git.osandov@fb.com>
 <c54bc65f-7106-0dee-77dc-32bbaf1a3d1d@suse.de> <20170818073838.GG2459@vader>
 <3f01f907-0443-4961-d4fd-a5a3ffe8e688@suse.de> <20170818074700.GH2459@vader>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d5d61484-9aa9-5161-8abf-cce924521df1@suse.de>
Date: Fri, 18 Aug 2017 09:56:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170818074700.GH2459@vader>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/18/2017 09:47 AM, Omar Sandoval wrote:
> On Fri, Aug 18, 2017 at 09:43:19AM +0200, Hannes Reinecke wrote:
>> On 08/18/2017 09:38 AM, Omar Sandoval wrote:
>>> On Fri, Aug 18, 2017 at 09:18:52AM +0200, Hannes Reinecke wrote:
[ .. ]
>>>> I've got quite some flak for daring to break existing interfaces, most
>>>> notably setting logical and physical blocksize per default (which I
>>>> would _love_ to have done, seeing that it really makes sense here).
>>>> But as this would change the behaviour I've gone through pains (and
>>>> several _years_ of iterations) to get this sorted.
>>>>
>>>> So if you  design a blocktest for that ensure that
>>>> a) the sysfs attributes before and after the patch are _identical_
>>>> b) the sysfs attributes will only change if the 'LO_FLAGS_BLOCKSIZE'
>>>> flag has been set
>>>> and
>>>> c) validate the written blocksizes; this is required to be able to
>>>> install bootloaders there
>>>>
>>>> This whole interface was designed such that you can prepare bootable
>>>> diskimages for S/390 DASDs, which use a native 4k blocksize.
>>>
>>> Hi, Hannes,
>>>
>>> Wasn't insulting you at all, the only part of the interface I'm
>>> complaining about is LOOP_GET_STATUS missing information :)
>>>
>> Sure. Just saying.
>> But please make sure only to return that information if the
>> LO_FLAGS_BLOCKSIZE flag is set; otherwise there's a rick of confusing
>> losetup.
> 
> I actually checked losetup, it works just fine with LO_FLAGS_BLOCKSIZE
> always set and lo_init[0] always filled in.
> 
The original argument I had with the util-linux maintainer did not
revolve so much around technical details :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
