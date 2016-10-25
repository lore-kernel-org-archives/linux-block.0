Return-Path: <linux-block-owner@vger.kernel.org>
Received: from gateway24.websitewelcome.com ([192.185.51.196]:42024 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750785AbcJYMTE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2016 08:19:04 -0400
Received: from cm1.websitewelcome.com (cm.websitewelcome.com [192.185.0.102])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 271F09CC09FF2
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2016 06:54:14 -0500 (CDT)
Date: Tue, 25 Oct 2016 05:54:09 -0600
From: Stephen Bates <sbates@raithlin.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        linux-rdma@vger.kernel.org, linux-block@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Matthew Wilcox <willy@linux.intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        haggaie@mellanox.com, Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@fb.com>, Jonathan Corbet <corbet@lwn.net>,
        jim.macdonald@everspin.com, sbates@raithin.com,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 1/3] memremap.c : Add support for ZONE_DEVICE IO memory
 with struct pages.
Message-ID: <20161025115409.GB14986@cgy1-donard.priv.deltatee.com>
References: <1476826937-20665-1-git-send-email-sbates@raithlin.com>
 <1476826937-20665-2-git-send-email-sbates@raithlin.com>
 <CAPcyv4gmiqMNb+Q88Mf-9fFb4z4uAfWbbEWrv42OBH8838SSPQ@mail.gmail.com>
 <20161019184028.GB16550@cgy1-donard.priv.deltatee.com>
 <CAPcyv4iTFpZ1b74Wf+qWe9=Annp+-OCy+pFMS7Fo7quUFwhM4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPcyv4iTFpZ1b74Wf+qWe9=Annp+-OCy+pFMS7Fo7quUFwhM4g@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Oct 19, 2016 at 01:01:06PM -0700, Dan Williams wrote:
> >>
> >> In the cover letter, "[PATCH 0/3] iopmem : A block device for PCIe
> >> memory",  it mentions that the lack of I/O coherency is a known issue
> >> and users of this functionality need to be cognizant of the pitfalls.
> >> If that is the case why do we need support for different cpu mapping
> >> types than the default write-back cache setting?  It's up to the
> >> application to handle cache cpu flushing similar to what we require of
> >> device-dax users in the persistent memory case.
> >
> > Some of the iopmem hardware we have tested has certain alignment
> > restrictions on BAR accesses. At the very least we require write
> > combine mappings for these. We then felt it appropriate to add the
> > other mappings for the sake of completeness.
>
> If the device can support write-combine then it can support bursts, so
> I wonder why it couldn't support read bursts for cache fills...

Dan

You make a good point. We did some testing on this and for the HW we
have access too we did see that a standard WB mapping worked.
Interestly though the local access performance was much slower than
for the WC mapping. We also noticed the PAT entries we not marked
correctly in the WB case. I am trying to get access to some other HW
for more testing.

Grepping for the address of interest:

In WB mode it's:

uncached-minus @ 0x381f80000000-0x381fc0000000

In WC mode it's:

write-combining @ 0x381f80000000-0x381fc0000000

Cheers

Stephen
