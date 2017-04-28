Return-Path: <axboe@kernel.dk>
Date: Fri, 28 Apr 2017 08:27:28 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-block@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: hide badblocks attribute by default
Message-ID: <20170428142727.GA15489@kernel.dk>
References: <149332958627.40858.3562179022452904734.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149332958627.40858.3562179022452904734.stgit@dwillia2-desk3.amr.corp.intel.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 27 2017, Dan Williams wrote:
> Commit 99e6608c9e74 "block: Add badblock management for gendisks"
> allowed for drivers like pmem and software-raid to advertise a list of
> bad media areas. However, it inadvertently added a 'badblocks' to all
> block devices. Lets clean this up by having the 'badblocks' attribute
> not be visible when the driver has not populated a 'struct badblocks'
> instance in the gendisk.

Thanks Dan, added.

-- 
Jens Axboe
