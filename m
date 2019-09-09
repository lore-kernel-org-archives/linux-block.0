Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F194C4740A
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 23:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1227121479
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 23:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfIIXdy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 19:33:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:43958 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728358AbfIIXdy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Sep 2019 19:33:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0C00AD31;
        Mon,  9 Sep 2019 23:33:52 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Song Liu <songliubraving@fb.com>
Date:   Tue, 10 Sep 2019 09:33:46 +1000
Cc:     Coly Li <colyli@suse.de>, NeilBrown <neilb@suse.com>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [PATCH] md/raid0: avoid RAID0 data corruption due to layout confusion.
In-Reply-To: <242E3FBD-C969-44E1-8DC7-BFE9E7CBE7FD@fb.com>
References: <10ca59ff-f1ba-1464-030a-0d73ff25d2de@suse.de> <87blwghhq7.fsf@notabene.neil.brown.name> <FBF1B443-64C9-472A-9F41-5303738C0DC7@fb.com> <f3c41c4b-5b1d-bd2f-ad2d-9aa5108ad798@suse.de> <9008538C-A2BE-429C-A90E-18FBB91E7B34@fb.com> <bede41a5-45c5-0ea0-25af-964bb854a94c@suse.de> <87pnkaardl.fsf@notabene.neil.brown.name> <242E3FBD-C969-44E1-8DC7-BFE9E7CBE7FD@fb.com>
Message-ID: <87ftl5avtx.fsf@notabene.neil.brown.name>
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

On Mon, Sep 09 2019, Song Liu wrote:

> Hi Neil,
>
>> On Sep 9, 2019, at 7:57 AM, NeilBrown <neilb@suse.de> wrote:
>>=20
>>=20
>> If the drives in a RAID0 are not all the same size, the array is
>> divided into zones.
>> The first zone covers all drives, to the size of the smallest.
>> The second zone covers all drives larger than the smallest, up to
>> the size of the second smallest - etc.
>>=20
>> A change in Linux 3.14 unintentionally changed the layout for the
>> second and subsequent zones.  All the correct data is still stored, but
>> each chunk may be assigned to a different device than in pre-3.14 kernel=
s.
>> This can lead to data corruption.
>>=20
>> It is not possible to determine what layout to use - it depends which
>> kernel the data was written by.
>> So we add a module parameter to allow the old (0) or new (1) layout to be
>> specified, and refused to assemble an affected array if that parameter is
>> not set.
>>=20
>> Fixes: 20d0189b1012 ("block: Introduce new bio_split()")
>> cc: stable@vger.kernel.org (3.14+)
>> Signed-off-by: NeilBrown <neilb@suse.de>
>
> Thanks for the patches. They look great. However, I am having problem
> apply them (not sure whether it is a problem on my side). Could you=20
> please push it somewhere so I can use cherry-pick instead?

I rebased them on block/for-next, fixed the problems that Guoqing found,
and pushed them to=20
  https://github.com/neilbrown/linux md/raid0

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl124VoACgkQOeye3VZi
gblMmQ//d6JbqTSTK0qJltXrwDWAz38FKTaT7926c+6/yolugrA2WuCe+8qwGDmO
61l8THd4a44rSxKazwF/sr4Ky1Zpszai7xVgD8h3RbNxuA4s0n2YTA+NoQPotgm8
nqfnQx9CxW0RiC1J/RT6wlcfzI/UDhNAkt7nBuZsSk65Ms71DbnDF4iw/YnisrMC
RWcNiJZjAZNenLRjy8h8z6GOdH63682+eu2jD35ncSEmwbjIk3B13+cMagRDy9od
MGjum+kx7zaJLh45hPw8/e5i8nPmeQkAzJBsQzl0b65QcwmV51dZS99WjeCdhfn/
GRNFOwBcbhj91p2iQrEQeITQRS/B4ieYRlbYOW3EuWhSaqFgbHTmERUySsBsJt/L
r4F15JKL1Zm/bbLxh2ayJ0pYECcv+WdZPwu+rpUiEad4bYsdTyv0ikuVL3Rl4PqR
DL/nVrYVqXV3sxQ+ZKqanQ810YtfuXGRU85Sycq4K4M38uuByhw0N2EkpyAYNhof
HTPF0dr1L0E69R+CBXcy//rs5UNyTcj9FYZUUToPLa0FJ0WXLW8IUYFvL/MvTFJi
3yziR8SQCsPpG/F+XPNCbh6NjDjvAySPDg+Ia9WukcKDxLOpg+xVttAechaXiuTD
qrSQaQGz+HnYfwbDnzAK9ph2Ud9DDCXytH77fIj9+uSo3XTUIyU=
=p0Vo
-----END PGP SIGNATURE-----
--=-=-=--
