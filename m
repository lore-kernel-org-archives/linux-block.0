Return-Path: <dan.j.williams@intel.com>
MIME-Version: 1.0
In-Reply-To: <20170313151410.5586-1-jack@suse.cz>
References: <20170313151410.5586-1-jack@suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 13 Mar 2017 11:10:11 -0700
Message-ID: <CAPcyv4h0ZdWO4iL0aNd3VnFxeSK5hckminvsDE0F9_=tOSor1A@mail.gmail.com>
Subject: Re: [PATCH 0/11 v4] block: Fix block device shutdown related races
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Tejun Heo <tj@kernel.org>, Tahsin Erdogan <tahsin@google.com>, Omar Sandoval <osandov@osandov.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 13, 2017 at 8:13 AM, Jan Kara <jack@suse.cz> wrote:
> Hello,
>
> this is a series with the remaining patches (on top of 4.11-rc2) to fix several
> different races and issues I've found when testing device shutdown and reuse.
> The first two patches fix possible (theoretical) problems when opening of a
> block device races with shutdown of a gendisk structure. Patches 3-9 fix oops
> that is triggered by __blkdev_put() calling inode_detach_wb() too early (the
> problem reported by Thiago). Patches 10 and 11 fix oops due to a bug in gendisk
> code where get_gendisk() can return already freed gendisk structure (again
> triggered by Omar's stress test).
>
> People, please have a look at patches. They are mostly simple however the
> interactions are rather complex so I may have missed something. Also I'm
> happy for any additional testing these patches can get - I've stressed them
> with Omar's script, tested memcg writeback, tested static (not udev managed)
> device inodes.

Passes testing with the libnvdimm unit tests that have been tripped up
by block-unplug bugs in the past.
