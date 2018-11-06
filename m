Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bl2nam02on0044.outbound.protection.outlook.com ([104.47.38.44]:46706
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729160AbeKFSn3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Nov 2018 13:43:29 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
CC: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH v2 0/7] PBLK Bugfixes and cleanups
Date: Tue, 6 Nov 2018 09:18:27 +0000
Message-ID: <6DE4756E-A324-49B0-A588-1B2F74ABC789@cnexlabs.com>
References: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
In-Reply-To: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_008BA30E-FCD7-482D-939C-3A8D6488B67C";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_008BA30E-FCD7-482D-939C-3A8D6488B67C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 5 Nov 2018, at 13.26, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> This series is a slew of bugfixes and cleanups for PBLK, mostly
> fixing issues found during corner-case testing in QEMU.
>=20
> Changes since v1:
> 	Messed up from:, now the patches apply with the correct author
> 	Pardon the mess.
>=20
> Hans Holmberg (7):
>  lightnvm: pblk: fix resubmission of overwritten write err lbas
>  lightnvm: pblk: account for write error sectors in emeta
>  lightnvm: pblk: stop writes gracefully when running out of lines
>  lightnvm: pblk: set conservative threshold for user writes
>  lightnvm: pblk: remove unused macro
>  lightnvm: pblk: fix pblk_lines_init error handling path
>  lightnvm: pblk: remove dead code in pblk_recov_l2p
>=20
> drivers/lightnvm/pblk-init.c     | 48 +++++++++++++++++-----------
> drivers/lightnvm/pblk-map.c      | 47 ++++++++++++++++-----------
> drivers/lightnvm/pblk-recovery.c |  1 -
> drivers/lightnvm/pblk-rl.c       |  5 ++-
> drivers/lightnvm/pblk-write.c    | 55 +++++++++++++++++++++++---------
> drivers/lightnvm/pblk.h          | 16 ++++++++--
> 6 files changed, 114 insertions(+), 58 deletions(-)
>=20
> --
> 2.17.1


Apart from the nipticks pointed out in V2, the series look good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_008BA30E-FCD7-482D-939C-3A8D6488B67C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlvhXGIACgkQIX4xUKFR
nnQ/8A/+M+VmnsElaf0iNgADIAcKQT3tikUQJhgkPqX6L9djAZ9qhV37LYxwVy3D
+ynl4lMsN16fXxM3V1bgxdMtIOgX4+fxZRvoyuyoLLJ9zyjbIwKVTRcmALsaXqRA
rsCg2bv3ixowzx+8569Niwt3PVfYFD9AXGVbXpSTjhZS24y7K6bzPcO1a4stG4tY
O7ZKTxTERCG2aYea9/Ai+Irr8vnJbLc7oMMdTqTLwKiNC24IwHTco5QtL3r9DRyv
YRA2q9PzE9H1A4giV0GlNUF1ydAtRAN0F9FjZaY6aVCN7dPB7YyQNC46qbkWkrhC
l6Ai2hhvHbrz1XbxBs6+CRxta5ZxICD5UncMDofdac7UTKDLFUKTdJy+wNOnmbBU
DDWiTOZQcO7lbkspsjgvee+cuO9x5bnMfMSIlMNxQ2NZWpxqByd6YE6csei8o9MB
gOEzv8TS/Ui0uIsgxpN2NA1+6uFGCRpd2y3gWleoZ+EfFISMjDYvt25G+RFDt4TD
ew9QrAp97fzbgoOFvENUeIqY7O8RoqmD3jvedO6SFiyNVg/bEJ2avSLVUyZnHXBr
rEzPYak5j7jKghi8LQO1hGn3UloBaGMl/nvuyRddl5CqnBOLwoSfbdX8S3FxoCd2
iWAglKa2wh5d7BpmesGhRjbJuYLWeM3LpqiyjyTSP19f2CCqMQU=
=RZMJ
-----END PGP SIGNATURE-----

--Apple-Mail=_008BA30E-FCD7-482D-939C-3A8D6488B67C--
