Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail02.iobjects.de ([188.40.134.68]:47736 "EHLO
	mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbcELWaE (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 12 May 2016 18:30:04 -0400
Subject: Re: [PATCH] loop: properly observe rotational flag of underlying
 device
To: gwendal grignou <gwendal@chromium.org>,
	linux-kernel@vger.kernel.org
References: <56435D0F.80006@googlemail.com> <5643B341.9010600@fb.com>
 <5643BC5E.8060701@googlemail.com> <569438BB.6050009@googlemail.com>
 <loom.20160511T213516-51@post.gmane.org>
Cc: linux-block@vger.kernel.org
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Message-ID: <573503E8.8040201@applied-asynchrony.com>
Date: Fri, 13 May 2016 00:30:00 +0200
MIME-Version: 1.0
In-Reply-To: <loom.20160511T213516-51@post.gmane.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

[cc: linux-block]

On 05/12/16 22:28, gwendal grignou wrote:
> Holger Hoffstätte <holger.hoffstaette <at> googlemail.com> writes:
> 
>>
>> On 11/11/15 23:08, Holger Hoffstätte wrote:
>>> On 11/11/15 22:29, Jens Axboe wrote:
>>>> On 11/11/2015 08:21 AM, Holger Hoffstätte wrote:
>>>>>
>>>>> The loop driver always declares the rotational flag of its device as
>>>>> rotational, even when the device of the mapped file is nonrotational,
>>>>> as is the case with SSDs or on tmpfs. This can confuse filesystem 
> tools
>>>>> which are SSD-aware; in my case I frequently forget to tell 
> mkfs.btrfs
>>>>> that my loop device on tmpfs is nonrotational, and that I really 
> don't
>>>>> need any automatic metadata redundancy.
>>>>>
>>>>> The attached patch fixes this by introspecting the rotational flag of 
> the
>>>>> mapped file's underlying block device, if it exists. If the mapped 
> file's
>>>>> filesystem has no associated block device - as is the case on e.g. 
> tmpfs -
>>>>> we assume nonrotational storage. If there is a better way to identify 
> such
>>>>> non-devices I'd love to hear them.
>>>>>
>>>>> Signed-off-by: Holger Hoffstätte <holger.hoffstaette <at> 
> googlemail.com>
> 
>>
>> Jens,
>>
>> I haven't seen this merged in any trees yet and was wondering if there's
>> any chance to get this into 4.5? If there's something left to fix up 
> please
>> let me know.
>>
>> Thanks,
>> Holger
>>
>>
> This patch proved useful for ureadahead: when we use it on a loop device, 
> it would use the HDD method to place the data in cache using the pack 
> information instead of the SSD method.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

I had completely forgotten about this, and apparently so had Jens. ;)
Thanks for the feedback, glad to hear it is useful.

Jens, any objections to merge this for 4.7? It should still apply
cleanly. The original patch was at: https://lkml.org/lkml/2015/11/11/288

Thanks,
Holger

