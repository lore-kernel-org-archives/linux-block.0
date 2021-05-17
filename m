Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A42C433ED
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 14:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2C4761490
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 14:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbhEQO0b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 May 2021 10:26:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:53618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239609AbhEQOYa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 May 2021 10:24:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621261392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l0UfPfd8q4JFoy/Gm6qLKY+Gv2/rFgvF9TXVY1oORvg=;
        b=e9BZ6Kdl3nJMZU0ppxyFtdn0Phjh0jmK4TVR7JmHJWSH/+iXIA95y8g3jMI6CsFW6eN9La
        TSABvjb7BjHvRl3nzK8ZbCXF+3lhkPvZO/MLTxDG5iOXhCqk++XLa3svj1iHXNokHdfBUQ
        jE6etTanday/Omsjn2Ioza+tXyEr26o=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 75198B231;
        Mon, 17 May 2021 14:23:12 +0000 (UTC)
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210513100302.22027-1-jgross@suse.com>
 <20210513100302.22027-5-jgross@suse.com>
 <315ad8b9-8a98-8d3e-f66c-ab32af2731a8@suse.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 4/8] xen/blkfront: don't trust the backend response data
 blindly
Message-ID: <6095c4b9-a9bb-8a38-fb6c-a5483105b802@suse.com>
Date:   Mon, 17 May 2021 16:23:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <315ad8b9-8a98-8d3e-f66c-ab32af2731a8@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uFelNYe0WoxMBWJXMM8pj0dKp98OxKi7g"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uFelNYe0WoxMBWJXMM8pj0dKp98OxKi7g
Content-Type: multipart/mixed; boundary="BxGqQncOtjZqp2zBgNsSAzrhnURnu5KtO";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <6095c4b9-a9bb-8a38-fb6c-a5483105b802@suse.com>
Subject: Re: [PATCH 4/8] xen/blkfront: don't trust the backend response data
 blindly
References: <20210513100302.22027-1-jgross@suse.com>
 <20210513100302.22027-5-jgross@suse.com>
 <315ad8b9-8a98-8d3e-f66c-ab32af2731a8@suse.com>
In-Reply-To: <315ad8b9-8a98-8d3e-f66c-ab32af2731a8@suse.com>

--BxGqQncOtjZqp2zBgNsSAzrhnURnu5KtO
Content-Type: multipart/mixed;
 boundary="------------186FB5FB25262D3342EC3271"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------186FB5FB25262D3342EC3271
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 17.05.21 16:11, Jan Beulich wrote:
> On 13.05.2021 12:02, Juergen Gross wrote:
>> @@ -1574,10 +1580,16 @@ static irqreturn_t blkif_interrupt(int irq, vo=
id *dev_id)
>>   	spin_lock_irqsave(&rinfo->ring_lock, flags);
>>    again:
>>   	rp =3D rinfo->ring.sring->rsp_prod;
>> +	if (RING_RESPONSE_PROD_OVERFLOW(&rinfo->ring, rp)) {
>> +		pr_alert("%s: illegal number of responses %u\n",
>> +			 info->gd->disk_name, rp - rinfo->ring.rsp_cons);
>> +		goto err;
>> +	}
>>   	rmb(); /* Ensure we see queued responses up to 'rp'. */
>=20
> I think you want to insert after the barrier.

Why? The relevant variable which is checked is "rp". The result of the
check is in no way depending on the responses themselves. And any change
of rsp_cons is protected by ring_lock, so there is no possibility of
reading an old value here.

>=20
>> @@ -1680,6 +1707,11 @@ static irqreturn_t blkif_interrupt(int irq, voi=
d *dev_id)
>>   	spin_unlock_irqrestore(&rinfo->ring_lock, flags);
>>  =20
>>   	return IRQ_HANDLED;
>> +
>> + err:
>> +	info->connected =3D BLKIF_STATE_ERROR;
>> +	pr_alert("%s disabled for further use\n", info->gd->disk_name);
>> +	return IRQ_HANDLED;
>>   }
>=20
> Am I understanding that a suspend (and then resume) can be used to
> recover from error state? If so - is this intentional? If so in turn,
> would it make sense to spell this out in the description?

I'd call it a nice side effect rather than intention. I can add a remark
to the commit message if you want.


Juergen

--------------186FB5FB25262D3342EC3271
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

--------------186FB5FB25262D3342EC3271--

--BxGqQncOtjZqp2zBgNsSAzrhnURnu5KtO--

--uFelNYe0WoxMBWJXMM8pj0dKp98OxKi7g
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmCifE8FAwAAAAAACgkQsN6d1ii/Ey/s
3Qf9HTZOC5syO0wOHlDd2ImlJLkEvymVnZeq/cv6R/zVD85g8sRgRbKW9Kk5YYous1E6EfxSZnIY
kqZeqH3gRL+Tn3NAcn1fUHKUEhzYAHgpwzuUqm2vj9t43B83IatRzcmAn1zERvvGL6wXpkJnDc86
OVohuIaeecTCEbFzynnB7JpQIM5XGLaTmPUtwOGVDVEQzCRlIAl5qEPNkJ4OWiVUgfJ4DqaFdxil
fQSMnBI6l3V5Lr6Hbkejus0bfNJKZX1GDiry6HS4RFfKssw8JlXJLUaHGEcc6Go2bVK2qsB+Lt7P
BOMjevMUX8GBurmcCt74HCmhUUgY1L7RYv5YjxENvg==
=98zG
-----END PGP SIGNATURE-----

--uFelNYe0WoxMBWJXMM8pj0dKp98OxKi7g--
