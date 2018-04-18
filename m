Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:41948 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbeDRL4u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Apr 2018 07:56:50 -0400
Received: by mail-io0-f193.google.com with SMTP id o7-v6so233055iob.8
        for <linux-block@vger.kernel.org>; Wed, 18 Apr 2018 04:56:50 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <EEDD4DC1-9DB6-441C-89EB-39B8723959DD@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_4CF863C9-B1B8-4FCB-9000-E90AF17F3FF1";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] lightnvm: pblk: take bitmap alloc. out of critical
 section
Date: Wed, 18 Apr 2018 04:56:39 -0700
In-Reply-To: <76bed955-2e70-7540-0836-f93fbd677d7e@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <1523874066-4459-1-git-send-email-javier@cnexlabs.com>
 <76bed955-2e70-7540-0836-f93fbd677d7e@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_4CF863C9-B1B8-4FCB-9000-E90AF17F3FF1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 17 Apr 2018, at 04.48, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 4/16/18 12:21 PM, Javier Gonz=C3=A1lez wrote:
>> Allocate line bitmaps outside of the line lock on line preparation.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>=20
>=20
> The patch description tells what the patch does, it should tell why
> the change the done.
>=20

Taking an allocation out of a critical zone should be a reason on =
itself.

>> ---
>>  drivers/lightnvm/pblk-core.c | 96 =
+++++++++++++++++++++++++-------------------
>>  1 file changed, 55 insertions(+), 41 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>> index 5f960a6609c8..7762e89984ee 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -1058,6 +1058,25 @@ static int pblk_line_init_metadata(struct pblk =
*pblk, struct pblk_line *line,
>>  	return 1;
>>  }
>>  +static int pblk_line_alloc_bitmaps(struct pblk *pblk, struct =
pblk_line *line)
>> +{
>> +	struct pblk_line_meta *lm =3D &pblk->lm;
>> +
>> +	line->map_bitmap =3D kzalloc(lm->sec_bitmap_len, GFP_KERNEL);
>> +	if (!line->map_bitmap)
>> +		return -ENOMEM;
>> +
>> +	/* will be initialized using bb info from map_bitmap */
>> +	line->invalid_bitmap =3D kmalloc(lm->sec_bitmap_len, =
GFP_KERNEL);
>> +	if (!line->invalid_bitmap) {
>> +		kfree(line->map_bitmap);
>> +		line->map_bitmap =3D NULL;
>> +		return -ENOMEM;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  /* For now lines are always assumed full lines. Thus, smeta former =
and current
>>   * lun bitmaps are omitted.
>>   */
>> @@ -1162,18 +1181,7 @@ static int pblk_line_prepare(struct pblk =
*pblk, struct pblk_line *line)
>>  {
>>  	struct pblk_line_meta *lm =3D &pblk->lm;
>>  	int blk_in_line =3D atomic_read(&line->blk_in_line);
>> -	int blk_to_erase, ret;
>> -
>> -	line->map_bitmap =3D kzalloc(lm->sec_bitmap_len, GFP_ATOMIC);
>> -	if (!line->map_bitmap)
>> -		return -ENOMEM;
>> -
>> -	/* will be initialized using bb info from map_bitmap */
>> -	line->invalid_bitmap =3D kmalloc(lm->sec_bitmap_len, =
GFP_ATOMIC);
>> -	if (!line->invalid_bitmap) {
>> -		ret =3D -ENOMEM;
>> -		goto fail_free_map_bitmap;
>> -	}
>> +	int blk_to_erase;
>>    	/* Bad blocks do not need to be erased */
>>  	bitmap_copy(line->erase_bitmap, line->blk_bitmap, =
lm->blk_per_line);
>> @@ -1191,15 +1199,15 @@ static int pblk_line_prepare(struct pblk =
*pblk, struct pblk_line *line)
>>  	}
>>    	if (blk_in_line < lm->min_blk_line) {
>> -		ret =3D -EAGAIN;
>> -		goto fail_free_invalid_bitmap;
>> +		spin_unlock(&line->lock);
>> +		return -EAGAIN;
>>  	}
>>    	if (line->state !=3D PBLK_LINESTATE_FREE) {
>>  		WARN(1, "pblk: corrupted line %d, state %d\n",
>>  							line->id, =
line->state);
>> -		ret =3D -EINTR;
>> -		goto fail_free_invalid_bitmap;
>> +		spin_unlock(&line->lock);
>> +		return -EINTR;
>>  	}
>>    	line->state =3D PBLK_LINESTATE_OPEN;
>> @@ -1213,16 +1221,6 @@ static int pblk_line_prepare(struct pblk =
*pblk, struct pblk_line *line)
>>  	kref_init(&line->ref);
>>    	return 0;
>> -
>> -fail_free_invalid_bitmap:
>> -	spin_unlock(&line->lock);
>> -	kfree(line->invalid_bitmap);
>> -	line->invalid_bitmap =3D NULL;
>> -fail_free_map_bitmap:
>> -	kfree(line->map_bitmap);
>> -	line->map_bitmap =3D NULL;
>> -
>> -	return ret;
>>  }
>>    int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line =
*line)
>> @@ -1242,13 +1240,15 @@ int pblk_line_recov_alloc(struct pblk *pblk, =
struct pblk_line *line)
>>  	}
>>  	spin_unlock(&l_mg->free_lock);
>>  -	pblk_rl_free_lines_dec(&pblk->rl, line, true);
>> +	if (pblk_line_alloc_bitmaps(pblk, line))
>> +		return -EINTR;
>=20
> Why return -EINTR, instead of the return value from (0, -ENOMEM) from =
pblk_line_alloc_bitmap?

