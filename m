Return-Path: <linux-fsdevel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170201081020.GD29170@lst.de>
References: <148559256378.11180.8957776806175202312.stgit@dwillia2-desk3.amr.corp.intel.com>
 <148559261791.11180.12085685820239925499.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20170130123226.GD9043@lst.de> <CAPcyv4iARmZQSBybJ1iJhwkndVxSe62rk4hjP1T9prBuOqVQ-A@mail.gmail.com>
 <20170201081020.GD29170@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Feb 2017 01:21:40 -0800
Message-ID: <CAPcyv4g419yOyH_UnMAxMUpxjEbAWDbL2NAG4ScfF+iNHdLfAQ@mail.gmail.com>
Subject: Re: [RFC PATCH 10/17] block: introduce bdev_dax_direct_access()
To: Christoph Hellwig <hch@lst.de>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-block@vger.kernel.org, jmoyer <jmoyer@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 1, 2017 at 12:10 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Jan 30, 2017 at 10:16:29AM -0800, Dan Williams wrote:
>> Ok, now that dax_map_atomic() is gone, it's much easier to remove
>> struct blk_dax_ctl.
>>
>> We can also move the partition alignment checks to be a one-time check
>> at bdev_dax_capable() time and kill bdev_dax_direct_access() in favor
>> of calling dax_direct_access() directly.
>
> Yes, please.
>
>> >> +     if ((sector + DIV_ROUND_UP(dax->size, 512))
>> >> +                     > part_nr_sects_read(bdev->bd_part))
>> >> +             return -ERANGE;
>> >> +     sector += get_start_sect(bdev);
>> >> +     return dax_direct_access(dax_inode, sector * 512, &dax->addr,
>> >> +                     &dax->pfn, dax->size);
>> >
>> > And please switch to using bytes as the granularity given that we're
>> > deadling with byte addressable memory.
>>
>> dax_direct_access() does take a byte aligned physical address, but it
>> needs to be at least page aligned since we are returning a pfn_t...
>>
>> Hmm, perhaps the input should be raw page frame number. We could
>> reduce one of the arguments by making the current 'pfn_t *' parameter
>> an in/out-parameter.
>
> In/Out parameters are always a bit problematic in terms of API clarity.
> And updating a device-relative address with an absolute physical one
> sounds like an odd API for sure.

Yes, it does, and I thought better of it shortly after sending that. How about:

long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
unsigned long nr_pages, void **kaddr, pfn_t *pfn)
