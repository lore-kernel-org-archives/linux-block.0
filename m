Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A813C433DF
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 12:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F34102076E
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 12:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404309AbgFYMFb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:05:31 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:55686 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404222AbgFYMFb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 08:05:31 -0400
X-Greylist: delayed 859 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jun 2020 08:05:29 EDT
X-ASG-Debug-ID: 1593085869-0a8818764e37a400001-Cu09wu
Received: from [192.168.177.89] (213.219.160.211.adsl.dyn.edpnet.net [213.219.160.211]) by relay-b03.edpnet.be with ESMTP id BWOfGayp1cy2y8mK for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 13:51:09 +0200 (CEST)
X-Barracuda-Envelope-From: janpieter.sollie@kabelmail.de
X-Barracuda-Effective-Source-IP: 213.219.160.211.adsl.dyn.edpnet.net[213.219.160.211]
X-Barracuda-Apparent-Source-IP: 213.219.160.211
To:     linux-block@vger.kernel.org
From:   Janpieter Sollie <janpieter.sollie@kabelmail.de>
Subject: SCSI sync unsupported: who's guilty?
Autocrypt: addr=janpieter.sollie@kabelmail.de; prefer-encrypt=mutual; keydata=
 mQENBFhRXM0BCADnifwYnfbhQtJso1eeT+fjEDJh8OY5rwfvAbOhHyy003MJ82svXPmM/hUS
 C6hZjkE4kR7k2O2r+Ev6abRSlM6s6rJ/ZftmwOA7E8vdSkrFDNqRYL7P18+Iq/jM/t/6lsZv
 O+YcjF/gGmzfOCZ5AByQyLGmh5ZI3vpqJarXskrfi1QiZFeCG4H5WpMInml6NzeTpwFMdJaM
 JCr3BwnCyR+zeev7ROEWyVRcsj8ufW8ZLOrML9Q5QVjH7tkwzoedOc5UMv80uTaA5YaC1GcZ
 57dAna6S1KWy5zx8VaHwXBwbXhDHWvZP318um2BxeTZbl21yXJrUMbYpaoLJzA5ZaoCFABEB
 AAG0MEphbnBpZXRlciBTb2xsaWUgPGphbnBpZXRlci5zb2xsaWVAa2FiZWxtYWlsLmRlPokB
 VAQTAQgAPgIbIwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBGBBYpsrUd7LDG6rUrFUjEUP
 H5JbBQJejDNwBQkPoNgdAAoJELFUjEUPH5Jb/TYH/3vHwn78OjEcJPtQqZ/vdydxGVZaO3mF
 ZbQsejrm/W1N72tfQRvJwuBg7VXO+n2++1SJCnGgjKxo0MwoJwqPkxbQeM3Gjl0/HHNMN+Lz
 lH5jWn81sgjIcK6ac8LRsFsJBz6fvxFdS3+cP4DqcpPhl8b9ZMMhQdTgUZtGBuryoHgdQpBl
 0BV+qxTDsYs0tir+cZMCPR/JUAnYlC471mRC27Bl8tDDiQLBPYNIOi9eeV4wVumznf9XZV2R
 yDop44jIxbcFECr3cyuM1GZI9KWKA5qZmDTWqvHS6Q0Ns5x+wT2knTrUzvVHbD6b1Hw6c0gR
 3FaOSPfy1U2bbC2P1mTEvWO5AQ0EWFFczQEIAPZ8mQJATotSNSlWW3NePF5FM1Ar9bc8LWLc
 SyMcVIlPTgxjXbOZdYjQi02qdFoHZz9f+u1ZO5hrNKyBBNA/+plK2zbz3QYPnXLcEDDjjes3
 SmVWnh1fokb+ndXSFrutfAWOfgfOC3ggMlJW41r2cYRx4h2pOe9k74Xi6SDNXZhUBRZy4OjA
 IEN9GbfJTQZTevE4d8FOljCWOoVZsaqKOxOMXX8t7hQsX6odRCrBMNjWKOnFEIh67jpahAR/
 kO/RpMjA4mA8rzbb25EMeUeEw+9emq0FgrBD+s4LPsR8hMOU+weGOepH6aN4vLu0r+ojJoTs
 DwdN2jFihiEBH4CrKVEAEQEAAYkBPAQYAQgAJgIbDBYhBGBBYpsrUd7LDG6rUrFUjEUPH5Jb
 BQJejDNwBQkPoNgjAAoJELFUjEUPH5JbUncIAMrv2TdPUtqMQdkaTFY+gC6LE3wXql/uGeh+
 hHYoWQxtCT71Zh+Iaw5xnAmOJTJCCJpJlx3PpAaQY8ON8suI0Mq8YYYCBFP32u4Di7J8BeM5
 tusynxUavR8jp5EXeda6HlGThbYNj/CNrKADQUn++nDxcWz03Jxi+TvI9xdbb03r/npMhzUj
 tLGawTPCuIbG+5E1kHO42wS92DOQXSRMvicyEf+iU8VbX5/ZjSQDdoBrVnKPMeyANQFIrK/f
 kwlHE8uQsrgj/kOKw1+N/KAT+C9KH4iyz5mq1mFjNH2gDqSaDushBod5U04HAWyaQeZcOYfl
 t4ImyAHqHDGJABRo5o4=
