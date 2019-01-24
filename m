Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE27C282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 13:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3176218AD
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 13:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="eS5l5f96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfAXNRl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:17:41 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35261 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfAXNRl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 08:17:41 -0500
Received: by mail-ed1-f68.google.com with SMTP id x30so4560822edx.2
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 05:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=EjjZHQDMtEeAJy+yuLGguxNx5ZCA/WqSLyfTRStIViQ=;
        b=eS5l5f96P0vyKgmfeDl6Qgdw4uUB/0cQRaguP2C8ptcsHS9pufZZuJOfyExxlAojiv
         j5/kxc3Y5wXyYg6gyFw7Fcapz5fulktUfOokQwaWWEXx4dFDCAvcaHxFwAzPRwW2j9rN
         XwjXbu9qQa6rnHfUma9JspzQjJjEk/51AyAfAYjmtVLbzObvAXBvm1kN3PeOvco+wCV+
         3L6Gxn3P2bilpfVVCZ7qdgZs0PXR8tHYmii7mHfshklUqqzx4d+7pFM6RorEJbKoVbQ1
         h4O6f1GKIrk8hrBThFSdPH9Bg3lIz88XSRqNkhV0RjLrt8k1LQOJ7uplwyr5IUE/UkrR
         65mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=EjjZHQDMtEeAJy+yuLGguxNx5ZCA/WqSLyfTRStIViQ=;
        b=Q51kWfEEdChgbwPBDERZcA2MdgDvJHm56rgFYrzLA5TUTuASzWHEC4TUVDenSi+fSV
         pucJjbMw1pGPfG/Ma+ji28BBPOy14sikXjwcUfIyo3vcnTev55iUA31Dd8kwwoUzxaXw
         frxYgUz36179iS4CUeys0b129TyVaiifnSUrjdKzPb+uK/0W1Kz8utzxLTI3OBXkJwRs
         IwXFpgDLS5fXaGTHC1pZOXfMRiYylE3OvMeFSDwulktSqbhUXYEubMDjJOcolEBVzcow
         sAeDpgIHDAhWpkEtHt2PMGEt6T25vnl8O953YeSkGxTcHFnN9fzoAQoPRMU4WONX78CR
         je8g==
X-Gm-Message-State: AJcUukeP6goVk8H3dDUmA3dg91a1rW8xv9ikrH0XnFNDNpMBeeI1zkkn
        3pO5ncYUUYrZaAbKeKyJ97YoZuD20gXx2w==
X-Google-Smtp-Source: ALg8bN6lsDbN9i+EwlNOF79BsoohePLWVicKvCYW9ecAzPPmbdiD0hPgjp75QVWHC+tAGhzTEf8wuA==
X-Received: by 2002:a50:a741:: with SMTP id h59mr6347683edc.106.1548335859233;
        Thu, 24 Jan 2019 05:17:39 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id p30sm10910993eda.68.2019.01.24.05.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 05:17:38 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <6D748F08-F9F9-4DFB-84DF-63E97C691013@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_FA6F1CE6-90CA-4FC3-937F-72E101801614";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v1] : Switch to use new generic UUID API
Date:   Thu, 24 Jan 2019 14:17:37 +0100
In-Reply-To: <20190124121659.GH9224@smile.fi.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190110143051.52305-1-andriy.shevchenko@linux.intel.com>
 <20190121084732.GE18680@lst.de> <20190124121659.GH9224@smile.fi.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_FA6F1CE6-90CA-4FC3-937F-72E101801614
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On 24 Jan 2019, at 13.16, Andy Shevchenko =
<andriy.shevchenko@linux.intel.com> wrote:
>=20
> On Mon, Jan 21, 2019 at 09:47:32AM +0100, Christoph Hellwig wrote:
>> On Thu, Jan 10, 2019 at 04:30:51PM +0200, Andy Shevchenko wrote:
>>> There are new types and helpers that are supposed to be used in new =
code.
>>>=20
>>> As a preparation to get rid of legacy types and API functions do
>>> the conversion here.
>>=20
>> This seems to miss a "lightnvm" in the subject line.
>>=20
>>> static inline void pblk_setup_uuid(struct pblk *pblk)
>>> {
>>> +	guid_gen((guid_t *)&pblk->instance_uuid);
>>> }
>>=20
>> I think we can just kill this wrapper.
>>=20
>> But more importantly the instance_uuid fied, and the header.uuid one
>> it is copied from should be turned into an actual guid_t, the memcpys
>> and memcmps should also be replaced with the proper UUID API.
>=20
> header.uuid is defined using __u8 type, I'm not sure we can use guid_t =
there.
>=20

We can turn it into a guid_t and bump the minor version.

Javier

--Apple-Mail=_FA6F1CE6-90CA-4FC3-937F-72E101801614
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxJuvEACgkQPEYBfS0l
eOBYQA/+OcR3Vp1GeD4/KINbPX1Siory3+pOFdm0jYhGGUCbveseCXgJtotCn0dc
Ot+frRfIlyxjo4QfZE7StnSAyva4TUHQUDt//f5FpxnrwjZjJs5rD3Hp9GkVjESo
yVfPI7FUb3o0MvGnuCbqmNXVHu/rg9Q4uoPjg+H1Ns3Lqa5KHWvNen7GknLgTSsV
pVS6zErf+x8YVCSE0TnJLHsm3uVdYMSuCprcpPZ08WiuAvIJX9d3CJSuwO28hWOR
T+sVQqYlBhXwTHeIxoXQ0qonCxaRzeZpbPYxnJNVdvzT0TP1NoT5DfIRQOgXAT8W
beEjN4bftKMeAq0D3Qz8EmCdtEkFoh10jqY2kbj6SStCLrA1Hyoan6WCq7GAUKVd
mKLI7O9M0WZFokz1PzFpTA/hUBPzi/mRiYHKaMHQGgT82TFCp8llySrpc8TRB4h/
KkvUFMHYKoQySnhQCD04rwALwh0oTYA+XyS88WhLOVbNnvUlbIMsI/mjeNNWKhNK
2slITkJhZnVonfwxY2EtIVvGi/gOgl2GGUtnI3Ep0MDsFCY53ZHN4azAvPbIbHAM
ls+5S2cyAQearRC/pBw7nBTvmKwdiuOZxxaHPZYUMVvhJGtyh9CzkcIkMN885nNV
rNa5XliqdNbMVQ4FERm6crDtuWL66HK0K4ONhRHiAfWoSWcrnmI=
=VxXC
-----END PGP SIGNATURE-----

--Apple-Mail=_FA6F1CE6-90CA-4FC3-937F-72E101801614--
