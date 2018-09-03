Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0067.outbound.protection.outlook.com ([104.47.41.67]:52939
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbeICNhv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Sep 2018 09:37:51 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH 0/4] lightnvm: pblk: add support for chunk metadata on
 erase
Date: Mon, 3 Sep 2018 09:16:53 +0000
Message-ID: <7FBEB635-C943-484D-A970-D3BF870BAFFB@cnexlabs.com>
References: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
 <71f5f8b3-66d5-a0e0-85ab-cb22e5ac621c@lightnvm.io>
In-Reply-To: <71f5f8b3-66d5-a0e0-85ab-cb22e5ac621c@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_9BF0F591-CAF6-46DC-B708-61CA4FCDACEB";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_9BF0F591-CAF6-46DC-B708-61CA4FCDACEB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 31 Aug 2018, at 15.57, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/31/2018 03:34 PM, Javier Gonz=C3=A1lez wrote:
>> Matias,
>> This patchset implements support for retrieving chunk metadata when
>> submitting a reset/erase command. Patches 0 and 1 are small fixes =
that
>> can be directly merged into your patch:
>>      lightnvm: move bad block and chunk state logic to core
>> Also, note that these do not apply on top of your for-4.20/core due =
them
>> depending on patches that I sent before that you have not picked up =
yet.
>> You can see them though in for-4.20/pblk. I'll rebase as patches in =
the
>> list appear in your tree.
>=20
> Thanks. It is really confusing when you guys maintains an implicit =
order and posts the patches separately. I will appreciate that patches =
that are related are posted together, such that I don't have to manually =
track what comes before another. That makes it less of a pain for me to =
keep track of and we can keep the reviews together.
>=20
> This is the patches that I have in the pipeline (from before the =
e-mails from today):
>=20
>  - This serie - Pending review
>  - Serie: pblk: support variable OOB size - Waiting on review from =
Igor
>  - lightnvm: pblk: recover open lines on 2.0 devices. Which doesn't =
apply due to the fixes to the pad distance patch.
>=20

Yes, I know and I apologize - we should have a better flow. What do you
say that for windows like this, where we have a number of patches that
have dependencies that we post them in meaningful patchsets and point to
a branch where they are ordered, like in a PR? Then we can rebase and
propagate changes properly?

For this window, I'll rebase the rest of the patches in for-4.20/pblk on
top of your for-4.20/core, then we can propagate changes as they come.

Javier

--Apple-Mail=_9BF0F591-CAF6-46DC-B708-61CA4FCDACEB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluM/AIACgkQIX4xUKFR
nnSPlw/+LWvj9fJ0ivtsAUDOw6HK29PlpTwm16Pk6L0RComF25n2l/kTitrm9D2M
h1JpGMk8I9x2aq4cmrqJ+dL5AUPNYzhUyWQVMiTuBJpoa3SxSO62+pxW67K59g3C
xj0HRHl6UNfYXbp0is1OkqlDsTgDqfe7kp6tQhUjR48BhC4r/BDNZSJMe8lor4nQ
YWDT57j++hoiguVNpb/TRIuTFw2eUkTX1hVH2nuCoUluLcGU0koxxZTby+501ewJ
44AUyUSWqVaCV5w9+L/yonAn41pzOrxGkMZXVVd75zHzVjS22bX6i/q5oh7U6YuT
saaQKB3JI3J6Czal61t/Aol2eNxmV/S4LH0R09X+bawTToHkZKnth1PUl9mzKroW
6U9eYPd9PVhCB64aNKwGaNBtfYs42XJYcPY0/G+bu77tNMFPop1EcEp05Magnl0I
ZTISZMijT6wnk+KGYW6ci9+mRw3/Krt9N1NFtkkzHB6e9JjbSA4h5j1mV0RVfBLN
jcQyk0QKUyhoL9liwCxLzz4BPE2bNqKhvpupy1o8maMirTWU/O1ECZmrt2jbx6MQ
0RbYoWpgfKV2fafB93iQ+t7A/FjNKQP91bAqJkQWegUsEzxBF3uz6tPgprizUGcj
rb80G/FeeYh+6X61cUGTkxoluyPGXuxK2LVHDjBK4Fj4w97E5vw=
=VjXM
-----END PGP SIGNATURE-----

--Apple-Mail=_9BF0F591-CAF6-46DC-B708-61CA4FCDACEB--
