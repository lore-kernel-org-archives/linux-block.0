Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F7CC31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C0E215EA
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DF7lFpNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbfFMQpM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:45:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34912 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbfFMGKo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 02:10:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so8764146wml.0
        for <linux-block@vger.kernel.org>; Wed, 12 Jun 2019 23:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=nIFKJpfyK2DxoQfFQcfYz4XDj8g98HiIMkXp7eU/vOE=;
        b=DF7lFpNIZm11PUqgPUscuIW7PKtZToXjoi9lvl3FR1Q9DRGg14WXbYeszl5jLzlSq4
         nfCCh6z1NER5WcVNsoKKSjsxwj2N5WiROdNkXxo/k0TgUFZQ0e7bSPnPTP1c/rSRBsuK
         pNRGCUTRwzKUWTzCnKuci7YFqe0wmVdVxQh6CmK8jxO8ELZgc3k5dfH0h3FcRHCtNLiX
         ycTmN8bo0zmkg19lfL4IR6qrH9K1UtpvGDs3sx0yz7HAek2Dg/nmLT2onm8pLgeYU3wr
         89jR2q8+e2+5lQu1RCt9wEM2ACvXxTZoG4rxus6i6ykaemPNgDhQGCdYnc1L4MaWJHEJ
         WmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=nIFKJpfyK2DxoQfFQcfYz4XDj8g98HiIMkXp7eU/vOE=;
        b=swVIK4CiDecUlTwRbrI5QjZNu2yXcFqbXe9NmKc2RrqGtkjVz/4v0Ep8/0bSSjl2jI
         9Bj/GDt1wfbLuNgZL2OE2L6MQuCwHjlZ0kq0NEKVqSMNnjQaXqEwt3O1dWvmw3e8zmuq
         rL+LIvMBp/z7/1XyGSDBr0J+5Yn/ZtJluMqFvgeVR10ESDA2eRQvKhyBA2qG/Cs2x2eX
         lSGNYW0p7S83cCrn6qGZlwZUQ7gWs8wTgUPn6GMrvXRJPiMd1MIdQNM9W8wrLsjNtAbC
         0y012lHFXlVu9VvOvo8fOe9Y0XEZTaDaCTysEXR50W9hvwRBoJaF0QmhWQ2/f7GEo1lY
         aeKg==
X-Gm-Message-State: APjAAAW/76+Z+VPl4Cowye7s7M26UPZo/2xuPyL2e2K5OBgIypCL0ZGO
        T0XkQCkh6oJDUxEAtaxLBIzxjg==
X-Google-Smtp-Source: APXvYqy+cl8n4hDv1iOEmh12JXvIEAJuVbxqKY/0pT+UyDt/8JbKHMem8Geo16+D7J3h9STcUoQgZA==
X-Received: by 2002:a7b:c018:: with SMTP id c24mr1933499wmb.37.1560406241185;
        Wed, 12 Jun 2019 23:10:41 -0700 (PDT)
Received: from [192.168.0.102] (88-147-71-233.dyn.eolo.it. [88.147.71.233])
        by smtp.gmail.com with ESMTPSA id w14sm2179319wrt.59.2019.06.12.23.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 23:10:40 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <530F0FC2-EBE5-4417-8732-010837C18357@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_517D8028-653A-4641-A322-BAD7B9C9C32F";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH block/for-5.2-fixes] bfq: use io.weight interface file
 instead of io.bfq.weight
Date:   Thu, 13 Jun 2019 08:10:38 +0200
In-Reply-To: <20190612133926.GN3341036@devbig004.ftw2.facebook.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Fam Zheng <fam@euphon.net>
To:     Tejun Heo <tj@kernel.org>
References: <4f801c9b-4ab6-9a11-536c-ff509df8aa56@kernel.dk>
 <CAHk-=whXfPjCtc5+471x83WApJxvxzvSfdzj_9hrdkj-iamA=g@mail.gmail.com>
 <52daccae-3228-13a1-c609-157ab7e30564@kernel.dk>
 <CAHk-=whca9riMqYn6WoQpuq9ehQ5KfBvBb4iVZ314JSfvcgy9Q@mail.gmail.com>
 <ebfb27a3-23e2-3ad5-a6b3-5f8262fb9ecb@kernel.dk>
 <90A8C242-E45A-4D6E-8797-598893F86393@linaro.org>
 <20190610154820.GA3341036@devbig004.ftw2.facebook.com>
 <20190611194959.GJ3341036@devbig004.ftw2.facebook.com>
 <20190611211718.GM3341036@devbig004.ftw2.facebook.com>
 <A1C3E3D8-62E3-4BD3-86B4-59E7E1319EA8@linaro.org>
 <20190612133926.GN3341036@devbig004.ftw2.facebook.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_517D8028-653A-4641-A322-BAD7B9C9C32F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 12 giu 2019, alle ore 15:39, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> On Wed, Jun 12, 2019 at 09:32:07AM +0200, Paolo Valente wrote:
