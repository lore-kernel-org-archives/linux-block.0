Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:46970 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbdIVKFA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 06:05:00 -0400
Received: by mail-wm0-f42.google.com with SMTP id m72so2414548wmc.1
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2017 03:04:59 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <A4A5F4C3-95EF-48B3-9E92-021181A692BF@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8DB50B07-000F-4E91-A4A0-CE3631BDF418";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/6] lightnvm: pblk: reuse pblk_gc_should_kick
Date: Fri, 22 Sep 2017 12:04:57 +0200
In-Reply-To: <20170922094213.GA31904@dhcp-216.srv.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20170921112539.GA28510@dhcp-216.srv.tuxera.com>
 <BBF0A7B6-682D-45C7-A087-4072F5B101CE@lightnvm.io>
 <20170922094213.GA31904@dhcp-216.srv.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_8DB50B07-000F-4E91-A4A0-CE3631BDF418
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 22 Sep 2017, at 11.42, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> On Fri, Sep 22, 2017 at 10:40:57AM +0200, Javier Gonz=C3=A1lez wrote:
>>> On 21 Sep 2017, at 13.25, Rakesh Pandit wrote:
>>>=20
>>> This is a trivial change which reuses pblk_gc_should_kick instead of
>>> repeating it again in pblk_rl_free_lines_inc.
>>>=20
>>> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
>>> ---
>>> drivers/lightnvm/pblk-core.c | 1 +
>>> drivers/lightnvm/pblk-rl.c   | 9 ---------
>>> 2 files changed, 1 insertion(+), 9 deletions(-)
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>>> index 64a6a25..a230125 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -1478,6 +1478,7 @@ static void __pblk_line_put(struct pblk *pblk, =
struct pblk_line *line)
>>> 	spin_unlock(&l_mg->free_lock);
>>>=20
>>> 	pblk_rl_free_lines_inc(&pblk->rl, line);
>>> +	pblk_gc_should_kick(pblk);
>>> }
>>>=20
>>> static void pblk_line_put_ws(struct work_struct *work)
>>> diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
>>> index 596bdec..e7c162a 100644
>>> --- a/drivers/lightnvm/pblk-rl.c
>>> +++ b/drivers/lightnvm/pblk-rl.c
>>> @@ -129,18 +129,9 @@ static int pblk_rl_update_rates(struct pblk_rl =
*rl, unsigned long max)
>>>=20
>>> void pblk_rl_free_lines_inc(struct pblk_rl *rl, struct pblk_line =
*line)
>>> {
>>> -	struct pblk *pblk =3D container_of(rl, struct pblk, rl);
>>> 	int blk_in_line =3D atomic_read(&line->blk_in_line);
>>> -	int ret;
>>>=20
>>> 	atomic_add(blk_in_line, &rl->free_blocks);
>>> -	/* Rates will not change that often - no need to lock update */
>>> -	ret =3D pblk_rl_update_rates(rl, rl->rb_budget);
>>> -
>>> -	if (ret =3D=3D (PBLK_RL_MID | PBLK_RL_LOW))
>>> -		pblk_gc_should_start(pblk);
>>> -	else
>>> -		pblk_gc_should_stop(pblk);
>>> }
>>>=20
>>> void pblk_rl_free_lines_dec(struct pblk_rl *rl, struct pblk_line =
*line)
>>> --
>>> 2.5.0
>>=20
>> Looking at the patch, I can see that a more general cleanup can be =
done.
>> What do you think about this? We can merge it in this patch if you =
are OK
>> with it.
>=20
> Makes more sense. Feel free to merge. You have my Signed-off-by tag.

We'll merge it with your patch, which was the original cleanup.

Matias: can you pick the code in the patch below instead?

