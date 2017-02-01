Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:33583 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751673AbdBAIIo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Feb 2017 03:08:44 -0500
Date: Wed, 1 Feb 2017 09:08:38 +0100
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
Subject: Re: [RFC PATCH 13/17] fs: update mount_bdev() to lookup dax
        infrastructure
Message-ID: <20170201080838.GC29170@lst.de>
References: <148559256378.11180.8957776806175202312.stgit@dwillia2-desk3.amr.corp.intel.com> <148559263442.11180.2158046423959539211.stgit@dwillia2-desk3.amr.corp.intel.com> <20170130122658.GB9043@lst.de> <CAPcyv4imiVCvtKbXJeK5_BhPhd-Gnr9nOz-ML6TKfVSQ9Rr3Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPcyv4imiVCvtKbXJeK5_BhPhd-Gnr9nOz-ML6TKfVSQ9Rr3Cg@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jan 30, 2017 at 10:29:12AM -0800, Dan Williams wrote:
> On Mon, Jan 30, 2017 at 4:26 AM, Christoph Hellwig <hch@lst.de> wrote:
> > On Sat, Jan 28, 2017 at 12:37:14AM -0800, Dan Williams wrote:
> >> This is in preparation for removing the ->direct_access() method from
> >> block_device_operations.
> >
> > I don't think mount_bdev has any business knowing about DAX.
> > Just call dax_get_by_host manually from the affected file systems for
> > now, and in the future we can have a pure-DAX mount_dax helper.
> 
> Ok, since we already need dax_get_by_host() in the blkdev_writepages()
> path I can sprinkle a few more of those calls and leave mount_bdev
> alone.

Huh?  I thought we stopped using DAX I/O for the block device nodes
a while ago?
