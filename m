Return-Path: <bauerman@linux.vnet.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>, Tejun Heo <tj@kernel.org>,
        Tahsin Erdogan <tahsin@google.com>,
        Omar Sandoval <osandov@osandov.com>,
        "Lekshmi C. Pillai" <lekshmi.cpillai@in.ibm.com>
Subject: Re: [PATCH 0/10 v5] block: Fix block device shutdown related races
Date: Tue, 04 Apr 2017 14:09:51 -0300
In-Reply-To: <20170323003702.27571-1-jack@suse.cz>
References: <20170323003702.27571-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <1727592.C3UmHNa1QZ@morokweng>
List-ID: <linux-block@vger.kernel.org>

Hello,

Am Donnerstag, 23. M=E4rz 2017, 01:36:52 BRT schrieb Jan Kara:
> this is a series with the remaining patches (on top of 4.11-rc2) to fix
> several different races and issues I've found when testing device shutdown
> and reuse. The first patch fixes possible (theoretical) problems when
> opening of a block device races with shutdown of a gendisk structure.
> Patches 2-8 fix oops that is triggered by __blkdev_put() calling
> inode_detach_wb() too early (the problem reported by Thiago). Patches 9 a=
nd
> 10 fix oops due to a bug in gendisk code where get_gendisk() can return
> already freed gendisk structure (again triggered by Omar's stress test).
>=20
> All patches got reviewed by Tejun and also tested by Thiago (thanks!). Je=
ns,
> can you please queue these fixes for the next merge window? Thanks!

Lekshmi tested these patches on top of v4.11-rc4 and they worked fine.
Sorry for the delay, it takes at least 72h of running time to be sure we're=
=20
not hitting the race condition, and I had trouble with v4.11-rc2.

=2D-=20
Thiago Jung Bauermann
IBM Linux Technology Center
