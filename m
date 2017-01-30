Return-Path: <linux-fsdevel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170130122658.GB9043@lst.de>
References: <148559256378.11180.8957776806175202312.stgit@dwillia2-desk3.amr.corp.intel.com>
 <148559263442.11180.2158046423959539211.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20170130122658.GB9043@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 30 Jan 2017 10:29:12 -0800
Message-ID: <CAPcyv4imiVCvtKbXJeK5_BhPhd-Gnr9nOz-ML6TKfVSQ9Rr3Cg@mail.gmail.com>
Subject: Re: [RFC PATCH 13/17] fs: update mount_bdev() to lookup dax infrastructure
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

On Mon, Jan 30, 2017 at 4:26 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Sat, Jan 28, 2017 at 12:37:14AM -0800, Dan Williams wrote:
>> This is in preparation for removing the ->direct_access() method from
>> block_device_operations.
>
> I don't think mount_bdev has any business knowing about DAX.
> Just call dax_get_by_host manually from the affected file systems for
> now, and in the future we can have a pure-DAX mount_dax helper.

Ok, since we already need dax_get_by_host() in the blkdev_writepages()
path I can sprinkle a few more of those calls and leave mount_bdev
alone.
