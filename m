Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/4 v2] block: Fixes for bdi handling
To: Jan Kara <jack@suse.cz>
References: <20170309101624.25901-1-jack@suse.cz>
Cc: Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, Omar Sandoval
 <osandov@osandov.com>, Arthur Marsh <arthur.marsh@internode.on.net>,
 linux-scsi@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7177cebf-8a9b-10d4-e991-5e43f4303ffc@kernel.dk>
Date: Thu, 9 Mar 2017 09:41:01 -0700
MIME-Version: 1.0
In-Reply-To: <20170309101624.25901-1-jack@suse.cz>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/09/2017 03:16 AM, Jan Kara wrote:
> Hi!
> 
> this is a second revision of the series fixing the most urgent bugs that were
> introduced by commit 165a5e22fafb "block: Move bdi_unregister() to
> del_gendisk()" and by 0dba1314d4f8 "scsi, block: fix duplicate bdi name
> registration crashes".  In fact before these commits we had a different set of
> problems in the code but they were less visible :).

It was rather urgent to get those fixes in, so I already sent them off. Not a
huge deal, but it would be nice to add the atomic init fix as a separate patch
later on.

-- 
Jens Axboe
