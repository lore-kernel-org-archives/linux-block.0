Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BB3C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4F720836
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="O1nfgPQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfCDJLx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:11:53 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46278 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfCDJLx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 04:11:53 -0500
Received: by mail-ed1-f68.google.com with SMTP id f2so3590618edy.13
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 01:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=0z/4w0GW6Yt5NMm21JpVFEkkTWiq/0uCa2MgDkjYZQc=;
        b=O1nfgPQo+1keT3cG8seNx4Ec4DiBqWNbneK4fpa3RTBBk60mSHREsWRzsyI/fq7mKP
         2cdfDDf/f3xg3KUpSxfx0TOPHXTB/qGy86HK5Xj+SUpIoOSn4mAC6jEPBtL9vJXGkIOu
         f8/+uHpL+Be/rCXOEDOngJC2x0174Q3wXsp8uiWxJ0kPS4lO1ysWr5bRcbm4G5Xukv6S
         msqx8Hnq8C8MIafWlWcG+Zi+IUuRUZ4JKR7RgJ8xAKaDMM8TefQyT+mZuxID/qtuzYXd
         2F+DlOc0/4Ks7MQuFqLKHM8wxXfpccC3ifZ+BHuzbc4GlV7mh5ADQU5NnaacLgF00S/J
         vFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=0z/4w0GW6Yt5NMm21JpVFEkkTWiq/0uCa2MgDkjYZQc=;
        b=etLqxdpASlxAsaQHyJiCHYzRrO+lMB6YmbMc1lisVdvsYuJKwT0xYHv7otlhVEVYNB
         FKIVNmKXYt7sfc6G8+JxeUqw6GPVecgngx6XvbyyuZdaJvMlXRxz2kQc18P1G1Mo9LaV
         WpZgyqmteO9hDgfM8WYnUc8KxoZQLEEPhYJ4j1tISdZm3VBwSRIP6hGA0yvISgNIV/Tw
         lPsj/7/A7UvZSXEV39xaJ4hp9scFs2OqLDQrKLMn8lyKWJPLRCgUdMyS9EHZ40EeIJyQ
         Kuttz5uB1jZPsm/l0FbTwWHme/HJ90NxupiFF2fbt1XG5mUGSShlCKpWW7Cl0CPNVrP+
         gbQg==
X-Gm-Message-State: APjAAAX/WQYoE3B7XQ9hx5RtjabxnFSAKmmqdFXrhiCGQM2skUcWJsc/
        YLfULjhwEhlffiNPjwIolB1meQ==
X-Google-Smtp-Source: APXvYqz59CqORSFj7laxmtNheIyAQ82rLEUWq0EVcnk9kiIgt/+HYHD/JCj5LhwwwF+hkPPchnhB/Q==
X-Received: by 2002:a17:906:e81:: with SMTP id p1mr11881439ejf.175.1551690710817;
        Mon, 04 Mar 2019 01:11:50 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id d47sm1937146eda.77.2019.03.04.01.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 01:11:50 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <EE08736A-168C-4BED-8445-C0CFEDBB61D4@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_AD6683BF-67B4-4219-A7A6-CBEFA4A641FB";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 06/13] lightnvm: pblk: Ensure that erase is chunk aligned
Date:   Mon, 4 Mar 2019 10:11:49 +0100
In-Reply-To: <CANr-nt1877shJYYkMMwaC2StbrXaOjP7D0OOW5M1rW7LOXu=QQ@mail.gmail.com>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-7-igor.j.konopko@intel.com>
 <FA2EA171-4AB9-4D9C-A782-4BD416EC7045@javigon.com>
 <CANr-nt1877shJYYkMMwaC2StbrXaOjP7D0OOW5M1rW7LOXu=QQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_AD6683BF-67B4-4219-A7A6-CBEFA4A641FB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 4 Mar 2019, at 10.05, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> I strongly disagree with adding code that would mask implantation =
errors.
>=20
> If we want more internal checks, we could add an if statement that
> would only be compiled in if CONFIG_NVM_PBLK_DEBUG is enabled.
>=20

Not sure who this is for - better not to top post.

In any case, this is a spec grey zone. I=E2=80=99m ok with cleaning the =
bits as
they mean nothing for the reset command. If you feel that strongly about
this, you can take if with Igor.

