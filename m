Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C52C388F7
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 09:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 484452076E
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 09:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IRq9RdNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgKMJAH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 04:00:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:58710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgKMJAC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 04:00:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605258000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B+WauX+YBkoDJlCbUWkFiHD9PvSYH8hL4aBg03MFcBw=;
        b=IRq9RdNTG1K7JSvjSeKQJ5BXK/b5d7EIBnLqZMQ719Ry3OOHPQd16JH4jxk7LEfema8vVp
        g2PtSLEEz8Rp03YH39v1E30juzK+bSBDuOPg7MD0huqrPoyBMryoWw11Ms3TBKx36hzHav
        UBbUc8tZEioxp5QWEVDaBw4kJqJO2YM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 346FCAE3A;
        Fri, 13 Nov 2020 09:00:00 +0000 (UTC)
Subject: Re: [RFC] Enhancement of loop driver?
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
References: <1a5ccfd6-d7c1-28d5-3562-05178f44ed3d@suse.com>
 <20201113084419.GA32694@infradead.org>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <80238a77-7ff9-4492-9b3a-b1b049591242@suse.com>
Date:   Fri, 13 Nov 2020 09:59:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201113084419.GA32694@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tGQYppjZTE6OUeK7Mbre6KqwljQVEtx7g"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tGQYppjZTE6OUeK7Mbre6KqwljQVEtx7g
Content-Type: multipart/mixed; boundary="jV4Pw1zWL9hpXqwqYDNQVPhyeV6ebKgdn";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Message-ID: <80238a77-7ff9-4492-9b3a-b1b049591242@suse.com>
Subject: Re: [RFC] Enhancement of loop driver?
References: <1a5ccfd6-d7c1-28d5-3562-05178f44ed3d@suse.com>
 <20201113084419.GA32694@infradead.org>
In-Reply-To: <20201113084419.GA32694@infradead.org>

--jV4Pw1zWL9hpXqwqYDNQVPhyeV6ebKgdn
Content-Type: multipart/mixed;
 boundary="------------EE3A977B27C8E2FD0AD45DBA"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------EE3A977B27C8E2FD0AD45DBA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 13.11.20 09:44, Christoph Hellwig wrote:
> On Fri, Nov 13, 2020 at 07:59:23AM +0100, J??rgen Gro?? wrote:
>> a large customer is asking for storage migration of the disk images of=

>> their virtual machines. They don't want to migrate the VM to another
>> host, but only the disk image from one filer to another while the VM
>> keeps running.
>>
>> The natural way to setup something like this would be LVM and use
>> mirroring, but the problem is that this requires to copy the image to
>> a LVM enabled disk first, and this is no option due to time constraint=
s
>> (copying many GB of data takes too long, and in the end I'd like to be=

>> able to do the switch from the original image to the LVM backed with
>> the VM kept running).
>>
>> So my idea was to enhance the loop driver to be capable to support a
>> list of backing files instead of only one and use a small prepended
>> file for storing the needed LVM metadata, resulting in the ability to
>> keep the existing disk image.
>>
>> Would such an addition be acceptable?
>=20
> Just use device mapper on top of the loop device, no need for changes
> to the loop driver itself.  Also qemu has some interesting migration
> features that you might want to look into as they might suit you.
>=20

Thanks. I just stumble over device mapper myself. :-)

I'd like to have a solution without qemu in order to be able to support
kernel based backends, too.


Juergen

--------------EE3A977B27C8E2FD0AD45DBA
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

--------------EE3A977B27C8E2FD0AD45DBA--

--jV4Pw1zWL9hpXqwqYDNQVPhyeV6ebKgdn--

--tGQYppjZTE6OUeK7Mbre6KqwljQVEtx7g
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAl+uSw8FAwAAAAAACgkQsN6d1ii/Ey8z
ZAf8Db/O0ecRSQbtTLOxNThIWqQQirMFBYFYXmkXD7g2km+9+Cd0MGLt/KGSrCxwevhxG1jxakAR
PyQn1YNyoJ3pHWldI25nvVInuSW7Jbus6HYzsj/oBRw2ncbdA3j1TSYwmuNkk6BnEwwVoObcR1db
QRhh8DR/iWWNgT014K92gC23AHA5EIrBcP+zTk2R+01BdjhrQVlTHP5fQ6bcFdPgV84k9Dxo9Ihu
+nMQvsUopU87FeOpk6V00JNj3XoXDnXatoMs3RnD8oDiMRZTOYVHkqvvf21JXyFCped2fK8yvxim
QbialilU/F29sG7QR/bqgr0j2fb4F8IfSZvOpxsOmQ==
=LU0q
-----END PGP SIGNATURE-----

--tGQYppjZTE6OUeK7Mbre6KqwljQVEtx7g--
