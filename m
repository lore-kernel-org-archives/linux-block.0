Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Ming Lei <ming.lei@redhat.com>
Date: Wed, 03 May 2017 08:10:29 +1000
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] blk: make the bioset rescue_workqueue optional.
In-Reply-To: <20170502105859.GC1803@ming.t460p>
References: <149369628671.5146.4865312503373040039.stgit@noble> <149369654434.5146.15331164625586213889.stgit@noble> <20170502105859.GC1803@ming.t460p>
Message-ID: <87zieuq59m.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, May 02 2017, Ming Lei wrote:

> On Tue, May 02, 2017 at 01:42:24PM +1000, NeilBrown wrote:
>> This patch converts bioset_create() and
>> bioset_create_nobvec() to not create a workqueue so
>> alloctions will never trigger punt_bios_to_rescuer().  It
>> also introduces bioset_create_rescued() and
>> bioset_create_nobvec_rescued() which preserve the old
>> behaviour.
>>=20
>> All callers of bioset_create() and bioset_create_nobvec(),
>> that are inside block device drivers, are converted to the
>> _rescued() version.
>
> The above comment about *_nobvec() need to be updated.

Yes - thanks.  I'll post an updated version.


>
>>=20
>> biosets used by filesystems or other top-level users do not
>> need rescuing as the bio can never be queued behind other
>> bios.  This includes fs_bio_set, blkdev_dio_pool,
>> btrfs_bioset, xfs_ioend_bioset, drbd_md_io_bio_set,
>> and one allocated by target_core_iblock.c.
>>=20
>> biosets used by md/raid to not need rescuing as
>> their usage was recently audited to revised to never
>> risk deadlock.
>>=20
>> It is hoped that most, if not all, of the remaining biosets
>> can end up being the non-rescued version.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>>  block/bio.c               |   12 ++++++++++--
>>  block/blk-core.c          |    2 +-
>>  drivers/md/bcache/super.c |    6 ++++--
>>  drivers/md/dm-crypt.c     |    2 +-
>>  drivers/md/dm-io.c        |    2 +-
>>  drivers/md/dm.c           |    5 +++--
>>  include/linux/bio.h       |    1 +
>>  7 files changed, 21 insertions(+), 9 deletions(-)
>
> DRBD can stack on block device too, so I guess it might need
> BIOSET_NEED_RESCUER?

A bioset only needs a rescuer is an allocation is made from the bioset
inside a make_request_fn.
The bioset in DRBD is drbd_md_io_bio_set is used for metadata IO, and
I think it is only used in a worker thread, where rescuing cannot help.
But that is probably subtle enough that I should leave the removal
of the rescuer to a subsequent patch.
So I'll give DRBD the flag when I update the changelog comment.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlkJA9UACgkQOeye3VZi
gbln0hAAn2QI6fDeevvzjlBxpHsMv4+MZPv6fo9NAV785v8ckV1JKcZdxapOSff+
PIUul1S2UidpEETBnMvY+k8uzII+ACfmVx+WMnYZg/4Az/X5rqwGsF35IFPiGkQS
c/FZNpMODTBvyFMVWfYFzKzvXj6PGxCyky3PjmWmP3CUL0fWGdBrqv4/C2Do4TO6
kg3WzO0PKvLV73Uu0WO5NPTvCHVgCywQRLdnxjGVkCmXnvg65aW831IFDxCgEsyh
5I3EWm/3o27LCs4Ygdxcrchc6R1qSURTiW6x+g50V65+/sTVvqkfHTvGHUmehocU
Q4hyel5kREC8MsqRHDyB5DRRlCJlO8QeRCldJeQcDn+nm61rHAV7u0wn5S0CI9y/
vdqzILps5PNrU//QojLVd2+cWc5O3z1QG/5sWdQXWs0UXtv0fqJ7GIR7Wp6uo/tX
6nk106hlgRLphgKSIIcad7oDHiQSXQvJEN76ZYvmBDWIN1Si+CFRft1/aAafBk2Y
qWvntKTzIvKec8pjY0rb6Qe7VRmHvGO2SITgSzhVYCuWU9D+RXs+JQYLpthM0gEd
fpLikOQzQWQtmmYIezr1OgGlnbje1rk0VaOc036NEDuoDOAVd7r4Nq2DLPaVmjQC
zojrhv5GRTbjCjvGrJfPiUPiOxnbFBI/V98WncnHnUr7HNQhAmk=
=9wP3
-----END PGP SIGNATURE-----
--=-=-=--
