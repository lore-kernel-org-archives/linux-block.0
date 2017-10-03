Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:50781 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdJCGmj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 02:42:39 -0400
Received: by mail-wm0-f48.google.com with SMTP id u138so14410036wmu.5
        for <linux-block@vger.kernel.org>; Mon, 02 Oct 2017 23:42:38 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <79741F33-8191-4121-96BE-51385BCD1F3D@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_EC0A209F-5285-4DED-9F4C-41E7F07B20AD";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 5/6] lightnvm: pblk: free up mempool allocation for erases
 correctly
Date: Tue, 3 Oct 2017 08:42:34 +0200
In-Reply-To: <20171002171842.GA6008@hercules.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20171001132555.GA5763@hercules.tuxera.com>
 <5E8B439C-5971-49DF-BDC4-3B53268F8FF4@lightnvm.io>
 <20171002122510.GA3946@hercules.tuxera.com>
 <20171002171842.GA6008@hercules.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_EC0A209F-5285-4DED-9F4C-41E7F07B20AD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 2 Oct 2017, at 19.18, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> On Mon, Oct 02, 2017 at 03:25:10PM +0300, Rakesh Pandit wrote:
>> On Mon, Oct 02, 2017 at 02:09:35PM +0200, Javier Gonz=C3=A1lez wrote:
>>>> On 1 Oct 2017, at 15.25, Rakesh Pandit <rakesh@tuxera.com> wrote:
>>>>=20
>>>> While separating read and erase mempools in 22da65a1b =
pblk_g_rq_cache
>>>> was used two times to set aside memory both for erase and read
>>>> requests.  Because same kmem cache is used repeatedly a single call =
to
>>>> kmem_cache_destroy wouldn't deallocate everything.  Repeatedly =
doing
>>>> loading and unloading of pblk modules would eventually result in =
some
>>>> leak.
>>>>=20
>>>> The fix is to really use separate kmem cache and track it
>>>> appropriately.
>>>>=20
>>>> Fixes: 22da65a1b ("lightnvm: pblk: decouple read/erase mempools")
>>>> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
>>>=20
>>> I'm not sure I follow this logic. I assume that you're thinking of =
the
>>> refcount on kmem_cache. During cache creation, all is good; if a
>>> different cache creation fails, destruction is guaranteed, since the
>>> refcount is 0. On tear down (pblk_core_free), we destroy the =
mempools
>>> associated to the caches. In this case, the refcount goes to 0 too, =
as
>>> we destroy the 2 mempools. So I don't see where the leak can happen. =
Am
>>> I missing something?
>>>=20
>>> In any case, Jens reported some bugs on the mempools, where we did =
not
>>> guarantee forward progress. Here you can find the original =
discussion
>>> and the mempool audit [1]. Would be good if you reviewed these.
>>>=20
>>> [1] https://www.spinics.net/lists/kernel/msg2602274.html
>>=20
>> Thanks, yes makes sense to follow up in patch thread.  I will respond
>> to above questions there later today.
>=20
> I wasn't thinking it right in addition to looking at test results from
> a incorrectly instrumented debugged version.
>=20
> I went through the series you pointed and all seem okay to me now.
>=20
> Please drop this patch.
>=20

Cool.

Javier

--Apple-Mail=_EC0A209F-5285-4DED-9F4C-41E7F07B20AD
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnTMVoACgkQYx8FO3WZ
GMqNhQ/+Pqz0NjY/3TrhfNsS56sMMyr+VqCW7kRk5zKITArDCb2g7XnXhGpMq30L
9nk+jAEz0CmxFoIJSWVYUe9P65YgMkIklAnEI3KrCsbiGseUvQUieYoUtnF35EB5
frBnokRrJvXiVpCRq/CGXxVKUaGK5MRr+p7ia+0q/MADMWCVHW6UcFca1dTwGVqq
K/3ZzWuFSPDKllc7W7pHm1rFjhdIB29qiFSoAcJC4rECxdkr0zht0Wvx3Fa701qZ
hMDxy0utxMokEOkKUyOIU9j70Eagin2TUT26SOVcuFJzYJp2FG8Job5RecSHTuxL
G2NDjV7vzoDw3rEuTICUe9YaST/fksI4KOEWQHxxDXCuzXg4mKlQcf0j95zL/e8m
2I06XSle6GbscbbXqQITIq0LKiv/23TPPrXdHUgP0ffNc7/N+EIP5ivs6fJYe20e
R4O+/ePKdbF7bs5A5kvkqh7TO+anvyCJHd7bN717oAkbEZ9IbddOt135jwou4Cs/
zOeRVvQCJcuikp7xLLjU2rmLhjp9dWqp0LGXbsfL2ZVvqsHNN/H2PvhUZXDsLn1s
rhvjIfkHgK5iIopZaSoRe0rmUYIBRuQ1CW1fShg551o3fbwWpwmXMsGkaUG4N7f0
sfaGTklkqLbHhjUDoXDGIM8SudMhldAm148qz70tsXXSR1IVmlc=
=9lIa
-----END PGP SIGNATURE-----

--Apple-Mail=_EC0A209F-5285-4DED-9F4C-41E7F07B20AD--
