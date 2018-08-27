Return-Path: <konrad.wilk@oracle.com>
Date: Mon, 27 Aug 2018 12:10:23 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Juergen Gross <jgross@suse.com>
Cc: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v3 0/5] xen/blk: persistent grant rework
Message-ID: <20180827161023.GV10467@char.us.oracle.com>
References: <20180813140114.20126-1-jgross@suse.com>
 <20180817155909.4cwiy6bhhgiala5m@mac>
 <8aaf02b1-999d-81fc-2732-ed556b959a8a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <8aaf02b1-999d-81fc-2732-ed556b959a8a@suse.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Aug 24, 2018 at 03:52:23PM +0200, Juergen Gross wrote:
> On 17/08/18 17:59, Roger Pau Monn=E9 wrote:
> > On Mon, Aug 13, 2018 at 04:01:09PM +0200, Juergen Gross wrote:
> >> Persistent grants are used in the Xen's blkfront/blkback drivers to
> >> avoid mapping/unmapping of I/O buffers in the backend for each I/O.
> >>
> >> While this speeds up processing quite a bit there are problems relat=
ed
> >> to persistent grants in some configurations: domains with multiple
> >> block devices making use of persistent grants might suffer from a la=
ck
> >> of grants if each of the block devices experienced a high I/O load a=
t
> >> some time. This is due to the number of persistent grants per device
> >> only to be limited by a rather high maximum value, but never being
> >> released even in case of longer times without any I/O.
> >>
> >> This series modifies xen-blkback to unmap any domU page mapped via a
> >> persistent grant after a timeout (default: 60 seconds). The timeout
> >> is set to its default value again when a persistent grant has been
> >> used for an I/O.
> >>
> >> xen-blkfront is modified to scan every 10 seconds for persistent gra=
nts
> >> not in use by blkback any more and to remove such grants.
> >>
> >> The last 3 patches are small cleanups of blkfront and blkback driver=
s.
> >>
> >> V3:
> >> - patch 1: make timeout parameter static
> >=20
> > Konrad if you are OK with this series, could you please send a pull
> > request to Jens?
>=20
> Ping?

Yes, let me do that now.
>=20
>=20
> Juergen
