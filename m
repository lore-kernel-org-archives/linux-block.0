Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9933FC433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 07:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F6F82312D
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 07:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbhASHoa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jan 2021 02:44:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:33082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbhASHoR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jan 2021 02:44:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611042182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yblbjsqZtcjCRjUs6WEVPVCddUTVDccZNGaXAFRniww=;
        b=B7QN1y55Pt6erzxCv+imFVYj+D7yURfz2WmOfwPPUfLlxv6F9KbFcny8grzCCVVatybkM1
        6MV0sH5NOcNKJpj2QNagbXAqcr6agcJExWYXGooIdS6wbto8ciqaUE7NPEjO4c7LtyuZtr
        KrN2czQUppkbyu/+u20nxwkDdSNoLM0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07284AAAE;
        Tue, 19 Jan 2021 07:43:02 +0000 (UTC)
Subject: Re: [PATCH] xen-blkfront: don't make discard-alignment mandatory
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     Arthur Borsboom <arthurborsboom@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org
References: <20210118151528.81668-1-roger.pau@citrix.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <7cef385d-efe3-2661-bee2-9d21f159a5fb@suse.com>
Date:   Tue, 19 Jan 2021 08:43:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210118151528.81668-1-roger.pau@citrix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MZI3e7CGixY8GuKzcz1zAJm4vGyIsKoGI"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MZI3e7CGixY8GuKzcz1zAJm4vGyIsKoGI
Content-Type: multipart/mixed; boundary="9gUXontkTbz1CfCeDSHWOcmqu5njosgx4";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Roger Pau Monne <roger.pau@citrix.com>, linux-kernel@vger.kernel.org
Cc: Arthur Borsboom <arthurborsboom@gmail.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jens Axboe
 <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
 linux-block@vger.kernel.org
Message-ID: <7cef385d-efe3-2661-bee2-9d21f159a5fb@suse.com>
Subject: Re: [PATCH] xen-blkfront: don't make discard-alignment mandatory
References: <20210118151528.81668-1-roger.pau@citrix.com>
In-Reply-To: <20210118151528.81668-1-roger.pau@citrix.com>

--9gUXontkTbz1CfCeDSHWOcmqu5njosgx4
Content-Type: multipart/mixed;
 boundary="------------5AAB304EC2804B58C551CB4D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------5AAB304EC2804B58C551CB4D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 18.01.21 16:15, Roger Pau Monne wrote:
> Don't require the discard-alignment xenstore node to be present in
> order to correctly setup the feature. This can happen with versions of
> QEMU that only write the discard-granularity but not the
> discard-alignment node.
>=20
> Assume discard-alignment is 0 if not present. While there also fix the
> logic to not enable the discard feature if discard-granularity is not
> present.
>=20
> Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
> Signed-off-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> ---
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: "Roger Pau Monn=C3=A9" <roger.pau@citrix.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: xen-devel@lists.xenproject.org
> Cc: linux-block@vger.kernel.org
> Cc: Arthur Borsboom <arthurborsboom@gmail.com>
> ---
>   drivers/block/xen-blkfront.c | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.=
c
> index 5265975b3fba..5a93f7cc2939 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -2179,22 +2179,23 @@ static void blkfront_closing(struct blkfront_in=
fo *info)
>  =20
>   static void blkfront_setup_discard(struct blkfront_info *info)
>   {
> -	int err;
> -	unsigned int discard_granularity;
> -	unsigned int discard_alignment;
> +	unsigned int discard_granularity =3D 0;
> +	unsigned int discard_alignment =3D 0;
> +	unsigned int discard_secure =3D 0;
>  =20
> -	info->feature_discard =3D 1;
> -	err =3D xenbus_gather(XBT_NIL, info->xbdev->otherend,
> +	xenbus_gather(XBT_NIL, info->xbdev->otherend,
>   		"discard-granularity", "%u", &discard_granularity,
>   		"discard-alignment", "%u", &discard_alignment,
> +		"discard-secure", "%u", &discard_secure,
>   		NULL);

This would mean that "discard-secure" will be evaluated only if the
other two items are set in Xenstore. From blkif.h I can't see this is
required, and your patch is modifying today's behavior in this regard.

You might want to have three xenbus_read_unsigned() calls instead.


Juergen

--------------5AAB304EC2804B58C551CB4D
Content-Type: application/pgp-keys;
 name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Transfer-Encoding: quoted-printable
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

--------------5AAB304EC2804B58C551CB4D--

--9gUXontkTbz1CfCeDSHWOcmqu5njosgx4--

--MZI3e7CGixY8GuKzcz1zAJm4vGyIsKoGI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmAGjYUFAwAAAAAACgkQsN6d1ii/Ey/C
0Af9FSuk3CbkkDBkagaqdGVlTJriLSG9JWtwdHg4aqr20eJmt/PG24EetmmX9Z08la6HCpRKrvOC
6+No9Gst5R2yB4XH6hfvfwnZ86HDu6b8i4pNtvxhU/d6GZyy8it8SUvwHC7fa2ITkEvi3YAVOTHO
5rbqd0kSVJNxmocW+5jIWiING8DgpUb0m1daYNG3kXBdY6AqbYO2qQ30iozvymm6ooBhz1nQnI8Y
h6h0E1mwsZg7wlkBCcrNAW4+V9N52s/nT/2XYZDvN4AI+kBgaPyC5ZLZP9lTq0FZRZMig4ChX+gU
8DJsVYOldhTl3SYRN8K7X9YK8GwOF7+ptFKX/08Z2w==
=KNke
-----END PGP SIGNATURE-----

--MZI3e7CGixY8GuKzcz1zAJm4vGyIsKoGI--
