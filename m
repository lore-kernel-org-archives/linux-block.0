Return-Path: <stefanha@redhat.com>
Date: Fri, 2 Nov 2018 04:17:51 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Changpeng Liu <changpeng.liu@intel.com>
Subject: Re: [PATCH v9] virtio_blk: add discard and write zeroes support
Message-ID: <20181102041751.GA13688@stefanha-x1.localdomain>
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
 <20181101224035.215548-1-dverkamp@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
In-Reply-To: <20181101224035.215548-1-dverkamp@chromium.org>
List-ID: <linux-block@vger.kernel.org>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2018 at 03:40:35PM -0700, Daniel Verkamp wrote:
> From: Changpeng Liu <changpeng.liu@intel.com>
>=20
> In commit 88c85538, "virtio-blk: add discard and write zeroes features
> to specification" (https://github.com/oasis-tcs/virtio-spec), the virtio
> block specification has been extended to add VIRTIO_BLK_T_DISCARD and
> VIRTIO_BLK_T_WRITE_ZEROES commands.  This patch enables support for
> discard and write zeroes in the virtio-blk driver when the device
> advertises the corresponding features, VIRTIO_BLK_F_DISCARD and
> VIRTIO_BLK_F_WRITE_ZEROES.
>=20
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> ---
> dverkamp: I've picked up this patch and made a few minor changes (as
> listed below); most notably, I changed the kmalloc back to GFP_ATOMIC,
> since it can be called from a context where sleeping is not allowed.
> To prevent large allocations, I've also clamped the maximum number of
> discard segments to 256; this results in a 4K allocation and should be
> plenty of descriptors for most use cases.
>=20
> I also removed most of the description from the commit message, since it
> was duplicating the comments from virtio_blk.h and quoting parts of the
> spec without adding any extra information.  I have tested this iteration
> of the patch using crosvm with modifications to enable the new features:
> https://chromium.googlesource.com/chromiumos/platform/crosvm/
>=20
> v9 fixes a number of review issues; I didn't attempt to optimize the
> single-element write zeroes case, so it still does an allocation per
> request (I did not see any easy place to put the payload that would
> avoid the allocation).
>=20
> CHANGELOG:
> v9: [dverkamp] fix LE types in discard struct; cleanups from Ming Lei
> v8: [dverkamp] replace shifts by 9 with SECTOR_SHIFT constant
> v7: [dverkamp] use GFP_ATOMIC for allocation that may not sleep; clarify
> descriptor flags field; comment wording cleanups.
> v6: don't set T_OUT bit to discard and write zeroes commands.
> v5: use new block layer API: blk_queue_flag_set.
> v4: several optimizations based on MST's comments, remove bit field
> usage for command descriptor.
> v3: define the virtio-blk protocol to add discard and write zeroes
> support, first version implementation based on proposed specification.
> v2: add write zeroes command support.
> v1: initial proposal implementation for discard command.
> ---
>  drivers/block/virtio_blk.c      | 83 ++++++++++++++++++++++++++++++++-
>  include/uapi/linux/virtio_blk.h | 54 +++++++++++++++++++++
>  2 files changed, 135 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb28/vAAoJEJykq7OBq3PIjpkH/1udSYy/C0VZsxPliibcRED4
58SmnAqFXX0PsDp2+qv3AG7bvkts2P362QPcOjKpDyhHRCQCTIM4FbaaTVc1eK/l
d46xnPg4HpGiqXKGCYqniRCFnUl5XHyDQr2j57VYkq5zD8EgBDKJzjeXTaCs4vkb
nXaM1ThF9Ej22matx4LstvjEXapPHa6E8DekZHaLwNai0G4d3BMvEq+m+tBw88bz
xnlETCSHkeH18Tpii5auoeC1jeDm75asnyO0jyubSaWzWqF/QrF1m7I2kr2rqYfX
l3HcisDhPMl6WbIO2n3PCOip/Ju0ouoMfXENncxyDqOtMYz1BkgU3d+j6fqL8uA=
=foTX
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
