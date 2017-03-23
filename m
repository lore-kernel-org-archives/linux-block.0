Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/10 v5] block: Fix block device shutdown related races
To: Jan Kara <jack@suse.cz>
References: <20170323003702.27571-1-jack@suse.cz>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Tejun Heo <tj@kernel.org>, Tahsin Erdogan <tahsin@google.com>,
 Omar Sandoval <osandov@osandov.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7a2e212e-2e44-2729-686f-20b2862880e4@kernel.dk>
Date: Wed, 22 Mar 2017 20:14:23 -0600
MIME-Version: 1.0
In-Reply-To: <20170323003702.27571-1-jack@suse.cz>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/22/2017 06:36 PM, Jan Kara wrote:
> Hello,
> 
> this is a series with the remaining patches (on top of 4.11-rc2) to
> fix several different races and issues I've found when testing device
> shutdown and reuse.  The first patch fixes possible (theoretical)
> problems when opening of a block device races with shutdown of a
> gendisk structure. Patches 2-8 fix oops that is triggered by
> __blkdev_put() calling inode_detach_wb() too early (the problem
> reported by Thiago). Patches 9 and 10 fix oops due to a bug in gendisk
> code where get_gendisk() can return already freed gendisk structure
> (again triggered by Omar's stress test).
> 
> All patches got reviewed by Tejun and also tested by Thiago (thanks!).
> Jens, can you please queue these fixes for the next merge window?
> Thanks!

Done! Thanks a lot for working on this, Jan.

-- 
Jens Axboe
