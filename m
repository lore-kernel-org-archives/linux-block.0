Return-Path: <alex@alex.org.uk>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [PATCH] nbd: set the logical and physical blocksize properly
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20170211114356.qr2atsx4ewcjfbes@grep.be>
Date: Sat, 11 Feb 2017 17:13:08 +0100
Cc: Alex Bligh <alex@alex.org.uk>,
 Josef Bacik <jbacik@fb.com>,
 axboe@kernel.dk,
 linux-block@vger.kernel.org,
 Kernel Team <kernel-team@fb.com>,
 "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>
Message-Id: <BC66A4E0-7369-4F7C-AD1E-05CC93EC8D2B@alex.org.uk>
References: <1486750004-2988-1-git-send-email-jbacik@fb.com> <59F046CB-9EE6-4E45-A06D-3F352218E91B@alex.org.uk> <1486763262.4094.12.camel@fb.com> <20170211114356.qr2atsx4ewcjfbes@grep.be>
To: Wouter Verhelst <w@uter.be>
List-ID: <linux-block@vger.kernel.org>


> On 11 Feb 2017, at 12:43, Wouter Verhelst <w@uter.be> wrote:
>=20
>>> Interesting. Some input into the info extension (re blocksizes) =
would
>>> definitely be appreciated.
>>>=20
>>=20
>> What do you mean?  Right now the client is just calling =
NBD_SET_BLKSIZE
>> with 4k blocksize since all of our devices are 4k drives.  Thanks,
>=20
> He's talking about
> =
<https://github.com/NetworkBlockDevice/nbd/blob/extension-info/doc/proto.m=
d#block-size-constraints>,
> which is a protocol extension that hasn't been implemented yet but =
would
> be relevant to this patch.

Indeed. Specifically, review of the patch from a kernel perspective
would be useful.

--=20
Alex Bligh