Sure.

>=20
>=20
>>    	if (!pblk_line_init_bb(pblk, line, 0)) {
>>  		list_add(&line->list, &l_mg->free_list);
>>  		return -EINTR;
>>  	}
>>  +	pblk_rl_free_lines_dec(&pblk->rl, line, true);
>>  	return 0;
>>  }
>>  @@ -1260,6 +1260,24 @@ void pblk_line_recov_close(struct pblk *pblk, =
struct pblk_line *line)
>>  	line->emeta =3D NULL;
>>  }
>>  +static void pblk_line_clear(struct pblk_line *line)
>> +{
>> +	*line->vsc =3D cpu_to_le32(EMPTY_ENTRY);
>> +
>> +	line->map_bitmap =3D NULL;
>> +	line->invalid_bitmap =3D NULL;
>> +	line->smeta =3D NULL;
>> +	line->emeta =3D NULL;
>> +}
>=20
> Instead of pblk_line_clear, how about pblk_line_reinit?

Emmmmm... yes, why not.

I'll resend.

Javier

--Apple-Mail=_4CF863C9-B1B8-4FCB-9000-E90AF17F3FF1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlrXMngACgkQPEYBfS0l
eOBMqg/+LIr6QhGVp/H+pftufFk4rB9QO+0hUjsOgRLLj5YUf8b6LQpu7P3gzpAO
BSF3A2Ef+kf3C/D2xlzqGTAeWEvfWNKVjPJ7xWmVPo+PO13ayxG6kBGbxwyFevm8
egA6kfYZxrSFQwJaxtALphW0YQRQ6NxB9PDgAiyrXqbyljPT42QTMCvCrxHno9yg
6TM3lWb1LRVMhJygJ4U6j1nvW3Cga84CzUDXn7hJqdgGuMUn/y1wjWVQYSdZoJhU
Oy85hWgxb2vYo1R7LgJw1ycDxe51IZl9keBaoodyEZJ4ECn2c1Z8pna9WIy2F1jd
RImv5dwAN7fYYy6GS5aNlyDVMqNetAJ5lAzP1AmnwFZjaeaM6GMXSl/hkwia55kA
S/AWGmiOy9QxzhGecxy+2Moyv/8pm86pS8mtjVvSyIts/AqMfLhr0DbVI8ou7zFP
/dCtGnlRFJEMyiD9ma398919U4sQjjMDt1yncEhVDVyd8bWFrNPAD6x1WL5mqJsm
t8FKnlAIgYLDUgWwsLJ+W1kqPq2qFveGqayiEBpXIACgzCoX9z4t2QH12q6whOu+
GJpiP5D7GAse5Ma+WSJ8xvfXOGpvTE4MwDnX/tHWOQgDEWXJCUzfc2d7VquMtq8C
iR+F9YwUJo5IYJx9GptSE5vyOlnUl4vE5kqiAj6aWDEsbV4Ue4g=
=CVen
-----END PGP SIGNATURE-----

--Apple-Mail=_4CF863C9-B1B8-4FCB-9000-E90AF17F3FF1--