X-ASG-Orig-Subj: SCSI sync unsupported: who's guilty?
Message-ID: <9b8fac70-ace7-a625-0c1d-e48f52bd2e99@kabelmail.de>
Date:   Thu, 25 Jun 2020 13:51:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ItRfT9HKqJZRqb1MK7aRQHSyg0MKUWydT"
X-Barracuda-Connect: 213.219.160.211.adsl.dyn.edpnet.net[213.219.160.211]
X-Barracuda-Start-Time: 1593085869
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 654
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.6537 1.0000 1.0450
X-Barracuda-Spam-Score: 1.05
X-Barracuda-Spam-Status: No, SCORE=1.05 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.82797
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ItRfT9HKqJZRqb1MK7aRQHSyg0MKUWydT
Content-Type: multipart/mixed; boundary="mdwkXi8TrEpZasRxjjwT8EhlquRkXJX7B"

--mdwkXi8TrEpZasRxjjwT8EhlquRkXJX7B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Hi everyone,
During testing of bcachefs with a aacraid controller, I encountered the f=
ollowing issue: The
bcachefs kernel thread reports a critical IO error due to aacraid disabli=
ng SCSI command
SYNCHRONIZE_CACHE by default.
Who should handle those cases?
- adapter: does it need to "discard" the invalid CDB and act like it comp=
leted successfully?
- aacraid: enable when explicity requested?
- block: does it need to "skip" the block error and move on?
- kernel thread: "ignore" the error?
I have no idea what the proper way to do here would be.=C2=A0 Anyone who =
does?
Janpieter.



--mdwkXi8TrEpZasRxjjwT8EhlquRkXJX7B--

--ItRfT9HKqJZRqb1MK7aRQHSyg0MKUWydT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEYEFimytR3ssMbqtSsVSMRQ8fklsFAl70j7cACgkQsVSMRQ8f
klujQAgAkHtb2czOmFc+ZcWiIHISziBnq4DlI71Gx4KXc0tLQurvBEAzpqFAsyZ6
IlrBoYEzaah5oP71OKr9qfdfHBx6U0+1lpAeOGU/prtzXIFUIwczRagAml86QDTK
vJZFlRbXmMFM4+2BUD6htVsR9FG7ph4fbfzDAg7QcGX4UCn2e0DboZ8P8VgegF1E
DKBEGf9rCjJj+iNwEoLKp2kumERBjyvEJ8/kqR6U6Fu9jUQyMjx15DYrHQO8tx73
fSjip8kVAh8Kq5ozdkbSsv8K14D1GuZQJ8FU+jTtajnuguqn3vmjmAMnpy+aaOZH
+hte8Si1xA9TV9gBlBtnj7QyeFWJNA==
=7jKZ
-----END PGP SIGNATURE-----

--ItRfT9HKqJZRqb1MK7aRQHSyg0MKUWydT--
