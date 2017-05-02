Return-Path: <jg@lightnvm.io>
Return-Path: <jg@lightnvm.io>
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <FC7673E1-94A3-4C93-960F-EF05A0BF09B0@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F1C5794E-0860-452D-A505-00F1F0A4A157";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 09/13] lightnvm/pblk-read: use bio_clone_fast()
Date: Tue, 2 May 2017 13:22:54 +0200
In-Reply-To: <149369654558.5146.13818001419050826182.stgit@noble>
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Ming Lei <tom.leiming@gmail.com>,
 linux-kernel@vger.kernel.org
To: NeilBrown <neilb@suse.com>
References: <149369628671.5146.4865312503373040039.stgit@noble>
 <149369654558.5146.13818001419050826182.stgit@noble>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_F1C5794E-0860-452D-A505-00F1F0A4A157
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 2 May 2017, at 05.42, NeilBrown <neilb@suse.com> wrote:
>=20
> pblk_submit_read() uses bio_clone_bioset() but doesn't change the
> io_vec, so bio_clone_fast() is a better choice.
>=20
> It also uses fs_bio_set which is intended for filesystems.  Using it
> in a device driver can deadlock.
> So allocate a new bioset, and and use bio_clone_fast().
>=20
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
> drivers/lightnvm/pblk-init.c |   12 +++++++++++-
> drivers/lightnvm/pblk-read.c |    2 +-
> drivers/lightnvm/pblk.h      |    1 +
> 3 files changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index b3fec8ec55b8..aaefbccce30e 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -23,6 +23,7 @@
> static struct kmem_cache *pblk_blk_ws_cache, *pblk_rec_cache, =
*pblk_r_rq_cache,
> 					*pblk_w_rq_cache, =
*pblk_line_meta_cache;
> static DECLARE_RWSEM(pblk_lock);
> +struct bio_set *pblk_bio_set;
>=20
> static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
> 			  struct bio *bio)
> @@ -946,11 +947,20 @@ static struct nvm_tgt_type tt_pblk =3D {
>=20
> static int __init pblk_module_init(void)
> {
> -	return nvm_register_tgt_type(&tt_pblk);
> +	int ret;
> +
> +	pblk_bio_set =3D bioset_create(BIO_POOL_SIZE, 0, 0);
> +	if (!pblk_bio_set)
> +		return -ENOMEM;
> +	ret =3D nvm_register_tgt_type(&tt_pblk);
> +	if (ret)
> +		bioset_free(pblk_bio_set);
> +	return ret;
> }
>=20
> static void pblk_module_exit(void)
> {
> +	bioset_free(pblk_bio_set);
> 	nvm_unregister_tgt_type(&tt_pblk);
> }
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index 4a12f14d78c6..8ee0c50a7a71 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -342,7 +342,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio =
*bio)
> 		struct pblk_r_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
>=20
> 		/* Clone read bio to deal with read errors internally */
> -		int_bio =3D bio_clone_bioset(bio, GFP_KERNEL, =
fs_bio_set);
> +		int_bio =3D bio_clone_fast(bio, GFP_KERNEL, =
pblk_bio_set);
> 		if (!int_bio) {
> 			pr_err("pblk: could not clone read bio\n");
> 			return NVM_IO_ERR;
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 99f3186b5288..95b665f23925 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -702,6 +702,7 @@ void pblk_write_should_kick(struct pblk *pblk);
> /*
>  * pblk read path
>  */
> +extern struct bio_set *pblk_bio_set;
> int pblk_submit_read(struct pblk *pblk, struct bio *bio);
> int pblk_submit_read_gc(struct pblk *pblk, u64 *lba_list, void *data,
> 			unsigned int nr_secs, unsigned int *secs_to_gc,

Hi Neil,

Looks good. Thanks for fixing this. I did not know that bio_clone_bioset
was not supposed to be used on drivers.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
Tested-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_F1C5794E-0860-452D-A505-00F1F0A4A157
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZCGwPAAoJEGMfBTt1mRjK1N4P/jQwWO+7EPVR3JuoHyv7OI0G
MHQqrtq2lZZTuQOTecr81ZNohSfB+nTcOhC/nGMVnZV/2IR1k9LEkTShzNPrVdCN
xNmNsyFxm4xltYLXWc3m6IyDgZjvSXsmzS4U7fyQetgp+1WH2Sj+81YN7SdgMGoT
fWNoSmgckkcucYXF08M0ux9fpDjP6MbP/BIjiUv34bzvsTjPjcwVydU3fOwpl33X
AG4NJvqhSYc3hANg01AIVMEr5SBY3A2mG4AfMfgc91ApXlY3GsvWUS16FREkRDtd
xgLKx+fAa4iDtShUkRpu4KEyYtut++EWIy+6Gs0DiD+pOuH+9UPg0xMxP+PIQjcy
/LFvfaQY1kgGxN+VJv0L6zLrvK7I9BPi5MpeQ3fTxURUCJ+ABUOmoVCNOb78i0Nc
KQ5SgzchshK+oIcb2xhKCK7w5gawa3zi7ImUvMLIVeKeGQhsw6Xy1ecKVCwb6ieK
lRboUfLImm7LDQjt7RU1B2HvXHLKpzCmWsJ9SmQC5+D/dK8sgqNyTAs5JcN3Xtj8
Sv8QOcWuJZ/t3b/9N+VOKrk1ZcjPLJjLTK2f1vbvPofdDERoFCxQi0QgmCSISbm8
WVewiCoDUDIUqOo4uokKXwsFLGOjwt9QSPA3Y+OqrhKlB24lc1ipdTotqfMT+/DS
jOGUpAozOhwZzB7bSauL
=jRCg
-----END PGP SIGNATURE-----

--Apple-Mail=_F1C5794E-0860-452D-A505-00F1F0A4A157--
