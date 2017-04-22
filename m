Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:36336 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1043744AbdDVJbg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Apr 2017 05:31:36 -0400
Received: by mail-it0-f54.google.com with SMTP id g66so11607636ite.1
        for <linux-block@vger.kernel.org>; Sat, 22 Apr 2017 02:31:35 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <ACB77414-F14D-4FBE-90D2-555E95B127C3@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C531D83F-5CAA-424B-8729-093DE5896455";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 5/5] lightnvm: pblk: fix erase counters on error fail
Date: Sat, 22 Apr 2017 11:31:17 +0200
In-Reply-To: <9d864388-00e8-d5e4-eef7-2f5d4d8f738d@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
 <1492817569-13532-6-git-send-email-javier@cnexlabs.com>
 <9d864388-00e8-d5e4-eef7-2f5d4d8f738d@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_C531D83F-5CAA-424B-8729-093DE5896455
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 22 Apr 2017, at 11.22, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 04/22/2017 01:32 AM, Javier Gonz=C3=A1lez wrote:
>> When block erases fail, these blocks are marked bad. The number of =
valid
>> blocks in the line was not updated, which could cause an infinite =
loop
>> on the erase path.
>>=20
>> Fix this atomic counter and, in order to avoid taking an irq lock on =
the
>> interrupt context, make the erase counters atomic too.
>=20
> I can't find out where the counters are used in irq context? Can you
> point me in the right direction? I'll prefer for these counters to go
> in under the existing line_lock.
>=20

This counter is line->blk_in_line, which is used on pblk_mark_bb. This
is triggered on the erase completion path. Note that we do not want to
wait until the recovery kicks in on the workqueue since the line might
start getting recycled straight away if we are close to reaching
capacity. This is indeed the scenario that triggers the race condition.

Making all erase counters atomic allows us to avoid taking the
line_lock. Note that the counters do not depend on each other.

>> Also, in the case that a significant number of blocks become bad in a
>> line, the result is the double shared metadata buffer (emeta) to stop
>> the pipeline until all metadata is flushed to the media. Increase the
>> number of metadata lines from 2 to 4 to avoid this case.
>=20
> How does moving to 4 lines solve this case? The way I read it is that
> it only postpones when this occurs?
>=20

The chances of having more than 2 lines falling out of blocks after
pre-condition are slim. Adding two more lines should be enough.

>>=20
>> [...]
>>=20
>> -#define PBLK_DATA_LINES 2
>> +#define PBLK_DATA_LINES 4
>=20
> Why this change? I like to keep new features for 4.13. Only bugfixes =
for 4.12.

This is the 4 lines referred above. I see it as a bug fix since we risk
stalling the pipeline if a line goes above a certain number of bad
blocks on initialization, but we can leave it out and fix this when we
add in-line metadata on the write thread for 4.12

Thanks,
Javier

--Apple-Mail=_C531D83F-5CAA-424B-8729-093DE5896455
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJY+yLmAAoJEGMfBTt1mRjKOBEP/2qPJ7ik2etK6An/OWHiUcXD
JOOpRUPCby8+kuwC19w/7ucLdsYRjpZZGHyQ0nqfZ+UuQyWTVirGpu3bTHC5kNuU
sgCfceoS8NvW6gUvROG7/yu0xyD8KREEJzBMCzD7T45W1LyZJlkmBtRPUoSOPiOf
BK+ildUsTGpOdDuBIIhDVTcINra3KpwaMdxf4oXUvy+hDNleDSfqfbGTO9Ldvzu1
PmcS2jZgvDxy/zJSdBSR2C/Wc9R54LXBV1hIynaD+GonZERTkNT4D8LYK6KagNEQ
eacLgswtqBwo7Hwbdl3EoNEjI0Sh62ypQSmmI27he3F0+MvYlQtHxvyvvwPJOtVu
pVRXObolVTH+WYIR1mWgFoXsiOEOOA0PML7QKa3EZM+VFixFzKgtTaZ6Ji0dGZCQ
zPdlzhMyMlDcB3pfD/XvroRDfyTC4TeFSCT0VmN5PHqBaRHqoG2VaF1Vl464VfVF
Xr/Zpv8RSUXgaBUiY7UJUtJIWfk9bobO1gw1T7Q9UjVRXc+4F35XDhih7wrNoDcK
8TsByKsEePVacDjDHTne9f+FaDPn8GHf/d0Ep2o1ZlHCrAE1RZIE9LyKhCBXebrG
suDLBBVs0Hro8lz4CRTfOm8v76y/XsQIB8IouMKQjVr1HghrGNf4DaEPztPPzYgZ
I6LNEXee229KXFXCndtj
=yHYR
-----END PGP SIGNATURE-----

--Apple-Mail=_C531D83F-5CAA-424B-8729-093DE5896455--
