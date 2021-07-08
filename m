Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE32C07E96
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 13:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85EC96147D
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 13:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhGHNRI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jul 2021 09:17:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49840 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhGHNRI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Jul 2021 09:17:08 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 91BB022360;
        Thu,  8 Jul 2021 13:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625750065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kjDxg716BeRs2qtkJRO5dJhtTxFQMs1Qz7BRV05AbBo=;
        b=JbRdunVsKhyiVVBCo8yMgJQKvZpa5rMbzks6AVmCpSyppVRrYJBCrq2uPHRVMi9+QXBsdF
        DIsyBIzkB6codFI98AJt3j6MOUMCRKVb7cGf7TDfT0EcgGFtJx0/J+97cnxQpbYyyFMGnt
        yDwCVoelae67WiglcvOVtpIZpldRzdE=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4A36F1338E;
        Thu,  8 Jul 2021 13:14:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 7uMMEDH65mAYagAAGKfGzw
        (envelope-from <jgross@suse.com>); Thu, 08 Jul 2021 13:14:25 +0000
Subject: Re: [PATCH v2 3/3] xen/blkfront: don't trust the backend response
 data blindly
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20210708124345.10173-1-jgross@suse.com>
 <20210708124345.10173-4-jgross@suse.com>
 <c33d7570-d986-749d-1e4f-85829a11babb@suse.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <49aa4ddb-ca58-e0df-0675-daa72866d3db@suse.com>
Date:   Thu, 8 Jul 2021 15:14:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c33d7570-d986-749d-1e4f-85829a11babb@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GZlw9XRimbRflKEqbIeJ6AKoGzpNRdN8y"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GZlw9XRimbRflKEqbIeJ6AKoGzpNRdN8y
Content-Type: multipart/mixed; boundary="vTD9BTL08Q22LyNlkVoVSug6qRFaht5uE";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Message-ID: <49aa4ddb-ca58-e0df-0675-daa72866d3db@suse.com>
Subject: Re: [PATCH v2 3/3] xen/blkfront: don't trust the backend response
 data blindly
References: <20210708124345.10173-1-jgross@suse.com>
 <20210708124345.10173-4-jgross@suse.com>
 <c33d7570-d986-749d-1e4f-85829a11babb@suse.com>
In-Reply-To: <c33d7570-d986-749d-1e4f-85829a11babb@suse.com>

--vTD9BTL08Q22LyNlkVoVSug6qRFaht5uE
Content-Type: multipart/mixed;
 boundary="------------A72E68CB9B686B2D3C20F643"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A72E68CB9B686B2D3C20F643
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 08.07.21 15:11, Jan Beulich wrote:
> On 08.07.2021 14:43, Juergen Gross wrote:
>> Today blkfront will trust the backend to send only sane response data.=

>> In order to avoid privilege escalations or crashes in case of maliciou=
s
>> backends verify the data to be within expected limits. Especially make=

>> sure that the response always references an outstanding request.
>>
>> Introduce a new state of the ring BLKIF_STATE_ERROR which will be
>> switched to in case an inconsistency is being detected. Recovering fro=
m
>> this state is possible only via removing and adding the virtual device=

>> again (e.g. via a suspend/resume cycle).
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>=20
> Reviewed-by: Jan Beulich <jbeulich@suse.com>
> albeit ...
>=20
>> @@ -1602,7 +1628,8 @@ static irqreturn_t blkif_interrupt(int irq, void=
 *dev_id)
