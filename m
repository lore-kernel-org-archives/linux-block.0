Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6FFC282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 14:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8426F2184B
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 14:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="drx0wM4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfAXOgv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:36:51 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32888 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfAXOgv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 09:36:51 -0500
Received: by mail-ed1-f66.google.com with SMTP id p6so4780449eds.0
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 06:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=XeARhplmILrmFnACznjH58BJN5nRjFOsozYGY0quCIE=;
        b=drx0wM4maaDf1HG7Z+juTsEgFBaToJfuoDytGiuY+PWU2rnKCDpzjEXua7n7Missy+
         jdzKMl+/j5d+uQ0aIIlg9DHEMAH+y8OmGEWrcLAB8Hwjk6qToO94gb46e4dKwkeSrbq7
         r4YryffEbagU5eOvsc3JfJVRYR6PeZPix2IOXu6BE5x8cAqrrFUxPto5bAlTw1zRExRD
         u/dBJL3hkoiadwBxAfrUQdmYzUSrUdGkXD5gm9vo+UymD+LXPFPegcojkmKHhrXGVobN
         /ISgoHbkuIic9ACIncCqMAL85xmrGVJJ81zPjZOcKzhgsDkWV1xHnMdNdPy6jwyCe7FN
         VG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=XeARhplmILrmFnACznjH58BJN5nRjFOsozYGY0quCIE=;
        b=uCWHN1HhLNq8vc966cFRpjhXeTRZxokdQgs+Znpli/ARXXzLAfvfzXJlnIuSphLdbs
         O1Zp6l4F9bjPun+S6idi3wOiK4tjE/t/Tm+ACif3KJG/k3+0exkFITpOe2/w394kzmvd
         y57wDHkJ8Zv5vi8bXd0FC+6wYFSlTd8XoNmwJWLBEnvOiDWj9+jE0fZ3zgzrBh53Cj8F
         cTTZp2/HJXYJRUgTZY/Q08tf90ixItnHtBs85asRIKrf4/lhzBIZQIMXDjkoq0wUWq4o
         5Gw+CFhXwJ3cWMdxONCkWZeqQRI9UjIjcVfC5DV9XpaKoGCZk6bf2VR7UQ8mMQdnN6Jw
         2zmw==
X-Gm-Message-State: AJcUukfXMuvRTkq32Buvpntj99ZlSTicgqU4V8h3/G72it47Y1Q/enc0
        dQLKnwkHT0eJ8wDG80HcKwc/OQ==
X-Google-Smtp-Source: ALg8bN6YkB4d6JlzaAgHfTCloMq+fZ8W6iKlFmvABsbovARTxc/rupNn1Z3W/CJRaUlydwGRKV3qeA==
X-Received: by 2002:a50:ad0b:: with SMTP id y11mr6689419edc.113.1548340609385;
        Thu, 24 Jan 2019 06:36:49 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id m10sm122172eja.38.2019.01.24.06.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 06:36:48 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <5FF168CC-9372-4DE5-BF62-DD3A2EE08384@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_8F20AE3E-B846-4392-AAED-51816256F513";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v1] : Switch to use new generic UUID API
