Return-Path: <linux-block-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:52576 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeDMAih (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Apr 2018 20:38:37 -0400
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        shawn.lin@rock-chips.com
Subject: Re: System hung in I/O when booting with sd card
To: Bart Van Assche <Bart.VanAssche@wdc.com>
References: <3ba451a8-ac7b-429a-4a1b-703ea38136ce@rock-chips.com>
 <5496fc576b733fd7a77eb78ef938bc661d3b11af.camel@wdc.com>
 <6ac49021-644b-edc1-4c8a-82edbeaad0bd@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <4993d486-0970-bf41-ab8d-c02925361d41@rock-chips.com>
Date: Fri, 13 Apr 2018 08:38:37 +0800
MIME-Version: 1.0
In-Reply-To: <6ac49021-644b-edc1-4c8a-82edbeaad0bd@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Bart,

On 2018/4/12 17:05, Shawn Lin wrote:
> Hi Bart,
> 
> On 2018/4/12 9:54, Bart Van Assche wrote:
>> On Thu, 2018-04-12 at 09:48 +0800, Shawn Lin wrote:
>>> I ran into 2 times that my system hung here when booting with a ext4 sd
>>> card. No sure how to reproduce it but it seems doesn't matter with the
>>> ext4 as I see it again with a vfat sd card, this morning with Linus'
>>> master branch. Is it a known issue or any idea how to debug this?
>>
>> Please verify whether the following patch resolves this:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-linus&id=37f9579f4c31a6d698dbf3016d7bf132f9288d30 
>>
> 
> Thanks for your patch! I set up some devices to test reboot this morning
> against Linus' master branch. Two devices out of 5, were already hang
> for that without your patch, but the other 5 are still work with your
> patch.
> 
> Will update the result tomorrow morning.

I think your patch solve this. Thanks.

Tested-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
>>
>> Thanks,
>>
>> Bart.
>>
>>
>>
>>
> 
> 
> 
