Return-Path: <stefanha@redhat.com>
Date: Mon, 29 Oct 2018 05:05:21 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel Verkamp <dverkamp@chromium.org>,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Changpeng Liu <changpeng.liu@intel.com>
Subject: Re: [PATCH v8] virtio_blk: add discard and write zeroes support
Message-ID: <20181029050521.GB31012@stefanha-x1.localdomain>
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
 <20181012210628.226361-1-dverkamp@chromium.org>
 <20181026080838.GB4234@stefanha-x1.localdomain>
 <20181026104636-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
In-Reply-To: <20181026104636-mutt-send-email-mst@kernel.org>
List-ID: <linux-block@vger.kernel.org>


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2018 at 10:47:16AM -0400, Michael S. Tsirkin wrote:
> On Fri, Oct 26, 2018 at 09:08:38AM +0100, Stefan Hajnoczi wrote:
> > On Fri, Oct 12, 2018 at 02:06:28PM -0700, Daniel Verkamp wrote:
> > > +		range[n].flags =3D cpu_to_le32(flags);
> > > +		range[n].num_sectors =3D cpu_to_le32(num_sectors);
> > > +		range[n].sector =3D cpu_to_le64(sector);
> > ...
> > > +/* Discard/write zeroes range for each request. */
> > > +struct virtio_blk_discard_write_zeroes {
> > > +	/* discard/write zeroes start sector */
> > > +	__virtio64 sector;
> > > +	/* number of discard/write zeroes sectors */
> > > +	__virtio32 num_sectors;
> > > +	/* flags for this range */
> > > +	__virtio32 flags;
> >=20
> > cpu_to_le32() is being used on __virtio32 fields instead of cpu_to_virt=
io32().
> >=20
> > From include/uapi/linux/virtio_types.h:
> >=20
> >   /*
> >    * __virtio{16,32,64} have the following meaning:
> >    * - __u{16,32,64} for virtio devices in legacy mode, accessed in nat=
ive endian
> >    * - __le{16,32,64} for standard-compliant virtio devices
> >    */
> >=20
> > From the VIRTIO specification:
> >=20
> >   struct virtio_blk_discard_write_zeroes {
> >          le64 sector;
> >          le32 num_sectors;
> >          struct {
> >                  le32 unmap:1;
> >                  le32 reserved:31;
> >          } flags;
> >   };
> >=20
> >=20
> > Since the VIRTIO spec says these fields are little-endian, I think these
> > fields should be declared just __u32 and __u64 instead of __virtio32 and
> > __virtio64.
> >=20
> > Stefan
>=20
>=20
> __le32/__le64 rather?

Yes.

Stefan

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb1pURAAoJEJykq7OBq3PIdXIIAKq1wH8qAxcTI8ph86qEeAuQ
RMJy4p2kKPPR6BTSUUW8rebbnzhMeUdzv0bcupvI3PfbTjrS5yS1wRileRrprDpL
bKCsey9eCYNvDq9yna8GCC3pTR/gYxG90kMHQ0RjGaU5WM8/vKeDp/3xk9o9+Fbx
eAsAfrxGk+5Go9eQD+9SEoDEEthxLgSxCd+wRvcgyDc6H5i5ed2Z+8GLNMkZwe5F
xb1kwakCVp/Mi4igrvSkRpLcrXZYhvp6SHQ9pSoO2M/upO+TnmrCUDZmCIAm2Snp
O6VOraZZvZrQcxdWelaS8IUCDmrefQjOvNwLRJ/RtOSY54sZRBwCMpgVpqlVGKs=
=0GD3
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