Date:   Thu, 24 Jan 2019 15:36:47 +0100
In-Reply-To: <CAHp75Vfd=B-AP=7KNFiDU-qER9BjB0Qw9Lyp+hb8x94NfQiZyA@mail.gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20190110143051.52305-1-andriy.shevchenko@linux.intel.com>
 <20190121084732.GE18680@lst.de> <20190124121659.GH9224@smile.fi.intel.com>
 <6D748F08-F9F9-4DFB-84DF-63E97C691013@javigon.com>
 <CAHp75Vf4ndBaS6BjAM==7csYB9EYDvjV9jT9C6kioDryzb_HnQ@mail.gmail.com>
 <9E0FD459-75F2-4EF1-9310-8FCDF6F87604@javigon.com>
 <CAHp75Vfd=B-AP=7KNFiDU-qER9BjB0Qw9Lyp+hb8x94NfQiZyA@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_8F20AE3E-B846-4392-AAED-51816256F513
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 24 Jan 2019, at 15.13, Andy Shevchenko <andy.shevchenko@gmail.com> =
wrote:
>=20
> On Thu, Jan 24, 2019 at 3:45 PM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>> On 24 Jan 2019, at 14.36, Andy Shevchenko =
<andy.shevchenko@gmail.com> wrote:
>>> On Thu, Jan 24, 2019 at 3:19 PM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>>>> On 24 Jan 2019, at 13.16, Andy Shevchenko =
<andriy.shevchenko@linux.intel.com> wrote:
>=20
>>>>> header.uuid is defined using __u8 type, I'm not sure we can use =
guid_t there.
>>>>=20
>>>> We can turn it into a guid_t and bump the minor version.
>>>=20
>>> It's not so easy. __uXX types are dedicated for external APIs. =
guid_t
>>> is kernel internal type disregard of (still) presence some uapi =
bits.
>>> So, the question is those __uXX types in the driver definition is a
>>> simple mistake, (weird) style decision, or what?
>>=20
>> I would define it as a mistake and I think it is worth fixing it. At =
the
>> moment we are only using this uuid for recovery purposes, to discard
>> data from a different pblk instance,
>=20
> Does this come from outside of the kernel in any mean (user space,
> data from device, etc)?
> It sounds to me like it does. In this case there is no mistake and we
> may not use guid_t there.

pblk manages the metadata layout without involvement of the device or
user space, so no, no dependency at this moment.

It is not pushed anywhere yet, but I have been working on a tool to make
a pblk recovery tool to enable FTL repairs if something fails in the
kernel recovery path. Here, I use this uuid to identify the
instance - is there a way to reconcile guid_t with user space, which
currently uses the __u8?

Javier

--Apple-Mail=_8F20AE3E-B846-4392-AAED-51816256F513
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxJzX8ACgkQPEYBfS0l
eOB3dxAAiXDnOPZ4wqH5rh2S9wMRLTw2ioFU1O7OxDFKVFi+7ZYXQe743ldv88YM
1rinFBaOoKpiwP+pRH94xtLv/LlSd3qEvZtdB2yl8CfNc+sUTts3tzUqeuuWzLZw
7/PrdT7jwN2HYuiiSRtE4M4r8Oe8wimjsXX7Gvt6gePH+aD8WScxxtI0zo+XFVbc
i2eYWINUlO2E000LmHJthFW2H5ao5sJ9D0ow2FUyuMUirJHgOyO39+BW87kpwS1z
U6dJuAJd0t/nwfrMHDKdUabegi2tbozeE91X0pTtCSE6km54tnPRGSWJtFUmL+r0
tY7nRExPOWGEwJAGKgJu6bub9XLLWXQtKPLdjakCMZ6QcrXIYo5NW2bknfbimHFO
kNdVYgQD9No/7n5oRvUbVJ8hv5QC4Fl2o/2OlWK/d0nFZE4Ya4hn5HjCWsu6fBYf
Hd13i+KLsPkEjlvxuLZmw5BfaDdyl3VWJDGiR0flXEIQ2irEV3a9gOqMtDmA1QrD
PPEMm8csOunYAZQ0bjL2JbPRONmQmjc/Fup6jA5Mi6CT0gW1tyrXhy0hIyG7XNdF
MPz53Z724qQuskIinDH7tnf+oKS0NPA7UsShU8LWQeu+c9r+fYa99vmqkPpzew3z
tiVa/yhIkEB9xz9Qq283zIvGbxpA+cyrN+16Hwx8gPq5xzUdpBg=
=l6d2
-----END PGP SIGNATURE-----

--Apple-Mail=_8F20AE3E-B846-4392-AAED-51816256F513--
