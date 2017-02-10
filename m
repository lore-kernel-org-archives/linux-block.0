Return-Path: <alex@alex.org.uk>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [PATCH] nbd: set the logical and physical blocksize properly
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <1486750004-2988-1-git-send-email-jbacik@fb.com>
Date: Fri, 10 Feb 2017 21:07:20 +0100
Cc: Alex Bligh <alex@alex.org.uk>,
 axboe@kernel.dk,
 linux-block@vger.kernel.org,
 kernel-team@fb.com,
 "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>
Message-Id: <59F046CB-9EE6-4E45-A06D-3F352218E91B@alex.org.uk>
References: <1486750004-2988-1-git-send-email-jbacik@fb.com>
To: Josef Bacik <jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>


> On 10 Feb 2017, at 19:06, Josef Bacik <jbacik@fb.com> wrote:
> 
> We noticed when trying to do O_DIRECT to an export on the server side
> that we were getting requests smaller than the 4k sectorsize of the
> device.  This is because the client isn't setting the logical and
> physical blocksizes properly for the underlying device.  Fix this up by
> setting the queue blocksizes and then calling bd_set_size.

Interesting. Some input into the info extension (re blocksizes) would
definitely be appreciated.

-- 
Alex Bligh
