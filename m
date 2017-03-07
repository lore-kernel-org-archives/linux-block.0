Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752532AbdCGLeR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Mar 2017 06:34:17 -0500
Subject: Re: [PATCH] zram: set physical queue limits to avoid array out of
 bounds accesses
To: Minchan Kim <minchan@kernel.org>
References: <20170306102335.9180-1-jthumshirn@suse.de>
 <20170307052242.GA29458@bbox> <95c31a93-32cd-ad06-6cc0-e11b42ec2f68@suse.de>
 <CAEwNFnAb4x+sm6=vWd1W4Xj7Snp1V_LtRRx9ORFKpm1b-58kyw@mail.gmail.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@fb.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        yizhan@redhat.com,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ed4d83a1-9bdd-9e24-7768-ba5e85429110@suse.de>
Date: Tue, 7 Mar 2017 08:48:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAEwNFnAb4x+sm6=vWd1W4Xj7Snp1V_LtRRx9ORFKpm1b-58kyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/07/2017 08:23 AM, Minchan Kim wrote:
> Hi Hannes,
> 
> On Tue, Mar 7, 2017 at 4:00 PM, Hannes Reinecke <hare@suse.de> wrote:
>> On 03/07/2017 06:22 AM, Minchan Kim wrote:
>>> Hello Johannes,
>>>
>>> On Mon, Mar 06, 2017 at 11:23:35AM +0100, Johannes Thumshirn wrote:
>>>> zram can handle at most SECTORS_PER_PAGE sectors in a bio's bvec. When using
>>>> the NVMe over Fabrics loopback target which potentially sends a huge bulk of
>>>> pages attached to the bio's bvec this results in a kernel panic because of
>>>> array out of bounds accesses in zram_decompress_page().
>>>
>>> First of all, thanks for the report and fix up!
>>> Unfortunately, I'm not familiar with that interface of block layer.
>>>
>>> It seems this is a material for stable so I want to understand it clear.
>>> Could you say more specific things to educate me?
>>>
>>> What scenario/When/How it is problem?  It will help for me to understand!
>>>
> 
> Thanks for the quick response!
> 
>> The problem is that zram as it currently stands can only handle bios
>> where each bvec contains a single page (or, to be precise, a chunk of
>> data with a length of a page).
> 
> Right.
> 
>>
>> This is not an automatic guarantee from the block layer (who is free to
>> send us bios with arbitrary-sized bvecs), so we need to set the queue
>> limits to ensure that.
> 
> What does it mean "bios with arbitrary-sized bvecs"?
> What kinds of scenario is it used/useful?
> 
Each bio contains a list of bvecs, each of which points to a specific
memory area:

struct bio_vec {
	struct page	*bv_page;
	unsigned int	bv_len;
	unsigned int	bv_offset;
};

The trick now is that while 'bv_page' does point to a page, the memory
area pointed to might in fact be contiguous (if several pages are
adjacent). Hence we might be getting a bio_vec where bv_len is _larger_
than a page.

Hence the check for 'is_partial_io' in zram_drv.c (which just does a
test 'if bv_len != PAGE_SIZE) is in fact wrong, as it would trigger for
partial I/O (ie if the overall length of the bio_vec is _smaller_ than a
page), but also for multipage bvecs (where the length of the bio_vec is
_larger_ than a page).

So rather than fixing the bio scanning loop in zram it's easier to set
the queue limits correctly so that 'is_partial_io' does the correct
thing and the overall logic in zram doesn't need to be altered.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
