Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:37425 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753543AbdCGJKs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2017 04:10:48 -0500
Date: Tue, 7 Mar 2017 17:55:45 +0900
From: Minchan Kim <minchan@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@fb.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        yizhan@redhat.com,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zram: set physical queue limits to avoid array out of
 bounds accesses
Message-ID: <20170307085545.GA538@bbox>
References: <20170306102335.9180-1-jthumshirn@suse.de>
 <20170307052242.GA29458@bbox>
 <95c31a93-32cd-ad06-6cc0-e11b42ec2f68@suse.de>
 <CAEwNFnAb4x+sm6=vWd1W4Xj7Snp1V_LtRRx9ORFKpm1b-58kyw@mail.gmail.com>
 <ed4d83a1-9bdd-9e24-7768-ba5e85429110@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ed4d83a1-9bdd-9e24-7768-ba5e85429110@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Mar 07, 2017 at 08:48:06AM +0100, Hannes Reinecke wrote:
> On 03/07/2017 08:23 AM, Minchan Kim wrote:
> > Hi Hannes,
> > 
> > On Tue, Mar 7, 2017 at 4:00 PM, Hannes Reinecke <hare@suse.de> wrote:
> >> On 03/07/2017 06:22 AM, Minchan Kim wrote:
> >>> Hello Johannes,
> >>>
> >>> On Mon, Mar 06, 2017 at 11:23:35AM +0100, Johannes Thumshirn wrote:
> >>>> zram can handle at most SECTORS_PER_PAGE sectors in a bio's bvec. When using
> >>>> the NVMe over Fabrics loopback target which potentially sends a huge bulk of
> >>>> pages attached to the bio's bvec this results in a kernel panic because of
> >>>> array out of bounds accesses in zram_decompress_page().
> >>>
> >>> First of all, thanks for the report and fix up!
> >>> Unfortunately, I'm not familiar with that interface of block layer.
> >>>
> >>> It seems this is a material for stable so I want to understand it clear.
> >>> Could you say more specific things to educate me?
> >>>
> >>> What scenario/When/How it is problem?  It will help for me to understand!
> >>>
> > 
> > Thanks for the quick response!
> > 
> >> The problem is that zram as it currently stands can only handle bios
> >> where each bvec contains a single page (or, to be precise, a chunk of
> >> data with a length of a page).
> > 
> > Right.
> > 
> >>
> >> This is not an automatic guarantee from the block layer (who is free to
> >> send us bios with arbitrary-sized bvecs), so we need to set the queue
> >> limits to ensure that.
> > 
> > What does it mean "bios with arbitrary-sized bvecs"?
> > What kinds of scenario is it used/useful?
> > 
> Each bio contains a list of bvecs, each of which points to a specific
> memory area:
> 
> struct bio_vec {
> 	struct page	*bv_page;
> 	unsigned int	bv_len;
> 	unsigned int	bv_offset;
> };
> 
> The trick now is that while 'bv_page' does point to a page, the memory
> area pointed to might in fact be contiguous (if several pages are
> adjacent). Hence we might be getting a bio_vec where bv_len is _larger_
> than a page.

Thanks for detail, Hannes!

If I understand it correctly, it seems to be related to bid_add_page
with high-order page. Right?

If so, I really wonder why I don't see such problem because several
places have used it and I expected some of them might do IO with
contiguous pages intentionally or by chance. Hmm,

IIUC, it's not a nvme specific problme but general problem which
can trigger normal FSes if they uses contiguos pages?

> 
> Hence the check for 'is_partial_io' in zram_drv.c (which just does a
> test 'if bv_len != PAGE_SIZE) is in fact wrong, as it would trigger for
> partial I/O (ie if the overall length of the bio_vec is _smaller_ than a
> page), but also for multipage bvecs (where the length of the bio_vec is
> _larger_ than a page).

Right. I need to look into that. Thanks for the pointing out!

> 
> So rather than fixing the bio scanning loop in zram it's easier to set
> the queue limits correctly so that 'is_partial_io' does the correct
> thing and the overall logic in zram doesn't need to be altered.


Isn't that approach require new bio allocation through blk_queue_split?
Maybe, it wouldn't make severe regression in zram-FS workload but need
to test.

Is there any ways to trigger the problem without real nvme device?
It would really help to test/measure zram.

Anyway, to me, it's really subtle at this moment so I doubt it should
be stable material. :(