>>   		case BLKIF_OP_DISCARD:
>>   			if (unlikely(bret.status =3D=3D BLKIF_RSP_EOPNOTSUPP)) {
>>   				struct request_queue *rq =3D info->rq;
>> -				printk(KERN_WARNING "blkfront: %s: %s op failed\n",
>> +
>> +				pr_warn_ratelimited("blkfront: %s: %s op failed\n",
>>   					   info->gd->disk_name, op_name(bret.operation));
>>   				blkif_req(req)->error =3D BLK_STS_NOTSUPP;
>>   				info->feature_discard =3D 0;
>> @@ -1614,13 +1641,13 @@ static irqreturn_t blkif_interrupt(int irq, vo=
id *dev_id)
>>   		case BLKIF_OP_FLUSH_DISKCACHE:
>>   		case BLKIF_OP_WRITE_BARRIER:
>>   			if (unlikely(bret.status =3D=3D BLKIF_RSP_EOPNOTSUPP)) {
>> -				printk(KERN_WARNING "blkfront: %s: %s op failed\n",
>> +				pr_warn_ratelimited("blkfront: %s: %s op failed\n",
>>   				       info->gd->disk_name, op_name(bret.operation));
>>   				blkif_req(req)->error =3D BLK_STS_NOTSUPP;
>>   			}
>>   			if (unlikely(bret.status =3D=3D BLKIF_RSP_ERROR &&
>>   				     rinfo->shadow[id].req.u.rw.nr_segments =3D=3D 0)) {
>> -				printk(KERN_WARNING "blkfront: %s: empty %s op failed\n",
>> +				pr_warn_ratelimited("blkfront: %s: empty %s op failed\n",
>>   				       info->gd->disk_name, op_name(bret.operation));
>>   				blkif_req(req)->error =3D BLK_STS_NOTSUPP;
>>   			}
>> @@ -1635,8 +1662,8 @@ static irqreturn_t blkif_interrupt(int irq, void=
 *dev_id)
>>   		case BLKIF_OP_READ:
>>   		case BLKIF_OP_WRITE:
>>   			if (unlikely(bret.status !=3D BLKIF_RSP_OKAY))
>> -				dev_dbg(&info->xbdev->dev, "Bad return from blkdev data "
>> -					"request: %x\n", bret.status);
>> +				dev_dbg_ratelimited(&info->xbdev->dev,
>> +					"Bad return from blkdev data request: %x\n", bret.status);
>>  =20
>>   			break;
>>   		default:
>=20
> ... all of these look kind of unrelated to the topic of the patch,
> and the conversion also isn't mentioned as on-purpose in the
> description.

Hmm, yes, I'll add a sentence to the commit message.


Juergen


--------------A72E68CB9B686B2D3C20F643
Content-Type: application/pgp-keys;
 name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Transfer-Encoding: quoted-printable
Content-Description: OpenPGP public key
Content-Disposition: attachment;
 filename="OpenPGP_0xB0DE9DD628BF132F.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOBy=
cWx
w3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJvedYm8O=
f8Z
d621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y=
9bf
IhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xq=
G7/
377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR=
3Jv
c3MgPGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsEFgIDA=
QIe
AQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4FUGNQH2lvWAUy+dnyT=
hpw
dtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3TyevpB0CA3dbBQp0OW0fgCetToGIQrg0=
MbD
1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbv=
oPH
Z8SlM4KWm8rG+lIkGurqqu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v=
5QL
+qHI3EIPtyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVyZ=
2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJCAcDAgEGFQgCC=
QoL
BBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4RF7HoZhPVPogNVbC4YA6lW7Dr=
Wf0
teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz78X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC=
/nu
AFVGy+67q2DH8As3KPu0344TBDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0Lh=
ITT
d9jLzdDad1pQSToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLm=
XBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkMnQfvUewRz=
80h
SnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMBAgAjBQJTjHDXAhsDBwsJC=
AcD
AgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJn=
FOX
gMLdBQgBlVPO3/D9R8LtF9DBAFPNhlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1=
jnD
kfJZr6jrbjgyoZHiw/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0=
N51
N5JfVRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwPOoE+l=
otu
fe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK/1xMI3/+8jbO0tsn1=
tqS
EUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuZGU+wsB5BBMBAgAjBQJTjHDrA=
hsD
BwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3=
g3O
ZUEBmDHVVbqMtzwlmNC4k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5=
dM7
wRqzgJpJwK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu5=
D+j
LRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzBTNh30FVKK1Evm=
V2x
AKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37IoN1EblHI//x/e2AaIHpzK5h88N=
Eaw
QsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpW=
nHI
s98ndPUDpnoxWQugJ6MpMncr0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZR=
wgn
BC5mVM6JjQ5xDk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNV=
bVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mmwe0icXKLk=
pEd
IXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0Iv3OOImwTEe4co3c1mwARA=
QAB
wsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMvQ/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEw=
Tbe
8YFsw2V/Buv6Z4Mysln3nQK5ZadD534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1=
vJz
Q1fOU8lYFpZXTXIHb+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8=
VGi
wXvTyJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqcsuylW=
svi
uGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5BjR/i1DG86lem3iBDX=
zXs
ZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------A72E68CB9B686B2D3C20F643--

--vTD9BTL08Q22LyNlkVoVSug6qRFaht5uE--

--GZlw9XRimbRflKEqbIeJ6AKoGzpNRdN8y
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmDm+jAFAwAAAAAACgkQsN6d1ii/Ey9U
qwgAkr0wNLGpOOsrdkkQSuu01w0EXUKmCsaY0frdbjaBvlyymrbtIlFUGKElPVo6uVMymxdXQwuQ
CXN1fm4UhG4IRUTeewD561qAQtOcxRl5s0wOSTs6FszzntEMPioHM2EcslKf2g9MWeSy5HxWClbd
nmvqFApYxTQLI7zn1tyeye5f/ogOqbi47pz7SS9qJEPcGeRmDS8pJNaPImpsYW4eWc/YAmFe1efz
w1e7dNN+mznb5YD5q/r3jNwG+bvSblEqjQChMy3Vix+kavEUlkbfhjUvC9yE5Y1Zt3Q35BGe+1o+
HG9Xe7em243oyG66ZyoxxULe1vM4l9wkHV0rttQWSg==
=Vhp7
-----END PGP SIGNATURE-----

--GZlw9XRimbRflKEqbIeJ6AKoGzpNRdN8y--
