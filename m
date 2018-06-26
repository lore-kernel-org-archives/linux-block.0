Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr720056.outbound.protection.outlook.com ([40.107.72.56]:23802
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933189AbeFZJhh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jun 2018 05:37:37 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "hans.ml.holmberg@owltronix.com" <hans.ml.holmberg@owltronix.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH] lightnvm: pblk: assume that chunks are closed on 1.2
 devices
Date: Tue, 26 Jun 2018 09:37:33 +0000
Message-ID: <1612C143-24C3-4B6F-B745-945EAF684DFC@cnexlabs.com>
References: <1529399189-3239-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <a2bb1959-5244-f8af-b747-6d87e8d456a4@lightnvm.io>
In-Reply-To: <a2bb1959-5244-f8af-b747-6d87e8d456a4@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_15C8F904-66A1-4CA9-911F-E01FFC596A9A";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_15C8F904-66A1-4CA9-911F-E01FFC596A9A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 26 Jun 2018, at 10.41, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 06/19/2018 11:06 AM, Hans Holmberg wrote:
>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>> We can't know if a block is closed or not on 1.2 devices, so assume
>> closed state to make sure that blocks are erased before writing.
>> Fixes: 32ef9412c114 ("lightnvm: pblk: implement get log report =
chunk")
>> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>> ---
>> This patch applies on:
>> ssh://github.com/OpenChannelSSD/linux branch for-4.19/core
>>  drivers/lightnvm/pblk-init.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>> index aa24264..3b8aa4a 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -717,10 +717,11 @@ static int pblk_setup_line_meta_12(struct pblk =
*pblk, struct pblk_line *line,
>>    		/*
>>  		 * In 1.2 spec. chunk state is not persisted by the =
device. Thus
>> -		 * some of the values are reset each time pblk is =
instantiated.
>> +		 * some of the values are reset each time pblk is =
instantiated,
>> +		 * so we have to assume that the block is closed.
>>  		 */
>>  		if (lun_bb_meta[line->id] =3D=3D NVM_BLK_T_FREE)
>> -			chunk->state =3D  NVM_CHK_ST_FREE;
>> +			chunk->state =3D  NVM_CHK_ST_CLOSED;
>>  		else
>>  			chunk->state =3D NVM_CHK_ST_OFFLINE;
>>=20
>=20
> pblk should scan (or the lightnvm subsystem) the blocks for their
> state, such that it doesn't have to reinitialize a full drive if it is
> already in a closed state. If marking closed, it does a full erase
> cycle on initialization, which should be avoided since it is a limited
> resource.

In 1.2 there is no such state unfortunately. However, pblk will never
attempt to reinitialize the whole drive - metadata for closed blocks
will be recovered and only those going to GC will be erased before
usage. In fact, a full close drive is the state pblk expects.

This patch only affects "unknown blocks", thus the only case in which
pblk would attempt to double erase is when blocks have been pre-erased
(e.g., factory or through liblightnvm). After an erase round though,
pblk will only erase pre-usage. One thing we could do is attempting to
read the first page of these unknown blocks and mark them as free if
"empty page" is returned. Is this what you mean? Note that this can be
costly on large drives; this is the reason we returned to the pre-2.0
behaviour with this patch. We are implementing a log that, among other
things, keeps the state so that pblk can have an accurate state for the
cases this can be a problem.

Javier

--Apple-Mail=_15C8F904-66A1-4CA9-911F-E01FFC596A9A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlsyCVoACgkQIX4xUKFR
nnRs8A/+NlK7hPfhxlTp/bzfgVEX6M8kNhygjz5EWpr6gkBIyd14V0yTaCPqMtUi
seUoIMqNTyF71Pyi/CXz886p0fHkYBODl4xF/uPHXia3YliVFFq4aeMetIlNoUWc
jVGdMOsdEXIy9NRETbv5B5wJ1IQf65fcV7mA1C0Ikd9Y2PKlx2xRJRPgeAv1Blnu
QFZTeKDJEKF6jrI09apdJsvp9qr0dBcGJ/amt6GQh/wVIekvjeqxLMwaDay7S4iJ
mpBcLp+bnwaKUw++vYpHlkFilYRz6jundzbUlgtolf/yITAmzDYii9ODVVn7wVuU
t0t7jAPp9L+VCYtXBFnhhA3znM8YsH5xlBnHOPYRWKfrBNcEZMYB4SUepjg8KQv5
8o1eWjxnxffaUR/ASXsTMfq/zLEoogamdxcdcScFTKBFvly1vtURdct0GAxTR3vw
Bv+eAkDOSF+GiVs24ws7fyA1o+O3ExArioSb8x50+OsJWx7l84lwB3g+dkC0VbEq
YWA087nFuF4SLbuTgZAzX3qFohnGwzWuTy3sJ2GWtDQMbEeD6V05gFhLInsp+yzX
8b4eKy4hEY+Uf3S8GKx4pg3Gth4RmilThgODYWS54z000DJQsHftz+tFRdKsnfp+
uaG+PIxkymJj4RkwOGK+gG3W1OOp/SH+NykEPs+beBHoEI6+OsM=
=lXkH
-----END PGP SIGNATURE-----

--Apple-Mail=_15C8F904-66A1-4CA9-911F-E01FFC596A9A--