>=20
> On Mon, Mar 4, 2019 at 8:48 AM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>>>=20
>>> In current pblk implementation of erase command
>>> there is a chance tha sector bits are set to some
>>> random values for erase PPA. This is unexpected
>>> situation, since erase shall be always chunk
>>> aligned. This patch fixes that issue
>>>=20
>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>> ---
>>> drivers/lightnvm/pblk-core.c | 1 +
>>> drivers/lightnvm/pblk-map.c  | 2 ++
>>> 2 files changed, 3 insertions(+)
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>>> index a98b2255f963..78b1eea4ab67 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -978,6 +978,7 @@ int pblk_line_erase(struct pblk *pblk, struct =
pblk_line *line)
>>>=20
>>>              ppa =3D pblk->luns[bit].bppa; /* set ch and lun */
>>>              ppa.a.blk =3D line->id;
>>> +             ppa.a.reserved =3D 0;
>>>=20
>>>              atomic_dec(&line->left_eblks);
>>>              WARN_ON(test_and_set_bit(bit, line->erase_bitmap));
>>> diff --git a/drivers/lightnvm/pblk-map.c =
b/drivers/lightnvm/pblk-map.c
>>> index 79df583ea709..aea46b4ec40f 100644
>>> --- a/drivers/lightnvm/pblk-map.c
>>> +++ b/drivers/lightnvm/pblk-map.c
>>> @@ -161,6 +161,7 @@ int pblk_map_erase_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
>>>=20
>>>                      *erase_ppa =3D ppa_list[i];
>>>                      erase_ppa->a.blk =3D e_line->id;
>>> +                     erase_ppa->a.reserved =3D 0;
>>>=20
>>>                      spin_unlock(&e_line->lock);
>>>=20
>>> @@ -202,6 +203,7 @@ int pblk_map_erase_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
>>>              atomic_dec(&e_line->left_eblks);
>>>              *erase_ppa =3D pblk->luns[bit].bppa; /* set ch and lun =
*/
>>>              erase_ppa->a.blk =3D e_line->id;
>>> +             erase_ppa->a.reserved =3D 0;
>>>      }
>>>=20
>>>      return 0;
>>> --
>>> 2.17.1
>>=20
>> I=E2=80=99m fine with adding this, but note that there is actually no
>> requirement for the erase to be chunk aligned - the only bits that
>> should be looked at are group, PU and chunk.
>>=20
>> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

--Apple-Mail=_AD6683BF-67B4-4219-A7A6-CBEFA4A641FB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx869UACgkQPEYBfS0l
eOBTWw//Q1jjxjXug9wIoVtXb47NMXSh9Qq69g7yhpUBJ0vRRizl2Vt7QdU7liYD
q16jeyG6Xe2uZmmnexG4ZusqjOxh6AaM5J3S6Zcj60cYS7wGHJ2/qGVdI3Fk6eFD
wLnXIQRbHKIjlZ+3c7HwWyORs5+v9MVkz9KmqwbZotTs6NyG0WtKxinsoVpWTp2y
NuC6zae5bJkBmyiSrA8auyDjuu0osTZXjjWpwpOHHkgLR8fIJj0YZt5HJWxwf/T2
hlR3wTvrBl4P1NZcz9MY9omVVwfHJmBCENRXXoYuqcK1Wnv8aRpYsA1/Hk6ta4Ph
VC4ZXVUvB8AJQlIVy8OYuA+RRthR0oqgLjuG67ScFvXOgoZWtlztucLWlu80Eh0k
p1JAaHu8y2/gexLJVFgatLZJJwUybCdPc1WnmrvTzVi31ibkW9Qac46P1+Kc1yFu
0KUlTwi3QfZoPE5YaCZIMap2ibL0NoxzUeyAmFQ258t0n1oX/6MYLSCkIRt6Iit6
1UgPwhRkjmdRDtBhwzgjijGgDYWTr/dlyxpdDn9d8QzF9qBafanJ5cs60gulpuP7
PiibatERQCpsPL2UixkRAdxttsJgHdg75ny9DxY+FhrDsLl5Wg2J06ca1yGX9I/u
Yhz3eDNSMA3q1EvcHAx67NI7TrrpjcsMfU3myFgemA7Kh66d1Cg=
=dP6H
-----END PGP SIGNATURE-----

--Apple-Mail=_AD6683BF-67B4-4219-A7A6-CBEFA4A641FB--
