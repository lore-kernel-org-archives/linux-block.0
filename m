Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-co1nam03on0058.outbound.protection.outlook.com ([104.47.40.58]:51704
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbeJIT4w (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Oct 2018 15:56:52 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "hans.ml.holmberg@owltronix.com" <hans.ml.holmberg@owltronix.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>
Subject: Re: [PATCH 2/5] lightnvm: pblk: Helpers for OOB metadata
Date: Tue, 9 Oct 2018 12:39:22 +0000
Message-ID: <31C944A9-6557-4DBC-9DC2-82AEE6AFEF67@cnexlabs.com>
References: <20181005133437.25255-1-igor.j.konopko@intel.com>
 <20181005133437.25255-3-igor.j.konopko@intel.com>
 <CANr-nt1Hc88Sm_e7GYpYqbzXa67zQnGjqHgH3aEo2ARKMZEGeg@mail.gmail.com>
 <76595cfc-4f45-8dbe-04ea-0d7bb0352b3d@lightnvm.io>
In-Reply-To: <76595cfc-4f45-8dbe-04ea-0d7bb0352b3d@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_B537AB92-5E0C-4915-9436-7C36FE946132";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_B537AB92-5E0C-4915-9436-7C36FE946132
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

>=20
> On 9 Oct 2018, at 18.12, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
>>>  };
>>>=20
>>>  struct pblk_sec_meta {
>>> -       u64 reserved;
>>>         __le64 lba;
>>>  };
>> It's nice to reduce the required metadata size, but this silently
>> breaks pblk the on-disk-storage format. We can't have that.
>> I suggest breaking out this change as a separate patch that also
>> increases SMETA_VERSION_MAJOR and instructs the user via the kernel
>> log to migrate the data manually (or factory reset the decice/pblk
>> instance).
>=20
> In that case, we should include the initialization values of the =
target somewhere. E.g., line metadata, or some FTL log to be implemented =
at some point.
>=20
> Another fix for now will be to keep it as 16b, and do the patch that
> you propose later. Igor, I believe the metadata will fit? 16b per LBA
> should be max 1K in the case of 64 LBAs.

Ideally, we fit this on the smta structure too, independently of the FTL
log. THis way, we can have different line types that are recovered
differently. Since we are changing the format, this is a good time to
add it.

Javier

--Apple-Mail=_B537AB92-5E0C-4915-9436-7C36FE946132
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlu8oXgACgkQIX4xUKFR
nnT6Qg/8CBXtqUmr0f9PIr68Im2qNL6KpCU4wnybiEm1uNQVWX7hoVkXWkqUsvWO
fF3n0sUTABGBPoukmmMThTiJfTAkLHLY8okuf23SiE9l84WaTfs7c0YCMCYOAQRD
qMtOVNQ2OB0qZFxm5GLnKl7rqNRxHyb1ylpCqpcd2tyQHqh6HSwWFpO/jh2SDKgj
DM+209CU0PKzQJq7Fxh8Rs07WmhxmPD9bgyDL5zlarUvN7eT9WacomNVVPwN3ok1
E8k2X7GndmJ/Y4iFOiig3Qb/shI3eGxVuvRMDfoAKLb1pEUKNhiJrVRy84Q8OS3b
I+/+ylvx0LjEUhM6OT3n8GoOiIl3+Ba9HatjRrC8uYvAf0sfDXA5HhEpxq/1uP/N
kf81eGsN2PZI40PPSjgtjs4cVhOH+2th1311WTowLNkTjs+mG2OhvQLz/oIynjEH
iSTcjkHSDSXMM5pwLZ8aQXIqEXqfDCo5Lg2Re/YoCNaK9FZxo09LhummNhPj4fuj
fiwaE/RlN4rhJHIqLCo6VS2VJgLBVlZl7h7uHRGDVGuPfv9jGgc0p3cB37RNyEox
MFu66BgveOn2dXHSYOzgEZORlsZ0iFfNtjS0WzkSWgoE2jRdrx/w8rs/akPe7dlR
t5vbUgNVdLPam7Dsq57erHpDvmor3ForshyiY+8TlbbJ+PXgkk0=
=qQWx
-----END PGP SIGNATURE-----

--Apple-Mail=_B537AB92-5E0C-4915-9436-7C36FE946132--
