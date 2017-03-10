Return-Path: <jack@suse.cz>
Date: Fri, 10 Mar 2017 11:22:05 +0100
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
	linux-block@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Omar Sandoval <osandov@osandov.com>,
	Arthur Marsh <arthur.marsh@internode.on.net>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 0/4 v2] block: Fixes for bdi handling
Message-ID: <20170310102205.GA12421@quack2.suse.cz>
References: <20170309101624.25901-1-jack@suse.cz>
 <7177cebf-8a9b-10d4-e991-5e43f4303ffc@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7177cebf-8a9b-10d4-e991-5e43f4303ffc@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu 09-03-17 09:41:01, Jens Axboe wrote:
> On 03/09/2017 03:16 AM, Jan Kara wrote:
> > Hi!
> > 
> > this is a second revision of the series fixing the most urgent bugs that were
> > introduced by commit 165a5e22fafb "block: Move bdi_unregister() to
> > del_gendisk()" and by 0dba1314d4f8 "scsi, block: fix duplicate bdi name
> > registration crashes".  In fact before these commits we had a different set of
> > problems in the code but they were less visible :).
> 
> It was rather urgent to get those fixes in, so I already sent them off.
> Not a huge deal, but it would be nice to add the atomic init fix as a
> separate patch later on.

OK, actually my followup fixes remove the counter completely so I guess we
can just leave it as is.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
