Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56093 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932476AbdAJP5y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2017 10:57:54 -0500
Date: Tue, 10 Jan 2017 16:57:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>, axboe@fb.com,
        Andi Kleen <ak@linux.intel.com>,
        Rabin Vincent <rabinv@axis.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>, Wei Fang <fangwei1@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: fix blk_get_backing_dev_info() crash, use
        bdev->bd_queue
Message-ID: <20170110155751.GA28921@lst.de>
References: <148366547505.38941.646379357860772670.stgit@dwillia2-desk3.amr.corp.intel.com> <20170106102330.GB3533@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170106102330.GB3533@quack2.suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 06, 2017 at 11:23:30AM +0100, Jan Kara wrote:
> So what I think needs to be done is that we make backing_dev_info
> independently allocated structure with different lifetime rules to gendisk
> or request_queue - definitely I want it to live as long as block device
> inode exists. However it needs more thought what the exact lifetime rules
> will be.

Yes, moving the backing dev out (or keeping the request_queue memoery alive)
is something we need to do.  And we need to look into the other half
of the backing_dev life time isssues - we need to make sure the name
and sysfs resources are released as soon as the devices goes away so that
we aren't going to run into reuse races.
