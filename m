Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34978 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168930AbdDXLBP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2017 07:01:15 -0400
Received: by mail-wm0-f41.google.com with SMTP id w64so58466183wma.0
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2017 04:01:14 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <2364B63D-0D5D-4246-8E14-BE5230819FFC@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A203A799-4F03-4604-BE4E-719D68450B58";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] lightnvm: potential underflow in pblk_read_rq()
Date: Mon, 24 Apr 2017 13:01:10 +0200
In-Reply-To: <20170424102437.wqht5g2r2z5upyoo@mwanda>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20170421205301.3ds7jrgcktuldvrp@mwanda>
 <E2348B07-559F-4874-A3A4-C1079A2A09D2@lightnvm.io>
 <20170424102437.wqht5g2r2z5upyoo@mwanda>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_A203A799-4F03-4604-BE4E-719D68450B58
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 24 Apr 2017, at 12.24, Dan Carpenter <dan.carpenter@oracle.com> =
wrote:
>=20
> On Sat, Apr 22, 2017 at 12:24:50AM +0200, Javier Gonz=C3=A1lez wrote:
>>> On 21 Apr 2017, at 22.53, Dan Carpenter <dan.carpenter@oracle.com> =
wrote:
>>>=20
>>> This is a static checker fix, and perhaps not a real bug.  The =
static
>>> checker thinks that nr_secs could be negative.  It would result in
>>> zeroing more memory than intended.  Anyway, even if it's not a bug,
>>> changing this variable to unsigned makes the code easier to audit.
>>>=20
>>> Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) =
target")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
>>> index bce7ed5fc73f..c9daa33e8d9c 100644
>>> --- a/drivers/lightnvm/pblk-read.c
>>> +++ b/drivers/lightnvm/pblk-read.c
>>> @@ -288,7 +288,7 @@ static void pblk_read_rq(struct pblk *pblk, =
struct nvm_rq *rqd,
>>> int pblk_submit_read(struct pblk *pblk, struct bio *bio)
>>> {
>>> 	struct nvm_tgt_dev *dev =3D pblk->dev;
>>> -	int nr_secs =3D pblk_get_secs(bio);
>>> +	unsigned int nr_secs =3D pblk_get_secs(bio);
>>> 	struct nvm_rq *rqd;
>>> 	unsigned long read_bitmap; /* Max 64 ppas per request */
>>> 	unsigned int bio_init_idx;
>>=20
>> Thanks Dan. While you are at it, can you also modify the type on the
>> other 2 calls to pblk_get_secs in pblk-cache and pblk-core?
>=20
> Ugh...  My patch wasn't needed at all.  I should have looked more
> carefully.  pblk_get_secs() can only return up to UINT_MAX / 4096 so
> it can't overflow to negative.
>=20
> pblk_get_secs() should probably return sector_t instead of unsigned =
int?

Since pblk_get_secs() divides an unsigned int (bio->bi_iter.bi_size), I
think unsigned int would suffice. Why sector_t? In any case, the calls
to this function do convert the type unnecessarily and should be
changed; so I would say that your patch is still a good cleanup.

>=20
> I do get another static checker warning caused by the pblk-cache code.
> drivers/lightnvm/pblk-rl.c:30 pblk_rl_user_may_insert() XXX: potential =
integer overflow from user 'rb_user_cnt + nr_entries'
>=20

Can I ask which static checker you use? I don't see these warning
neither on sparse nor in smatch.

> It's seems like a true warning but harmless.
>=20
> drivers/lightnvm/pblk-rb.c
>   425  /*
>   426   * Atomically check that (i) there is space on the write buffer =
for the
>   427   * incoming I/O, and (ii) the current I/O type has enough =
budget in the write
>   428   * buffer (rate-limiter).
>   429   */
>   430  int pblk_rb_may_write_user(struct pblk_rb *rb, struct bio *bio,
>   431                             unsigned int nr_entries, unsigned =
int *pos)
>                                                ^^^^^^^^^^
> Assume this is very high.

This can be bigger than the reserved entries for user I/O on the write
buffer. In pblk-init, we split the bio if necessary (pblk_rw_io); I
should probably add a comment. on pblk_rl_user_may_insert().

>=20
>   432  {
>   433          struct pblk *pblk =3D container_of(rb, struct pblk, =
rwb);
>   434          int flush_done;
>   435
>   436          spin_lock(&rb->w_lock);
>   437          if (!pblk_rl_user_may_insert(&pblk->rl, nr_entries)) {
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> We can have an integer overflow in here so this passes.
>=20
>   438                  spin_unlock(&rb->w_lock);
>   439                  return NVM_IO_REQUEUE;
>   440          }
>   441
>   442          if (!pblk_rb_may_write_flush(rb, nr_entries, pos, bio, =
&flush_done)) {
>                     ^^^^^^^^^^^^^^^^^^^^^^^
> But this check won't pass, so it's harmless.

Exactly. This is related to the above.

>=20
>   443                  spin_unlock(&rb->w_lock);
>   444                  return NVM_IO_REQUEUE;
>   445          }
>   446
>   447          pblk_rl_user_in(&pblk->rl, nr_entries);
>   448          spin_unlock(&rb->w_lock);
>   449
>   450          return flush_done;
>   451  }
>=20

How do you typically get rid of these "harmless" warnings?

> regards,
> dan carpenter

Thanks,
Javier


--Apple-Mail=_A203A799-4F03-4604-BE4E-719D68450B58
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJY/dr3AAoJEGMfBTt1mRjKLkEP/jE+/uVk/6qRTWHqM3WXFe9A
WmAhK+jx0403k4CSjOl4YLeKMD5c43O9/lyg8LOOXKg54uo+t2P0TY9evpD2VeHB
LPTYoXMTBYI3AZH/AnbQqqUcLgqoFTR+SLQSTYshgW9MW+IJuj6+nmN6E1xWUIxD
uwNuQ9eIGavsIWMRc84K8dkdkc02JSjkC78FxrYJQk69FcVwTfRvPLJ2D2brLUEA
nnDjYbmzOzjKsuokc7grdcIpTDOsK/Giwz+2EI1XM1Jgobk6udIvPxoH+CA/kJrc
iHJLDcdiwsCYnVWLwREJhUIZJBVaYn/6h3xYK1KkY7l1HZXn01AemLDHzyhlcJRI
OpKO3pIPr+HXNfSIQpchuDYtbnlBGeV6cDfmN5JECJ+CJIsHqUgeCxtlkdhMX98S
LbxVDITOSCfjv6pok6QMC8PGciGDPI9kDXdH3WR2UcZETjvykOYFG14cur1f4iWv
PTCI+yRqEpV0zefluFZLwC9GZ6/cemUQFWNndMkBa56o1LAehWdr47mFmIPRYiMy
Ls1Eln0nUbgJWz6nwDKjWLrrLz0sygoQlW1+61DVsbGPp/B9gn8jQNNxKr6e5Rux
X+AXrBw6tQxAtse8CMQMZbN/GiMYHEeGuqhOMuzh1HUuF6vrZ3AetLXw87LOj1V9
fyJWHarAviTMz2iIPA2N
=l92G
-----END PGP SIGNATURE-----

--Apple-Mail=_A203A799-4F03-4604-BE4E-719D68450B58--
