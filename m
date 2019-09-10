Return-Path: <SRS0=q0Gp=XF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864C5C49ED7
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 23:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6120721A4C
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 23:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfIJXIi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Sep 2019 19:08:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:39844 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725932AbfIJXIi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Sep 2019 19:08:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68E7EAF4C;
        Tue, 10 Sep 2019 23:08:36 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <songliubraving@fb.com>,
        Guoqing Jiang <jgq516@gmail.com>
Date:   Wed, 11 Sep 2019 09:08:25 +1000
Cc:     Coly Li <colyli@suse.de>, NeilBrown <neilb@suse.com>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [PATCH] md/raid0: avoid RAID0 data corruption due to layout confusion.
In-Reply-To: <58722139-ebc0-f49f-424a-c3b1aa455dd8@cloud.ionos.com>
References: <10ca59ff-f1ba-1464-030a-0d73ff25d2de@suse.de> <87blwghhq7.fsf@notabene.neil.brown.name> <FBF1B443-64C9-472A-9F41-5303738C0DC7@fb.com> <f3c41c4b-5b1d-bd2f-ad2d-9aa5108ad798@suse.de> <9008538C-A2BE-429C-A90E-18FBB91E7B34@fb.com> <bede41a5-45c5-0ea0-25af-964bb854a94c@suse.de> <87pnkaardl.fsf@notabene.neil.brown.name> <242E3FBD-C969-44E1-8DC7-BFE9E7CBE7FD@fb.com> <87ftl5avtx.fsf@notabene.neil.brown.name> <33AD3B45-E20D-4019-91FA-CA90B9B3C3A9@fb.com> <58722139-ebc0-f49f-424a-c3b1aa455dd8@cloud.ionos.com>
Message-ID: <877e6fbvh2.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10 2019, Guoqing Jiang wrote:

> On 9/10/19 5:45 PM, Song Liu wrote:
>>=20
>>=20
>>> On Sep 10, 2019, at 12:33 AM, NeilBrown <neilb@suse.de> wrote:
>>>
>>> On Mon, Sep 09 2019, Song Liu wrote:
>>>
>>>> Hi Neil,
>>>>
>>>>> On Sep 9, 2019, at 7:57 AM, NeilBrown <neilb@suse.de> wrote:
>>>>>
>>>>>
>>>>> If the drives in a RAID0 are not all the same size, the array is
>>>>> divided into zones.
>>>>> The first zone covers all drives, to the size of the smallest.
>>>>> The second zone covers all drives larger than the smallest, up to
>>>>> the size of the second smallest - etc.
>>>>>
>>>>> A change in Linux 3.14 unintentionally changed the layout for the
>>>>> second and subsequent zones.  All the correct data is still stored, b=
ut
>>>>> each chunk may be assigned to a different device than in pre-3.14 ker=
nels.
>>>>> This can lead to data corruption.
>>>>>
>>>>> It is not possible to determine what layout to use - it depends which
>>>>> kernel the data was written by.
>>>>> So we add a module parameter to allow the old (0) or new (1) layout t=
o be
>>>>> specified, and refused to assemble an affected array if that paramete=
r is
>>>>> not set.
>>>>>
>>>>> Fixes: 20d0189b1012 ("block: Introduce new bio_split()")
>>>>> cc: stable@vger.kernel.org (3.14+)
>>>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>>>
>>>> Thanks for the patches. They look great. However, I am having problem
>>>> apply them (not sure whether it is a problem on my side). Could you
>>>> please push it somewhere so I can use cherry-pick instead?
>>>
>>> I rebased them on block/for-next, fixed the problems that Guoqing found,
>>> and pushed them to
>>>   https://github.com/neilbrown/linux md/raid0
>>>
>>> NeilBrown
>>=20
>> Thanks Neil!
>
> Thanks for the explanation about set the flag.
>
>>=20
>> Guoqing, if this looks good, please reply with your Reviewed-by
>> or Acked-by.
>
> No more comments from my side, but I am not sure if it is better/possible=
 to use one
> sysfs node to control the behavior instead of module parameter, then we c=
an support
> different raid0 layout dynamically.

A strength of module parameters is that you can set them in
  /etc/modprobe.d/00-local.conf
and then they are automatically set on boot.
For sysfs, you need some tool to set them.

>
> Anyway, Acked-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>

Thanks,
NeilBrown


> Thanks,
> Guoqing

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl14LOoACgkQOeye3VZi
gblZwQ//VfHqCNtcjAEsWdSz/iq1bKr8oC+WiiLO1b4MC74aCt+yLImzmyai1cT5
LixUvOpr+4pcdB5wB+pSkmN9Fmx1CxJGGrsp2ukm7BZ/pr+lnsDdsEmLdtCywsvU
DxBvQLHRuJC18o2XkfCs42I7+gYjEZLnnqEAdxBQcNA4ukAdLDyA0db2n53X9FJm
sX+HnR0yXSA2GScqtSVJOxB6pKjcO+L/aWmiozxCBOfeYcBTNwUGukFXhyDzgG5N
sWnka2gYxUgiKMqD/1B/7u0HaSPmfYiuR8fuuJGVDhpfRhT8ptExE5cQmtXs0oW1
gAsStep1WjvGdyUdTduxlREBmau6B7xjdMSU/X8wYdX95cRWBkuzgXyuMgTJu7eP
64U9qp1b2qugD7nS5RR7gREu485m2fOeGSfwkiGYA04ajfqe+e9OhXygkohuyYbt
ScCMSEPS8YGrx7if55LgZ4vxF0IU6P+zzHPyr5cuQrCv3vRv+CuUxuYUxn4Cy263
cdsJvGgPefgLKVlxKb6ZhzSDMZjJPV6gACQ+wvzzdXjK9ZMQa8xwbjwVMBM6hLHf
pGhZC/FXSzbmKphPIW4vvH2FOd+cquglb5vc8Ft4U3kn3dKN+o7zFPUzGnb44Sfc
uZJRBj72VFZKbWfOD0et5RHFwAvhZNAYf0mINK1VtqrDHHcEJ/4=
=bGKk
-----END PGP SIGNATURE-----
--=-=-=--
