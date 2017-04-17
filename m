Return-Path: <alex@alex.org.uk>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [PATCH] nbd: set the max segment size to UINT_MAX
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <1492436677-11209-1-git-send-email-jbacik@fb.com>
Date: Mon, 17 Apr 2017 23:46:54 +0200
Cc: Alex Bligh <alex@alex.org.uk>,
 axboe@kernel.dk,
 "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>,
 linux-block@vger.kernel.org,
 kernel-team@fb.com
Message-Id: <49AD0AD8-9FEE-4CD8-BAB6-6C92FA3A2AD0@alex.org.uk>
References: <1492436677-11209-1-git-send-email-jbacik@fb.com>
To: Josef Bacik <josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>


> On 17 Apr 2017, at 15:44, Josef Bacik <josef@toxicpanda.com> wrote:
>=20
> NBD doesn't care about limiting the segment size, let the user push =
the
> largest bio's they want.  This allows us to control the request size
> solely through max_sectors_kb.

I'm a bit lost around the various knobs in the kernel for maximum block
sizes, but note that the NBD protocol is (with an extension, soon
to be made mainstream by the looks of it) capable of negotiating
block size minima, maxima and preferred sizes - see here:

=
https://github.com/NetworkBlockDevice/nbd/blob/extension-info/doc/proto.md=
#block-size-constraints

These are server block sizes (obviously) which would normally be passed
from userland client to kernel client via an ioctl. I suspect such
ioctls may not be implemented at the moment, and kernel support for
them would be much appreciated.

--=20
Alex Bligh
