Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33886 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdCGHYb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2017 02:24:31 -0500
MIME-Version: 1.0
In-Reply-To: <95c31a93-32cd-ad06-6cc0-e11b42ec2f68@suse.de>
References: <20170306102335.9180-1-jthumshirn@suse.de> <20170307052242.GA29458@bbox>
 <95c31a93-32cd-ad06-6cc0-e11b42ec2f68@suse.de>
From: Minchan Kim <minchan@kernel.org>
Date: Tue, 7 Mar 2017 16:23:43 +0900
Message-ID: <CAEwNFnAb4x+sm6=vWd1W4Xj7Snp1V_LtRRx9ORFKpm1b-58kyw@mail.gmail.com>
Subject: Re: [PATCH] zram: set physical queue limits to avoid array out of
 bounds accesses
To: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@fb.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        yizhan@redhat.com,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Hannes,

On Tue, Mar 7, 2017 at 4:00 PM, Hannes Reinecke <hare@suse.de> wrote:
> On 03/07/2017 06:22 AM, Minchan Kim wrote:
>> Hello Johannes,
>>
>> On Mon, Mar 06, 2017 at 11:23:35AM +0100, Johannes Thumshirn wrote:
>>> zram can handle at most SECTORS_PER_PAGE sectors in a bio's bvec. When using
>>> the NVMe over Fabrics loopback target which potentially sends a huge bulk of
>>> pages attached to the bio's bvec this results in a kernel panic because of
>>> array out of bounds accesses in zram_decompress_page().
>>
>> First of all, thanks for the report and fix up!
>> Unfortunately, I'm not familiar with that interface of block layer.
>>
>> It seems this is a material for stable so I want to understand it clear.
>> Could you say more specific things to educate me?
>>
>> What scenario/When/How it is problem?  It will help for me to understand!
>>

Thanks for the quick response!

> The problem is that zram as it currently stands can only handle bios
> where each bvec contains a single page (or, to be precise, a chunk of
> data with a length of a page).

Right.

>
> This is not an automatic guarantee from the block layer (who is free to
> send us bios with arbitrary-sized bvecs), so we need to set the queue
> limits to ensure that.

What does it mean "bios with arbitrary-sized bvecs"?
What kinds of scenario is it used/useful?

And how can we solve it by setting queue limit?

Sorry for the many questions due to limited knowledge.

Thanks.
