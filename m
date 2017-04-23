Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35857 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163063AbdDWSSf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Apr 2017 14:18:35 -0400
Received: by mail-wm0-f47.google.com with SMTP id u65so8110845wmu.1
        for <linux-block@vger.kernel.org>; Sun, 23 Apr 2017 11:18:34 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <49FF1B52-B43D-4AAF-A6E6-EC49D8487976@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8F6434DF-3E1F-4D51-8C0F-0AED2CE0F038";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 5/5] lightnvm: pblk: fix erase counters on error fail
Date: Sun, 23 Apr 2017 20:18:33 +0200
In-Reply-To: <9a4a3f1d-1919-b2e6-31e9-48f5ad823638@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
 <1492817569-13532-6-git-send-email-javier@cnexlabs.com>
 <9d864388-00e8-d5e4-eef7-2f5d4d8f738d@lightnvm.io>
 <ACB77414-F14D-4FBE-90D2-555E95B127C3@lightnvm.io>
 <9a4a3f1d-1919-b2e6-31e9-48f5ad823638@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_8F6434DF-3E1F-4D51-8C0F-0AED2CE0F038
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 23 Apr 2017, at 19.59, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 04/22/2017 11:31 AM, Javier Gonz=C3=A1lez wrote:
>>> On 22 Apr 2017, at 11.22, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 04/22/2017 01:32 AM, Javier Gonz=C3=A1lez wrote:
>>>> When block erases fail, these blocks are marked bad. The number of =
valid
>>>> blocks in the line was not updated, which could cause an infinite =
loop
>>>> on the erase path.
>>>>=20
>>>> Fix this atomic counter and, in order to avoid taking an irq lock =
on the
>>>> interrupt context, make the erase counters atomic too.
>>>=20
>>> I can't find out where the counters are used in irq context? Can you
>>> point me in the right direction? I'll prefer for these counters to =
go
>>> in under the existing line_lock.
>>=20
>> This counter is line->blk_in_line, which is used on pblk_mark_bb. =
This
>> is triggered on the erase completion path. Note that we do not want =
to
>> wait until the recovery kicks in on the workqueue since the line =
might
>> start getting recycled straight away if we are close to reaching
>> capacity. This is indeed the scenario that triggers the race =
condition.
>>=20
>> Making all erase counters atomic allows us to avoid taking the
>> line_lock. Note that the counters do not depend on each other.
>>=20
>>>> Also, in the case that a significant number of blocks become bad in =
a
>>>> line, the result is the double shared metadata buffer (emeta) to =
stop
>>>> the pipeline until all metadata is flushed to the media. Increase =
the
>>>> number of metadata lines from 2 to 4 to avoid this case.
>>>=20
>>> How does moving to 4 lines solve this case? The way I read it is =
that
>>> it only postpones when this occurs?
>>=20
>> The chances of having more than 2 lines falling out of blocks after
>> pre-condition are slim. Adding two more lines should be enough.
>>=20
>>>> [...]
>>>>=20
>>>> -#define PBLK_DATA_LINES 2
>>>> +#define PBLK_DATA_LINES 4
>>>=20
>>> Why this change? I like to keep new features for 4.13. Only bugfixes =
for 4.12.
>>=20
>> This is the 4 lines referred above. I see it as a bug fix since we =
risk
>> stalling the pipeline if a line goes above a certain number of bad
>> blocks on initialization, but we can leave it out and fix this when =
we
>> add in-line metadata on the write thread for 4.12
>>=20
>> Thanks,
>> Javier
>=20
> Okay. It tickles me a bit. However, to make it pretty, some
> refactoring is needed, which we won't push for this release.
>=20
> Reviewed-by: Matias Bj=C3=B8rling <matias@cnexlabs.com>


Yes, you are right. I think it will become much better as we implement
the FTL log and refactor the metadata path.

Thanks!
Javier

--Apple-Mail=_8F6434DF-3E1F-4D51-8C0F-0AED2CE0F038
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJY/O/6AAoJEGMfBTt1mRjK0qwQALebVII9IcKvQ1ckm9o/ggVi
PZbVTluFB6MiLagFkWVJPEi2HLEPX8pGzCGl2lOL0fx2rln4wLoT67F47wqXT1Fr
MI3cIpHCGQPg7tvXYiejcWIBzYYeE+fOKPrGunZeTB95PEkILL5qo48Lzk5JlSfB
DVakzrUGB8dJkl/UwfIdP0rfJN0fbNi2tVP0vdGbp612pLrCLzNguHbzGKg/OQwo
5/q+oC6bj76jTwyhfgNDkjFCncIZBn9R3X+ZmsLEv1kkzrD6WiEHb3JKPqiSZGuX
Pf48gS93RaywyIMaV13TW1peh+LKDgs0xEQGk0YDBt/uPXrJvvTV59nRF7Eo+F8X
p+eJENxGtREPnE7cukXcWZtUTSEb0GkprhRkIbjw83bs5m3rBD9o8q31ulTBYlDi
JtY9KFDoUHkEv06TzzdanCma12d1hgAAM2lRaMEDMFkuFU/rjXETRlEtIK3Rjeec
k5vRvqFNr7KCYrXinUhp+P8pBNG2lo9UFO6VMFJrBlgJXSBEnrFYY+4grV0zf3zW
rYgXQ+6+QhoXOK0eOTwZP8FTt0PUkkRvp6j6KoyX4LQEF3qyjjY17jAaNMJnnj5T
w/E01jCmjz0AqmrpbupjVex0xbNaCyTIknKUJhd1m2rlWZO97nQutO9piwQHmnCH
bDw/SxEF4Fy/G4PALHQ7
=zJIU
-----END PGP SIGNATURE-----

--Apple-Mail=_8F6434DF-3E1F-4D51-8C0F-0AED2CE0F038--
