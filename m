Return-Path: <prvs=32144e98a9=jbacik@fb.com>
Message-ID: <1486763262.4094.12.camel@fb.com>
Subject: Re: [Nbd] [PATCH] nbd: set the logical and physical blocksize
 properly
From: Josef Bacik <jbacik@fb.com>
To: Alex Bligh <alex@alex.org.uk>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <kernel-team@fb.com>,
        "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>
Date: Fri, 10 Feb 2017 16:47:42 -0500
In-Reply-To: <59F046CB-9EE6-4E45-A06D-3F352218E91B@alex.org.uk>
References: <1486750004-2988-1-git-send-email-jbacik@fb.com>
	 <59F046CB-9EE6-4E45-A06D-3F352218E91B@alex.org.uk>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-02-10 at 21:07 +0100, Alex Bligh wrote:
> > 
> > On 10 Feb 2017, at 19:06, Josef Bacik <jbacik@fb.com> wrote:
> > 
> > We noticed when trying to do O_DIRECT to an export on the server
> > side
> > that we were getting requests smaller than the 4k sectorsize of the
> > device.  This is because the client isn't setting the logical and
> > physical blocksizes properly for the underlying device.  Fix this
> > up by
> > setting the queue blocksizes and then calling bd_set_size.
> Interesting. Some input into the info extension (re blocksizes) would
> definitely be appreciated.
> 

What do you mean?  Right now the client is just calling NBD_SET_BLKSIZE
with 4k blocksize since all of our devices are 4k drives.  Thanks,

Josef
