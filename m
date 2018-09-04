Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bl2nam02on0057.outbound.protection.outlook.com ([104.47.38.57]:62176
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726304AbeIDWSj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Sep 2018 18:18:39 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH] lightnvm: pblk: Fix two sleep-in-atomic-context bugs in
 pblk_line_submit_smeta_io()
Date: Tue, 4 Sep 2018 17:52:20 +0000
Message-ID: <EFBE4E08-0A3E-442B-BD23-4E79042D2A05@cnexlabs.com>
References: <20180901115318.30416-1-baijiaju1990@gmail.com>
 <cbff381f-c2c7-5656-b121-eb1ec3c75da4@lightnvm.io>
In-Reply-To: <cbff381f-c2c7-5656-b121-eb1ec3c75da4@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1744A098-40AB-4C92-B286-0BC782ED5CE4";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_1744A098-40AB-4C92-B286-0BC782ED5CE4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 4 Sep 2018, at 03.11, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 09/01/2018 01:53 PM, Jia-Ju Bai wrote:
>> The driver may sleep with holding a spinlock.
>> The function call paths (from bottom to top) in Linux-4.16 are:
>> [FUNC] nvm_dev_dma_alloc(GFP_KERNEL)
>> drivers/lightnvm/pblk-core.c, 754:
>> 	nvm_dev_dma_alloc in pblk_line_submit_smeta_io
>> drivers/lightnvm/pblk-core.c, 1048:
>> 	pblk_line_submit_smeta_io in pblk_line_init_bb
>> drivers/lightnvm/pblk-core.c, 1434:
>> 	pblk_line_init_bb in pblk_line_replace_data
>> drivers/lightnvm/pblk-recovery.c, 980:
>> 	pblk_line_replace_data in pblk_recov_l2p
>> drivers/lightnvm/pblk-recovery.c, 976:
>> 	spin_lock in pblk_recov_l2p
>> [FUNC] bio_map_kern(GFP_KERNEL)
>> drivers/lightnvm/pblk-core.c, 762:
>> 	bio_map_kern in pblk_line_submit_smeta_io
>> drivers/lightnvm/pblk-core.c, 1048:
>> 	pblk_line_submit_smeta_io in pblk_line_init_bb
>> drivers/lightnvm/pblk-core.c, 1434:
>> 	pblk_line_init_bb in pblk_line_replace_data
>> drivers/lightnvm/pblk-recovery.c, 980:
>> 	pblk_line_replace_data in pblk_recov_l2p
>> drivers/lightnvm/pblk-recovery.c, 976:
>> 	spin_lock in pblk_recov_l2p
>> To fix these bugs, GFP_KERNEL is replaced with GFP_ATOMIC.
>> These bugs are found by my static analysis tool DSAC.
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>  drivers/lightnvm/pblk-core.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>> index ed9cc977c8b3..5d915c93b6cf 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -802,7 +802,7 @@ static int pblk_line_submit_smeta_io(struct pblk =
*pblk, struct pblk_line *line,
>>    	memset(&rqd, 0, sizeof(struct nvm_rq));
>>  -	rqd.meta_list =3D nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
>> +	rqd.meta_list =3D nvm_dev_dma_alloc(dev->parent, GFP_ATOMIC,
>>  							=
&rqd.dma_meta_list);
>>  	if (!rqd.meta_list)
>>  		return -ENOMEM;
>> @@ -810,7 +810,7 @@ static int pblk_line_submit_smeta_io(struct pblk =
*pblk, struct pblk_line *line,
>>  	rqd.ppa_list =3D rqd.meta_list + pblk_dma_meta_size;
>>  	rqd.dma_ppa_list =3D rqd.dma_meta_list + pblk_dma_meta_size;
>>  -	bio =3D bio_map_kern(dev->q, line->smeta, lm->smeta_len, =
GFP_KERNEL);
>> +	bio =3D bio_map_kern(dev->q, line->smeta, lm->smeta_len, =
GFP_ATOMIC);
>>  	if (IS_ERR(bio)) {
>>  		ret =3D PTR_ERR(bio);
>>  		goto free_ppa_list;
>=20
> Javier,
>=20
> What do you think? I'm OK with applying this, but one could also move
> the allocs outside the spinlocks?
>=20

Definitely better to take the allocation out of the spin_lock(), as all
line preparations are made to be lock free.

It is fairly simple to fix this, as it only occurs when calling
pblk_line_replace_data() from pblk_recov_l2p(). Here the lock can be
inside the if statement to only cover text_and_clear_bit() and to the
else statement to cover it entirely.

 Jia-Ju Bai: Do you want to send a patch for this?

Javier


--Apple-Mail=_1744A098-40AB-4C92-B286-0BC782ED5CE4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluOxlEACgkQIX4xUKFR
nnRo3hAA0ZGAPPnJxhW6SMjH5/yB8A5nabULhPizelMfCcqZz6wkCnkY9GHD1rXp
nqsxdwtgt29e9zkDviaJdAylwAtk2nhho1RoJWy4n4bp4HYq+NbQSpEt78P9rDTg
za9eGJ2jrx42rwgZZwVRIACMb0w6TSH8btMTv4yWFcXiD1vjBM1QEaX8W/S+wa46
JDuEfl6/aaOTgwZFsydr6JOiNq5AhUrU483oMHxdaqf5F2rqucoEyWfYiWBA5JBp
2khI89E+a00CJvPtOtRYTeUJiL9KePawWM8snR0BS3/KIrCsZXGhjH+xI6GxJAvU
OrBiYswX8zP7CjjVVh6csIBwcFvN+N7jxZyHpeub0rhaosMxPgP1g7GRABMEKnD/
uirEwWEC30z0myRYBLqG3rDjd50PcItqCWfN5G28NCAgDXdcQJof+DmQADcVhVb5
718umU/6LI7FMKlAS9MlqhJA+hYtK253kdWv+XIjH1rIIsnaiuqLOAg6XhAxDjmT
bFHU+lauDD7VSISRJHoeGMDXWkfPZWBxC5b41U9wrMyfGPCf3ecSVIMK9MVBYf8L
Kx+Xq7ixoBbLJm4gWRDNpjAAfa8oD7ND+v1dcy1axzYqlajQWuyiASgbulEYt2ls
wYOhK4GuM9uLZlurcjX3fv7Aeiu+sW8QKg2iwcXHD1JXGgUwWfs=
=tsYy
-----END PGP SIGNATURE-----

--Apple-Mail=_1744A098-40AB-4C92-B286-0BC782ED5CE4--
