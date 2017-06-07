Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 7 Jun 2017 11:04:03 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCHv7 2/2] loop: support 4k physical blocksize
Message-ID: <20170607180403.GC7481@vader.DHCP.thefacebook.com>
References: <1491562257-82574-1-git-send-email-hare@suse.de>
 <1491562257-82574-3-git-send-email-hare@suse.de>
 <20170407145924.GA29654@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170407145924.GA29654@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 07, 2017 at 10:59:29PM +0800, Ming Lei wrote:
> On Fri, Apr 07, 2017 at 12:50:57PM +0200, Hannes Reinecke wrote:
> > When generating bootable VM images certain systems (most notably
> > s390x) require devices with 4k blocksize. This patch implements
> > a new flag 'LO_FLAGS_BLOCKSIZE' which will set the physical
> > blocksize to that of the underlying device, and allow to change
> > the logical blocksize for up to the physical blocksize.
> > 
> > Signed-off-by: Hannes Reinecke <hare@suse.com>
[snip]
> Looks V7 still doesn't recover logical/physical block size for
> new attached file?
> 
> Thanks,
> Ming

Hannes, ping? I'd still like this patch.
