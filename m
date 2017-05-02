Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Javier =?utf-8?Q?Gonz=C3=A1lez?= <jg@lightnvm.io>
Date: Wed, 03 May 2017 07:51:32 +1000
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] lightnvm/pblk-read: use bio_clone_fast()
In-Reply-To: <FC7673E1-94A3-4C93-960F-EF05A0BF09B0@lightnvm.io>
References: <149369628671.5146.4865312503373040039.stgit@noble> <149369654558.5146.13818001419050826182.stgit@noble> <FC7673E1-94A3-4C93-960F-EF05A0BF09B0@lightnvm.io>
Message-ID: <8737cnq657.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 02 2017, Javier Gonz=C3=A1lez wrote:

>> On 2 May 2017, at 05.42, NeilBrown <neilb@suse.com> wrote:
>>=20
>> pblk_submit_read() uses bio_clone_bioset() but doesn't change the
>> io_vec, so bio_clone_fast() is a better choice.
>>=20
>> It also uses fs_bio_set which is intended for filesystems.  Using it
>> in a device driver can deadlock.
>> So allocate a new bioset, and and use bio_clone_fast().
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>> drivers/lightnvm/pblk-init.c |   12 +++++++++++-
>> drivers/lightnvm/pblk-read.c |    2 +-
>> drivers/lightnvm/pblk.h      |    1 +
>> 3 files changed, 13 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>> index b3fec8ec55b8..aaefbccce30e 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -23,6 +23,7 @@
>> static struct kmem_cache *pblk_blk_ws_cache, *pblk_rec_cache, *pblk_r_rq=
_cache,
>> 					*pblk_w_rq_cache, *pblk_line_meta_cache;
>> static DECLARE_RWSEM(pblk_lock);
>> +struct bio_set *pblk_bio_set;
>>=20
>> static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
>> 			  struct bio *bio)
>> @@ -946,11 +947,20 @@ static struct nvm_tgt_type tt_pblk =3D {
>>=20
>> static int __init pblk_module_init(void)
>> {
>> -	return nvm_register_tgt_type(&tt_pblk);
>> +	int ret;
>> +
>> +	pblk_bio_set =3D bioset_create(BIO_POOL_SIZE, 0, 0);
>> +	if (!pblk_bio_set)
>> +		return -ENOMEM;
>> +	ret =3D nvm_register_tgt_type(&tt_pblk);
>> +	if (ret)
>> +		bioset_free(pblk_bio_set);
>> +	return ret;
>> }
>>=20
>> static void pblk_module_exit(void)
>> {
>> +	bioset_free(pblk_bio_set);
>> 	nvm_unregister_tgt_type(&tt_pblk);
>> }
>>=20
>> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
>> index 4a12f14d78c6..8ee0c50a7a71 100644
>> --- a/drivers/lightnvm/pblk-read.c
>> +++ b/drivers/lightnvm/pblk-read.c
>> @@ -342,7 +342,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *=
bio)
>> 		struct pblk_r_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
>>=20
>> 		/* Clone read bio to deal with read errors internally */
>> -		int_bio =3D bio_clone_bioset(bio, GFP_KERNEL, fs_bio_set);
>> +		int_bio =3D bio_clone_fast(bio, GFP_KERNEL, pblk_bio_set);
>> 		if (!int_bio) {
>> 			pr_err("pblk: could not clone read bio\n");
>> 			return NVM_IO_ERR;
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index 99f3186b5288..95b665f23925 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -702,6 +702,7 @@ void pblk_write_should_kick(struct pblk *pblk);
>> /*
>>  * pblk read path
>>  */
>> +extern struct bio_set *pblk_bio_set;
>> int pblk_submit_read(struct pblk *pblk, struct bio *bio);
>> int pblk_submit_read_gc(struct pblk *pblk, u64 *lba_list, void *data,
>> 			unsigned int nr_secs, unsigned int *secs_to_gc,
>
> Hi Neil,
>
> Looks good. Thanks for fixing this. I did not know that bio_clone_bioset
> was not supposed to be used on drivers.

Prior to my patchset, using bio_clone_bioset() wasn't wrong in drivers,
though it was a waste when bio_clone_fast() would to just as well as is
more efficient.
After my patchset, using it can be problematic.  I'm wondering what I
should do to encourage those problems to be more visible so that if
people to us it, they'll get a warning or something.

Thanks,
NeilBrown


>
> Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
> Tested-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlkI/2UACgkQOeye3VZi
gbkTgQ/+NtSbeeFWQ4fAsZV9s2K2eNNULq68NzDevic99MZ7UyFdGQAg22sFaQnu
qLxFkvdohX/11Z4ycD/H00RDKJNdbm9h1Igg39aDWArJxLemtGVFQ/bNPJPruEJw
noR8Nj2kwuwZpHOn1FFyLoFzOvMlRxVEJ1lxTTM+qq0P3ahUksp505621pAZDejV
G9tsf8V2Bgr+5XVpnTcTHWlUSjucMHGzquP1yhnBADXZo4aX99E3q6y9adv81mLq
uKtgApfIUBLekPwyQw+avP2USs1VLy68LGdH46XsCB7ikgh204WG/1BOLkpYBYb5
LgJPqNcomKZ64A+zWUjh4FtJb2U0z8LABlEW5Ok7yEoZljC7R491WmSIb8RsoYtZ
uL976C/uB5mHSo7X59j84tna4ubNfc3p92925bp8FB0Fep9gTnG2z8GFAtHth6nt
OJYJh2D8C2Ao/eETq3fpMgWaSyzG4g3kQ0OfGka9b3wCrQ9MdflsmQK560+iRP1j
a+LYDjK/EZGpjNJOOc7KuBjJ8Yq3vRCswJALuyzndhV/iCrU0EOCk3NWU17dqS67
zGiDDfB60QlSB5tLwyL17baXo86zHc7LdFSQYJGx1dG8VzeF2yfMLTK/Z/3VNt5t
6Cf+KflW78FtCbfTgV7vv3F/LrNC1c5WD2HFwP9eOxLtKL41NuE=
=HIGX
-----END PGP SIGNATURE-----
--=-=-=--
