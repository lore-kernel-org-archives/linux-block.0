Return-Path: <daniel.verkamp@intel.com>
From: "Verkamp, Daniel" <daniel.verkamp@intel.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Jens
 Axboe" <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Hannes Reinecke <hare@suse.com>, Sagi Grimberg
	<sagi@grimberg.me>, "Busch, Keith" <keith.busch@intel.com>, Hannes Reinecke
	<hare@suse.de>
Subject: RE: [PATCH 09/14] nvmet: Add AEN configuration support
Date: Tue, 29 May 2018 17:35:12 +0000
Message-ID: <A5F28D4A728A7E41839CDC5C3B5A01E8B74D35C6@FMSMSX103.amr.corp.intel.com>
References: <20180526102735.31404-1-hch@lst.de>
 <20180526102735.31404-10-hch@lst.de>
 <A5F28D4A728A7E41839CDC5C3B5A01E8B74D2557@FMSMSX103.amr.corp.intel.com>
 <20180529172936.GA1235@lst.de>
In-Reply-To: <20180529172936.GA1235@lst.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Return-Path: daniel.verkamp@intel.com
List-ID: <linux-block@vger.kernel.org>

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Tuesday, May 29, 2018 10:30 AM
> To: Verkamp, Daniel <daniel.verkamp@intel.com>
> Cc: Christoph Hellwig <hch@lst.de>; linux-nvme@lists.infradead.org; Jens =
Axboe
> <axboe@kernel.dk>; linux-block@vger.kernel.org; Hannes Reinecke
> <hare@suse.com>; Sagi Grimberg <sagi@grimberg.me>; Busch, Keith
> <keith.busch@intel.com>; Hannes Reinecke <hare@suse.de>
> Subject: Re: [PATCH 09/14] nvmet: Add AEN configuration support
>=20
> On Tue, May 29, 2018 at 05:15:34PM +0000, Verkamp, Daniel wrote:
> > This looks overly restrictive - a host sending a Set Features with e.g.=
 the health
> critical warning bits set in CDW11 will get a failure.  As far as I can t=
ell, this isn't
> allowed by the spec;  Set Features - Asynchronous Event Configuration and=
 the
> health log page have been mandatory since NVMe 1.0, and presumably suppor=
t
> for the corresponding health log page related AER bits is also mandatory =
(these
> were the only bits available in NVMe 1.0).
>=20
> Agreed so far.
>=20
> > I think it should be fine to just allow the user to set any (valid) com=
bination of
> bits here, while still only triggering the NS Changed notification.
>=20
> Disagreeing here.  Catching completely bogus bits that the hosts sets
> is important.

Sorry, I should have been clearer - I agree with your position here.  Only =
bits that are valid should be allowed, so for example it is fine to fail co=
mmands that set reserved bits, or optional bits that have a mechanism to in=
dicate they are not supported, like Telemetry (which has an associated bit =
in Identify controller data - LPA).  My note above was really just about th=
e health warning bits, which by my reading are not optional.

Thanks,
-- Daniel
