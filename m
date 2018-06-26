Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0051.outbound.protection.outlook.com ([104.47.34.51]:56000
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754771AbeFZUOb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jun 2018 16:14:31 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Heiner Litz <hlitz@ucsc.edu>
CC: =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
Subject: Re: [RESEND PATCH] lightnvm: pblk: add asynchronous partial read
Date: Tue, 26 Jun 2018 20:14:28 +0000
Message-ID: <53245EEE-901D-4966-86DE-F1EC1FD77C21@cnexlabs.com>
References: <1529344568-2794-1-git-send-email-hlitz@ucsc.edu>
 <25ed47dd-033a-7181-01c5-09ee359ee962@lightnvm.io>
 <CAJbgVnVpoWLUO1R=YHju+_Woo8xjEznV+YE3TC0q8nEmqsCESA@mail.gmail.com>
In-Reply-To: <CAJbgVnVpoWLUO1R=YHju+_Woo8xjEznV+YE3TC0q8nEmqsCESA@mail.gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_E3DAA4D0-6CCD-45B7-A5C9-86F6EE8C7999";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_E3DAA4D0-6CCD-45B7-A5C9-86F6EE8C7999
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii



> On 26 Jun 2018, at 21.01, Heiner Litz <hlitz@ucsc.edu> wrote:
> 
>> Guarantees that this is at least 32bit, but this should be at least 64
>> bit right?
> 
> All 64-bit bitmaps in pblk are unsigned long. If we want to change to
> u64 this should be part of a different patch

It makes sense to me.

Javier

--Apple-Mail=_E3DAA4D0-6CCD-45B7-A5C9-86F6EE8C7999
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlsynqEACgkQIX4xUKFR
nnT7dA//Xy6GzNyAqv7vzbvrjOOfT5R8RY8cwog7Pv1FCX1moHS4YHEyt4e6Ypnp
UJkjMBP6WYCVcZlpsLCWd+5w9L2zId7jIIzDuFiiTgRDOvZW0X3e0y6BZdJMiEbI
v9Az61Mzhy7gUrzLpcBeI+aNaoAj1KipcW5fJ52Coc7E9rdj/e2Ckak5qZ11ANRW
MTBIzN5mvXOh01YSHBR2iPTGpEwmWmMMy72MzYikF5wlAdr5aWQKYqURSf2SsC7T
Jz8MDew1ZyC9IgfEUulu7d9CxX2TH8wck9dJLFwklFeOW9GOCaqiNzWtFl9InTQu
5JDW5HJx5O4gcQvW4d4hDYx3gdHHCmPFUyj9+zb5N4akBDuy9SLO6tzcHybj7d6K
1NAjrYSxH1cmb9JSdybKxkMxSnrcRZPBC+MBTvhsS12gEMAENou+PnGSLpB8nm2W
ONuxNLl6XLfTqz8g6S1XqNtkx7+9iqpOyzNpnOB7whShFviGb56PXTYxygVqqFjU
zhu6Fu3XHt7zh52dua3aJKIWSu+SWW5y9EYVcQjXwKgH1AOjsu1f6CbxoiDAubC6
pXzcRGPV657417S9J0pikgHePPkKqfla4bdPMgbB57AqfWHdmCMdClF1GuiqUj+8
uXGJ5B0XiZAMB4+SnhXcwxxLyN3eZie3VBa0XFkTlf7CR5PpAEY=
=/te6
-----END PGP SIGNATURE-----

--Apple-Mail=_E3DAA4D0-6CCD-45B7-A5C9-86F6EE8C7999--
