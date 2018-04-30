Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0067.outbound.protection.outlook.com ([104.47.34.67]:6807
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752701AbeD3JLh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Apr 2018 05:11:37 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH v2 0/3] Rework write error handling in pblk
Date: Mon, 30 Apr 2018 09:11:30 +0000
Message-ID: <33E16356-2CFE-43D2-9298-98CF9D598A51@cnexlabs.com>
References: <1524548732-4326-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <7536f5dc-bc11-ae4b-b11e-9c3995142cd0@lightnvm.io>
In-Reply-To: <7536f5dc-bc11-ae4b-b11e-9c3995142cd0@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_E13FE755-3BFF-4A76-9927-26DB353A0D87";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_E13FE755-3BFF-4A76-9927-26DB353A0D87
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 28 Apr 2018, at 21.31, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 4/23/18 10:45 PM, Hans Holmberg wrote:
>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>> This patch series fixes the(currently incomplete) write error =
handling
>> in pblk by:
>>  * queuing and re-submitting failed writes in the write buffer
>>  * evacuating valid data data in lines with write failures, so the
>>    chunk(s) with write failures can be reset to a known state by the =
fw
>> Lines with failures in smeta are put back on the free list.
>> Failed chunks will be reset on the next use.
>> If a write failes in emeta, the lba list is cached so the line can be
>> garbage collected without scanning the out-of-band area.
>> Changes in V2:
>> - Added the recov_writes counter increase to the new path
>> - Moved lba list emeta reading during gc to a separate function
>> - Allocating the saved lba list with pblk_malloc instead of kmalloc
>> - Fixed formatting issues
>> - Removed dead code
>> Hans Holmberg (3):
>>   lightnvm: pblk: rework write error recovery path
>>   lightnvm: pblk: garbage collect lines with failed writes
>>   lightnvm: pblk: fix smeta write error path
>>  drivers/lightnvm/pblk-core.c     |  52 +++++++-
>>  drivers/lightnvm/pblk-gc.c       | 102 +++++++++------
>>  drivers/lightnvm/pblk-init.c     |  47 ++++---
>>  drivers/lightnvm/pblk-rb.c       |  39 ------
>>  drivers/lightnvm/pblk-recovery.c |  91 -------------
>>  drivers/lightnvm/pblk-rl.c       |  29 ++++-
>>  drivers/lightnvm/pblk-sysfs.c    |  15 ++-
>>  drivers/lightnvm/pblk-write.c    | 269 =
++++++++++++++++++++++++++-------------
>>  drivers/lightnvm/pblk.h          |  36 ++++--
>>  9 files changed, 384 insertions(+), 296 deletions(-)
>=20
> Thanks Hans. I've applied 1 & 3. The second did not apply cleanly to =
for-4.18/core. Could you please resend a rebased version?

Hans' patches apply on top of the fixes I sent this week. I have just
sent the V2 and the patches still apply. You can find them at:
  https://github.com/OpenChannelSSD/linux/tree/for-4.18/pblk

Javier

--Apple-Mail=_E13FE755-3BFF-4A76-9927-26DB353A0D87
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlrm3cAACgkQIX4xUKFR
nnQ2FA/9E9J9apS2axTcK9V8tnhqPoUUlEnXrRoBjZaI4W7DTev0zTr03x0Eu6Sr
XM4XEo1VnqQsR6FFb5EFZuXA0UPHMUXJjS9rfn2OzULVuv6lz6Ckb35NnpgUKX+M
Jegmybh/bEaU32d2iUMDZgVnatH208WDVH0KxBPoILYn+WziBj+SANaeEtb9qxXW
5bRtBkLgzUcwn33IS0uFiYboV0pvzmCAW3LO36cFfEOeAHrMqH8Zc1twym7ckSDv
jwJ1yNef9168reLPRY5tAakZ64EhgXeLSDkF3OF7vZNqFWH2ZYsocgLyfMXCvPRu
Tdo08FGesc8ruyGn0+6YAQnU23rNTGmYoQWSMAMTf6hjPjIGiL94exSs8KMcU56S
6dXNSuNspXcKwmC6ruOugKHepNE8Uz8dTuBiV8m+OI7rW5JbcHVoy9lWG++rDgNp
b9mX8bEdiyiEvj/XnAQi9p7URNCmqZwjJ/Tur+HxGrfVQVargNQ6g+iUcl6dEc/l
u891tUIp9aJcoWrjTaAB5F1qEkXIhPrCcIrvXFwcKrDHnTsUIEiDiLDZvjDaISe+
bUt3fzsxBPQz3S3Y43pAP3cD0Jw8b74jvDvAtd69Mll5dmIBbTd8pgrjrhaPcW79
vZmgphbxdUkCunGwqrWVmHNtkHSrPnGfjCFcO1N7bp5jJO6Zm+w=
=6bPW
-----END PGP SIGNATURE-----

--Apple-Mail=_E13FE755-3BFF-4A76-9927-26DB353A0D87--
