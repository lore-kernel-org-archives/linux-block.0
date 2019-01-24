Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060EEC282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 13:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0CC218A2
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 13:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="YsDbtIYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfAXNpb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:45:31 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44761 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfAXNpb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 08:45:31 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so4590071edd.11
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 05:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=51Kso+9BQIGmO9SNAHGyeQCAmhaCcPXjeucfCxTfrgY=;
        b=YsDbtIYMLB3H9oMC7iyJMvPPX3wGuwtuDghnWtaSFDswgt5vPfxRpZ3w5r0TA4Xtn8
         wfJTBH25LHIFc/QBX43S2RED9853WLTlwpTJGzFXcf70bzUYyOY6kszmZqdtqfRpk79M
         If1jw3XVviL24UKYNM7bAuJoNOHSNpnitTyPWK7dreS/rIuDY/5QuObqb3UjWO5QbTen
         qR+NvyCOJpHuLd3otm1Z4JduCfcVnn5bq1Gbwo47Vjs6rGNtLGzOL31bU6m3qnpiHm+g
         hAtsoMERb/iOehU5+Fv2P0Wes+pSqDxSRiAOMTfwhRljGPnY5z0Jrvjw2UbUxE2YkE7z
         nzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=51Kso+9BQIGmO9SNAHGyeQCAmhaCcPXjeucfCxTfrgY=;
        b=H61aE/AhTbU6UMgWtavJLp25RgEg/LAGF9R/VZDT+s/fDlHH5wLS50Wqej35UZ9/ZW
         ibP2lX8EILALydDJRDkJ26EtR9+bRDYo7+YPk6w7XGMCERR0cTcvfyBuJ7mX3dTfIj9I
         UcUhrGuNGRWyUCx6DOyq1GFO3JAPhGn1Unv+vvN1H66r92OnZkLfd4/j4IcCbDNd9q98
         lCPKxQ3HkL+DQy5+KTFSFYzkt89uDyLgA/KUIr9D02Vb16XKKp+dy/kR1VolU9RLVMjb
         E1Y43n8Q3Fx8o8b1ZgHCMHWk7VtixabFMx6pQVZ5nDmSnn6R8HVq9gfXW+3crXd67r54
         c/HQ==
X-Gm-Message-State: AJcUukfq05Dwfsgwn1XxHa6TX8VnXggSY2i4tpdLH9hK73N2cQ3kZzMp
        hAE++ywCNtGnrKTXnORWti+ENsbYohnWww==
X-Google-Smtp-Source: ALg8bN6ysXM6jVgwIXUkKlOa6MjsBB040IP1/W5MWjbchy4NVtFg5ALRAXOEzPvzjsvRO5qfEsIDcA==
X-Received: by 2002:a17:906:4749:: with SMTP id j9mr1349595ejs.46.1548337529131;
        Thu, 24 Jan 2019 05:45:29 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id d56sm11220552ede.76.2019.01.24.05.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 05:45:28 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <9E0FD459-75F2-4EF1-9310-8FCDF6F87604@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1025A3F0-171A-4FE0-A66B-02084B101F92";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v1] : Switch to use new generic UUID API
Date:   Thu, 24 Jan 2019 14:45:27 +0100
In-Reply-To: <CAHp75Vf4ndBaS6BjAM==7csYB9EYDvjV9jT9C6kioDryzb_HnQ@mail.gmail.com>
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
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_1025A3F0-171A-4FE0-A66B-02084B101F92
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 24 Jan 2019, at 14.36, Andy Shevchenko <andy.shevchenko@gmail.com> =
wrote:
>=20
> On Thu, Jan 24, 2019 at 3:19 PM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>> On 24 Jan 2019, at 13.16, Andy Shevchenko =
<andriy.shevchenko@linux.intel.com> wrote:
>>> On Mon, Jan 21, 2019 at 09:47:32AM +0100, Christoph Hellwig wrote:
>>>> On Thu, Jan 10, 2019 at 04:30:51PM +0200, Andy Shevchenko wrote:
>>>>> There are new types and helpers that are supposed to be used in =
new code.
>>>>>=20
>>>>> As a preparation to get rid of legacy types and API functions do
>>>>> the conversion here.
>>>>=20
>>>> This seems to miss a "lightnvm" in the subject line.
>>>>=20
>>>>> static inline void pblk_setup_uuid(struct pblk *pblk)
>>>>> {
>>>>> +   guid_gen((guid_t *)&pblk->instance_uuid);
>>>>> }
>>>>=20
>>>> I think we can just kill this wrapper.
>>>>=20
>>>> But more importantly the instance_uuid fied, and the header.uuid =
one
>>>> it is copied from should be turned into an actual guid_t, the =
memcpys
>>>> and memcmps should also be replaced with the proper UUID API.
>>>=20
>>> header.uuid is defined using __u8 type, I'm not sure we can use =
guid_t there.
>>=20
>> We can turn it into a guid_t and bump the minor version.
>=20
> It's not so easy. __uXX types are dedicated for external APIs. guid_t
> is kernel internal type disregard of (still) presence some uapi bits.
> So, the question is those __uXX types in the driver definition is a
> simple mistake, (weird) style decision, or what?
>=20

I would define it as a mistake and I think it is worth fixing it. At the
moment we are only using this uuid for recovery purposes, to discard
data from a different pblk instance, so there should not be a big impact
outside of pblk itself. Am I missing something?

Javier

--Apple-Mail=_1025A3F0-171A-4FE0-A66B-02084B101F92
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxJwXcACgkQPEYBfS0l
eOD18Q/9G+8QUFlvDqzLMAVoElXVRBEmAomFhP/iL5q8MoHqnaGMoOs1b8zaaPqm
u0ltfJFuhkPBzBJpFMReuHpR0+N1Av+ee3UI02ZDOgqmnsSpnQjrgVyDJihcuRqR
4XwMmVbE+Wt0Kefmrd7x0RrnOktqMRLUhNsd/IaRoXHvkmOIvcYkr+nO1VDtse7D
wK12U95x8pWboEs+M7o+z8Uua3awMfGpHDi8mqGrhmTFCyoIDLQWPkwI1C5S5hW/
TUhMRMeMh5xja57UtcacOHPeWA+TViwygLrLdn3enPlJ4yDukfEjsIIJdGUSAMUc
kj6s5l1NO54148Puve39cY7qr5yV4yDsXqamn9y4ASpM841jVnPM6a/bDD/4TOFK
7f0jh7FmhbTTMj1imCSSmXEKy1mYNOrDsZhfR6+AnNCpK9k0uPVKMYYCx/zeidNz
on9xbCVZ6nRDcl+sNvvph110hS3BXkpEqBCdi2tvUPezRgf6Bl2BnuJBlyKKylFg
y6nhZUf/Cv5gXrVpamcyTVCkU2NEs5eymu6oNl8U/oeN3MQVMm+z738EH9GwRt5e
nKWhVEDnUZBjZePUlX99tP3Sgv0cDoQgOO6c2SKOH67MF8VnbvDPoxdddPsZqC7S
R+m4tZbuQa5EEGlAW3e3wxnNPCvTP1oisEpQ59zOP84+NfrrNyI=
=UWGy
-----END PGP SIGNATURE-----

--Apple-Mail=_1025A3F0-171A-4FE0-A66B-02084B101F92--
