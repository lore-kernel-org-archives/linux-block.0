Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn3nam01on0045.outbound.protection.outlook.com ([104.47.33.45]:1736
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728198AbeHCOgn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Aug 2018 10:36:43 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: move device L2P detection to core
Date: Fri, 3 Aug 2018 12:40:12 +0000
Message-ID: <C29BF7B1-4C9A-47C7-9E5F-AD63356B01BC@cnexlabs.com>
References: <20180803085449.3436-1-mb@lightnvm.io>
 <31319710-8A72-49DC-9CFA-521CA06843F3@cnexlabs.com>
 <9349be00-4d14-9b25-ed11-fb9244428d7f@lightnvm.io>
In-Reply-To: <9349be00-4d14-9b25-ed11-fb9244428d7f@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_10966F8B-E1ED-47DA-AC7B-FFAE67A46EAF";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_10966F8B-E1ED-47DA-AC7B-FFAE67A46EAF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Aug 2018, at 14.37, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/03/2018 02:16 PM, Javier Gonzalez wrote:
>>> On 3 Aug 2018, at 10.54, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> A 1.2 device is able to manage the logical to physical mapping
>>> table internally or leave it to the host.
>>>=20
>>> A target only supports one of those approaches, and therefore must
>>> check on initialization. Move this check to core to avoid each =
target
>>> implement the check.
>>>=20
>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>> ---
>> I see where you want to go with these changes, but the way targets =
are
>> layered on top of the LightNVM subsystem does not align with it.
>> LightNVM can support different OCSSD versions and capabilities, but =
that
>> does not mean that a target (e.g., pblk) does. The way I see it, core
>> should only check for (i) the drive to expose itself in a known =
revision
>> and (ii) the reported structures to be consistent. However, specific
>> functionality is not for core to check upo.
>=20
> Why try to initialize a target, if we already know that it is =
incompatible?

Yes, that is my point. But the one who knows if the targets supports
something or not is the target, not the subsystem. Here, you are making
an assumption knowing the pblk requires the L2P on the host, but that
could change in the future...

--Apple-Mail=_10966F8B-E1ED-47DA-AC7B-FFAE67A46EAF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkTSkACgkQIX4xUKFR
nnTGlA//YWk05KrbuSeK59x845B+LPOYfFl7v4191hCJjM10oE7hhgI7fzMZ5OKw
anR0SKx7w7dyZiZBHNnjpTgSi7b4NYAFAyEK0FPvkPj2IzFObvKt+OvfFOOWs0Ts
/bkL8I0XO6nSdXmoorFLXco8U1+L1/oYnmQmDlxy3/5Eujl2RX37Nk1JpK/vXwsm
FsghooPwB6z0QE+jV+eUIk7iVFTyPQege6H9Qo1Fu3k41i+q+1dTdas8dbEHGVjV
bB/iLXccoeTP3WZZWdwRVlcOhRzHZbqE/aQZI3tahsO/jNfHX/elo8k7bN9C3PKR
fxaDOHFzZ81fvoVeMN88ha40SlyJqwYt+2Lk45MNNb3fkUTypVeel+xTL8jUXFSt
vM4Hc35qMMXuxW3ieyzXWM2+Ii/2J9cvgib0YcFt4bdpLPD7djNmjHLMOxwdi+gP
5ZhUF+E0f9WKUkJ5fIq8Z9Dgh19N+tHHJbBQkJVYHqtVk5wnHxgNVneArjypA4HZ
gsUId9pn4xIOCQYb/y5a6YHrng7svjnQ4M7IiyjWsf5tWXDYJZn7YvCKYIrmHaNQ
Cxxxeq6aATz91hp4+izkmbEZV797U0izo6qVcnGyDRpazQ5iH8UHaEmzcXv9BH/q
G5W4sawXE3aI+Rm1jQaXOwsw28vyR6BCwiEfHcw5oSbRKwy8PQA=
=tIbH
-----END PGP SIGNATURE-----

--Apple-Mail=_10966F8B-E1ED-47DA-AC7B-FFAE67A46EAF--
