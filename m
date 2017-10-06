Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:49857 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbdJFN2s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Oct 2017 09:28:48 -0400
Received: by mail-wm0-f46.google.com with SMTP id b189so7596865wmd.4
        for <linux-block@vger.kernel.org>; Fri, 06 Oct 2017 06:28:47 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <3ECEB320-3133-4E85-90EA-1F8AAD597ED6@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_047FF7B3-36A9-46DE-9694-3AF404455393";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] lightnvm: pblk: remove spinlock when freeing line
 metadata
Date: Fri, 6 Oct 2017 15:28:44 +0200
In-Reply-To: <7960b012-1154-fdad-0c45-c952357f13f5@virtuozzo.com>
Cc: Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <1507192546-12156-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <7960b012-1154-fdad-0c45-c952357f13f5@virtuozzo.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_047FF7B3-36A9-46DE-9694-3AF404455393
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

> On 6 Oct 2017, at 11.20, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> 
> On 10/05/2017 11:35 AM, Hans Holmberg wrote:
>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>> 
>> Lockdep complains about being in atomic context while freeing line
>> metadata - and rightly so as we take a spinlock and end up calling
>> vfree that might sleep(in pblk_mfree).
>> 
>> There is no need for holding the line manager free_lock while
>> freeing line metadata, so remove the lock.
>> 
>> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> 
> I guess this also deserves stable tag. The bug was introduced in 4.13 by
> commit 588726d3ec68 ("lightnvm: pblk: fail gracefully on irrec. error").
> 

Good point. We'll add it when picking it up.

Thanks,
Javier

--Apple-Mail=_047FF7B3-36A9-46DE-9694-3AF404455393
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnXhQwACgkQYx8FO3WZ
GMq/JBAAxBUc9m7c9xKHGiR9ExzHDl6I0NvRGmH/33Ad2TAirh3YtyKEK9gmiVYK
asFfqDH74zLXB1/X7I80Upy5FwDGeYId8vdHo5eSZPY9SD+lddUyf8vFCopIJk+Q
BozNbiJG7F7IK2OKICuEXPuWhY2ZlgA2yggJm9L8kulEDVMDnlIY59UTy7gjR82q
suIjJfbxXUkfOuzwxZ3PJ9Tkx9vfFbMaZZPGxoxnDrsXAf5Q6uCnE35N4EvMpetY
8ecMZmrcuNiqwzgnW4ou3oJeNbp6xmupuJdnJL6j+pgOLaD0g3Tk2WHVkywad+D1
OpMm1Zdoleuc00tfBWJUFToMTdZU+zzIZWa6XlSmyukU2dtwQU0CjW6xyaUwVpdl
Vp6wXzoox0OvgrC4AZj1M//+aauFYp8AxgKRCI0BDaJupmiE8TIaopOIM0Tykh1c
6oQHqmO4yOm1qRPLtkndNH3IhFNkj9WhXPX9vbvc1gg0tYEMUe/93O1JL3ggBVB4
Z7ISnL5pzUg1FzbQg4v6OtDuAm7g0xmRSJU96wuKlhKP2i8wkfQNYp/liAd5tF9S
8+wjICT5O+NmqmV0xih5PTBZdfbZ9z6UhfmQwliDn3VZ9iO+XH4fDCKhZFuQzxKN
6HgNnD9A2QVnLboaaPC6zpYkEfI34WARys6mS4Xba3H6axliW78=
=XnR1
-----END PGP SIGNATURE-----

--Apple-Mail=_047FF7B3-36A9-46DE-9694-3AF404455393--