>=20
>> =46rom 944936663c7eef7bc32243b89cc554e40ec436c5 Mon Sep 17 00:00:00 =
2001
>> From: Rakesh Pandit <rakesh@tuxera.com>
>> Date: Thu, 21 Sep 2017 14:25:40 +0300
>> Subject: [PATCH] lightnvm: pblk: reuse pblk_gc_should_kick
>>=20
>> This is a trivial change which reuses pblk_gc_should_kick instead of
>> repeating it again in pblk_rl_free_lines_inc.
>>=20
>> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
>> ---
>> drivers/lightnvm/pblk-core.c |  2 --
>> drivers/lightnvm/pblk-rl.c   | 33 +++++++++------------------------
>> drivers/lightnvm/pblk.h      |  1 -
>> 3 files changed, 9 insertions(+), 27 deletions(-)
>>=20
>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>> index 64a6a255514e..c92113b0a2e7 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -1633,8 +1633,6 @@ void pblk_line_close(struct pblk *pblk, struct =
pblk_line *line)
>>=20
>> 	spin_unlock(&line->lock);
>> 	spin_unlock(&l_mg->gc_lock);
>> -
>> -	pblk_gc_should_kick(pblk);
>> }
>>=20
>> void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
>> diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
>> index 596bdec433c3..0896439a91b0 100644
>> --- a/drivers/lightnvm/pblk-rl.c
>> +++ b/drivers/lightnvm/pblk-rl.c
>> @@ -96,9 +96,11 @@ unsigned long pblk_rl_nr_free_blks(struct pblk_rl =
*rl)
>>  *
>>  * Only the total number of free blocks is used to configure the rate =
limiter.
>>  */
>> -static int pblk_rl_update_rates(struct pblk_rl *rl, unsigned long =
max)
>> +static void pblk_rl_update_rates(struct pblk_rl *rl)
>> {
>> +	struct pblk *pblk =3D container_of(rl, struct pblk, rl);
>> 	unsigned long free_blocks =3D pblk_rl_nr_free_blks(rl);
>> +	int max =3D rl->rb_budget;
>>=20
>> 	if (free_blocks >=3D rl->high) {
>> 		rl->rb_user_max =3D max;
>> @@ -124,23 +126,18 @@ static int pblk_rl_update_rates(struct pblk_rl =
*rl, unsigned long max)
>> 		rl->rb_state =3D PBLK_RL_LOW;
>> 	}
>>=20
>> -	return rl->rb_state;
>> +	if (rl->rb_state =3D=3D (PBLK_RL_MID | PBLK_RL_LOW))
>> +		pblk_gc_should_start(pblk);
>> +	else
>> +		pblk_gc_should_stop(pblk);
>> }
>>=20
>> void pblk_rl_free_lines_inc(struct pblk_rl *rl, struct pblk_line =
*line)
>> {
>> -	struct pblk *pblk =3D container_of(rl, struct pblk, rl);
>> 	int blk_in_line =3D atomic_read(&line->blk_in_line);
>> -	int ret;
>>=20
>> 	atomic_add(blk_in_line, &rl->free_blocks);
>> -	/* Rates will not change that often - no need to lock update */
>> -	ret =3D pblk_rl_update_rates(rl, rl->rb_budget);
>> -
>> -	if (ret =3D=3D (PBLK_RL_MID | PBLK_RL_LOW))
>> -		pblk_gc_should_start(pblk);
>> -	else
>> -		pblk_gc_should_stop(pblk);
>> +	pblk_rl_update_rates(rl);
>> }
>>=20
>> void pblk_rl_free_lines_dec(struct pblk_rl *rl, struct pblk_line =
*line)
>> @@ -148,19 +145,7 @@ void pblk_rl_free_lines_dec(struct pblk_rl *rl, =
struct pblk_line *line)
>> 	int blk_in_line =3D atomic_read(&line->blk_in_line);
>>=20
>> 	atomic_sub(blk_in_line, &rl->free_blocks);
>> -}
>> -
>> -void pblk_gc_should_kick(struct pblk *pblk)
>> -{
>> -	struct pblk_rl *rl =3D &pblk->rl;
>> -	int ret;
>> -
>> -	/* Rates will not change that often - no need to lock update */
>> -	ret =3D pblk_rl_update_rates(rl, rl->rb_budget);
>> -	if (ret =3D=3D (PBLK_RL_MID | PBLK_RL_LOW))
>> -		pblk_gc_should_start(pblk);
>> -	else
>> -		pblk_gc_should_stop(pblk);
>> +	pblk_rl_update_rates(rl);
>> }
>>=20
>> int pblk_rl_high_thrs(struct pblk_rl *rl)
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index eaf539715d71..d4b7dee0ef50 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -829,7 +829,6 @@ int pblk_gc_init(struct pblk *pblk);
>> void pblk_gc_exit(struct pblk *pblk);
>> void pblk_gc_should_start(struct pblk *pblk);
>> void pblk_gc_should_stop(struct pblk *pblk);
>> -void pblk_gc_should_kick(struct pblk *pblk);
>> void pblk_gc_kick(struct pblk *pblk);
>> void pblk_gc_sysfs_state_show(struct pblk *pblk, int *gc_enabled,
>> 			      int *gc_active);
>> --
>> 2.7.4

--Apple-Mail=_8DB50B07-000F-4E91-A4A0-CE3631BDF418
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZxOBJAAoJEGMfBTt1mRjKMDEP/i2dbX78BXf5TQLe7e0TV3Fg
YqWns8HtQccrZlVn/QtJhqk6+uafIUWne5k0Y+ZxtQOquQiyymFgKMuVHo2rP+32
KWycDgc/dEdWhwFDynUWZFhUsFEMBjUybNzTEFxCBmuLHxLdfFP6blYL6qHIxSv7
kPOiNxgFwUuEZQnWwRWS1lhFmQnDBd6fh31nLIiqJlKRtIaLx+ZOV14WCp6dfRZq
6N88B63tIpfCf2NCFcNWLUK268vUqG60swdpPvbmkvrtU1CfdTNhIjRoTAMPH6Uu
3ZI5ufiAd1K7+rN7szWbve2DlPdhqQBHs4hXM/NRSQGFjyxRVnNyeDlN8gnkAShA
5TAvsBFVWb4wsEZZOsN5z094cb/x9/eIQHz3h6ReDb9AYSin7pcKpD6v5L/NBPXb
3uLND4gZg+iqlQbXU8ykl3+2zefxg7doEiQeQ2pD7A6bgByO/b+uepx4m1KyEc4C
tCviKzjYP9ilq7rqgYG90Du5a/GfksMt4CFU/9+4mCACBPhpBkxlTdThM8b4iZht
cryp8IAXl+3lxejskVUFuli/ZwoP1iuRXAcjaR0QUL0foI0sIKEGoRi1/T8Q6DBS
keiqzr8qkJOHI2hvd2ChQ88yeZfH4z6mHSadNTQTOedaKmBvhUgbNjXLrZcx3K48
kzgv6yogkDTOFXoUiivn
=NnpC
-----END PGP SIGNATURE-----

--Apple-Mail=_8DB50B07-000F-4E91-A4A0-CE3631BDF418--