>> Could you elaborate a little more on this?
>=20
> Doesn't seem like you did.
>=20
>> bfq code for setting up and handling io.weight (more precisely
>> io.bfq.weight) is a copy and paste of cfq code.
>=20
> Please take a look at the documentations under
> Documentation/cgroup-v1/blk-iocontroller.txt and
> Documentation/admin-guide/cgroup-v2.rst.
>=20

I'm sorry, but I don't see what doesn't match between BFQ's and CFQ's
implementations of the weight parameter.

So, if you agree, let me paste the two snippets for v1 that involve
weights.  So maybe you can at least tell me 'here' (then I'll try the
same with v2).

----------------------------------------------------------------------

	mount -t tmpfs cgroup_root /sys/fs/cgroup
	mkdir /sys/fs/cgroup/blkio
	mount -t cgroup -o blkio none /sys/fs/cgroup/blkio

- Create two cgroups
	mkdir -p /sys/fs/cgroup/blkio/test1/ /sys/fs/cgroup/blkio/test2

- Set weights of group test1 and test2
	echo 1000 > /sys/fs/cgroup/blkio/test1/blkio.weight
	echo 500 > /sys/fs/cgroup/blkio/test2/blkio.weight

-> This is exactly how you set weights with BFQ

----------------------------------------------------------------------

Details of cgroup files
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Proportional weight policy files
--------------------------------
- blkio.weight
	- Specifies per cgroup weight. This is default weight of the =
group
	  on all the devices until and unless overridden by per device =
rule.
	  (See blkio.weight_device).
	  Currently allowed range of weights is from 10 to 1000.

-> This is the exact implementation of the weight parameter in BFQ

BFQ does not implement weight_device, but we are not talking about
weight_device here.  More precisely, *nothing* implements weight_device
any longer in cgroups-v1, so the documentation is wrong altogether.

Looking forward to your feedback,
Paolo



> Thanks.
>=20
> --
> tejun


--Apple-Mail=_517D8028-653A-4641-A322-BAD7B9C9C32F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAl0B6N4ACgkQOAkCLQGo
9oOl9g//UupzRj6giFZAUQHDFrdcqt9Awx9xxl+kGzBIdD9vz8Yb8x3Rd7wQkh3o
4TKr6D3pn+bRpfpBHoKDtOE/AoY80ADAIwBp7UfEm3hX6cIxC0QcBUR3dh+Uxhjs
IOpHJub0PTN5gBIn2jBkneI9BLIjzpSzBVroj3ZyR2IJNuPtYDYiPKDKRMeKMOba
duvUtxSxmLmUnoGOJM55983MAJOiEP66ErrY2Ijb5jr/hs1Mb4c4kwOb/9fAbvFD
wpjLaW83AglTa9AQAgpNZV0lXGxHlLrLQKKebU4iZuXw96SQUrtHtUN0m1q3RF6U
REDn4Zg9XI2jp3TYm3GgLaSX0kBDOZ/GCS3nNAkJvzB1Q6AWVzthmzo0TtYsf+1Q
G3RPWZ+h8zxCA7yK3VorJlr5Tj32PK7JmlCojHvKcPQHyS9VymPlxcmp6p6RuGBA
glkRDHlFQRqgy9Rcgi0I1I7VJ9q+MxqaL1jOGLNMBrSO45guJR7HAwlucHQCLF7l
fXeUtxH6FVcgBy9ab3B8N/JT5T4zQJm1GyOA0M7fRVdgmK4ZBXlhnu1hxBKqnBJa
V1Swq4MMzwg2VLj/jlzW6k++fCeBRAHW477dmOAtfzIRwLhB3oJblv6uzwg/zN/J
P6JACzPrq8bPwfho6vYrw3DZBsbxkaVakgrV1nJ+eIJdZty1kgg=
=0CbJ
-----END PGP SIGNATURE-----

--Apple-Mail=_517D8028-653A-4641-A322-BAD7B9C9C32F--
