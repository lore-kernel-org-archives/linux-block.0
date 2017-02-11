Return-Path: <wouter@grep.be>
Date: Sat, 11 Feb 2017 12:43:56 +0100
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <jbacik@fb.com>
Cc: Alex Bligh <alex@alex.org.uk>, axboe@kernel.dk,
	linux-block@vger.kernel.org, kernel-team@fb.com,
	"nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>
Subject: Re: [Nbd] [PATCH] nbd: set the logical and physical blocksize
 properly
Message-ID: <20170211114356.qr2atsx4ewcjfbes@grep.be>
References: <1486750004-2988-1-git-send-email-jbacik@fb.com>
 <59F046CB-9EE6-4E45-A06D-3F352218E91B@alex.org.uk>
 <1486763262.4094.12.camel@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1486763262.4094.12.camel@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Feb 10, 2017 at 04:47:42PM -0500, Josef Bacik wrote:
> On Fri, 2017-02-10 at 21:07 +0100, Alex Bligh wrote:
> > > 
> > > On 10 Feb 2017, at 19:06, Josef Bacik <jbacik@fb.com> wrote:
> > > 
> > > We noticed when trying to do O_DIRECT to an export on the server
> > > side
> > > that we were getting requests smaller than the 4k sectorsize of the
> > > device.��This is because the client isn't setting the logical and
> > > physical blocksizes properly for the underlying device.��Fix this
> > > up by
> > > setting the queue blocksizes and then calling bd_set_size.
> > Interesting. Some input into the info extension (re blocksizes) would
> > definitely be appreciated.
> > 
> 
> What do you mean? �Right now the client is just calling�NBD_SET_BLKSIZE
> with 4k blocksize since all of our devices are 4k drives. �Thanks,

He's talking about
<https://github.com/NetworkBlockDevice/nbd/blob/extension-info/doc/proto.md#block-size-constraints>,
which is a protocol extension that hasn't been implemented yet but would
be relevant to this patch.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
