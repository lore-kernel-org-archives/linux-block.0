Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:33599 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751292AbdBAIK1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Feb 2017 03:10:27 -0500
Date: Wed, 1 Feb 2017 09:10:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@lst.de>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-block@vger.kernel.org, jmoyer <jmoyer@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [RFC PATCH 10/17] block: introduce bdev_dax_direct_access()
Message-ID: <20170201081020.GD29170@lst.de>
References: <148559256378.11180.8957776806175202312.stgit@dwillia2-desk3.amr.corp.intel.com> <148559261791.11180.12085685820239925499.stgit@dwillia2-desk3.amr.corp.intel.com> <20170130123226.GD9043@lst.de> <CAPcyv4iARmZQSBybJ1iJhwkndVxSe62rk4hjP1T9prBuOqVQ-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPcyv4iARmZQSBybJ1iJhwkndVxSe62rk4hjP1T9prBuOqVQ-A@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jan 30, 2017 at 10:16:29AM -0800, Dan Williams wrote:
> Ok, now that dax_map_atomic() is gone, it's much easier to remove
> struct blk_dax_ctl.
> 
> We can also move the partition alignment checks to be a one-time check
> at bdev_dax_capable() time and kill bdev_dax_direct_access() in favor
> of calling dax_direct_access() directly.

Yes, please.

> >> +     if ((sector + DIV_ROUND_UP(dax->size, 512))
> >> +                     > part_nr_sects_read(bdev->bd_part))
> >> +             return -ERANGE;
> >> +     sector += get_start_sect(bdev);
> >> +     return dax_direct_access(dax_inode, sector * 512, &dax->addr,
> >> +                     &dax->pfn, dax->size);
> >
> > And please switch to using bytes as the granularity given that we're
> > deadling with byte addressable memory.
> 
> dax_direct_access() does take a byte aligned physical address, but it
> needs to be at least page aligned since we are returning a pfn_t...
> 
> Hmm, perhaps the input should be raw page frame number. We could
> reduce one of the arguments by making the current 'pfn_t *' parameter
> an in/out-parameter.

In/Out parameters are always a bit problematic in terms of API clarity.
And updating a device-relative address with an absolute physical one
sounds like an odd API for sure.
