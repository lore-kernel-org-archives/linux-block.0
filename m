Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:33971 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751731AbdBAJ2D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Feb 2017 04:28:03 -0500
Date: Wed, 1 Feb 2017 10:28:00 +0100
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
Message-ID: <20170201092800.GA1050@lst.de>
References: <148559256378.11180.8957776806175202312.stgit@dwillia2-desk3.amr.corp.intel.com> <148559261791.11180.12085685820239925499.stgit@dwillia2-desk3.amr.corp.intel.com> <20170130123226.GD9043@lst.de> <CAPcyv4iARmZQSBybJ1iJhwkndVxSe62rk4hjP1T9prBuOqVQ-A@mail.gmail.com> <20170201081020.GD29170@lst.de> <CAPcyv4g419yOyH_UnMAxMUpxjEbAWDbL2NAG4ScfF+iNHdLfAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPcyv4g419yOyH_UnMAxMUpxjEbAWDbL2NAG4ScfF+iNHdLfAQ@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Feb 01, 2017 at 01:21:40AM -0800, Dan Williams wrote:
> > In/Out parameters are always a bit problematic in terms of API clarity.
> > And updating a device-relative address with an absolute physical one
> > sounds like an odd API for sure.
> 
> Yes, it does, and I thought better of it shortly after sending that. How about:
> 
> long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> unsigned long nr_pages, void **kaddr, pfn_t *pfn)

Yes, that looks good to me.
