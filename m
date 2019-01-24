Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21910C282C6
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 16:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6292184C
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 16:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="XS5RmcSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfAXQlV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:41:21 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36425 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbfAXQlV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 11:41:21 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so5116499edb.3
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 08:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=hc4m+TNcqWzXIk2nJkRLXdWHwLnRYDibXEQCtvqysvo=;
        b=XS5RmcSutWvyhFCov9EkqhSUM7fSBkla4XiwFmOtUgP5F3ArQ/ouolQ5uxtPADONXk
         w24poKo8JND4WGVAxdQaHbpA5Q6k8DN04uRa3yW2Jm4AhVJl04LXR1AsX9WBQSLCWUBM
         Fv4ZR0DXf2k34XrzFCjp56A/2Nzas2s5eUCWh8KNmaDu2LR76gEcEqRgiJNOmn6Ed2TV
         9nqXqcHG38XgV8KSXbSHu7/s4pdG/+QQCVgAcnXCic/F90lLtxpNaUYd4pcdYXdfpvOX
         yUSaufmQfx0QH/VTwA9/vdio7b9oaCPETtNDqaF9iOBkJxZiY2b1wdMFRFl3P+Oy9g+F
         faRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=hc4m+TNcqWzXIk2nJkRLXdWHwLnRYDibXEQCtvqysvo=;
        b=GU+xg7H2vLzh/zXc9N4m2D21ZHdj302mIhdDRI6TvJwiuUfJfokwR24XkMlUxofvFx
         UPbIgOvg00G7n04NMVeLv5tE0odI/wJrOGP48ML53Bh8hZQ067dctb53DC1IpiBBQ9CW
         aErEeNlb7pED1V2TkgW9LWEgkw+mYNsrl8TrD+N9LDdcZQEYardsbwRewbU0QXK0SOCk
         WQCBI9RHqwxhFSYbiXhuu+YeH+jVqdhst1G8+AdQzp43u4gUcV5gNG3VxDlMmnPylbvD
         LsCy71EYngPZi8Ux2gdKyFcHJvvQlgLt0CP+IEx0mS3pfxOm1vVBcHqnmueKXkXuZBZH
         4yNA==
X-Gm-Message-State: AJcUukcG5OVp8dU49+NAm7mi9WjeKm0QVGghxDqt40UrOhuJ9Cyr8zhZ
        IRhWoRNJx+gLjqABo+6OQAx/Gw==
X-Google-Smtp-Source: ALg8bN5E6S4XpUMT611bXoUG4ovobJn4VZaABRqRcwF2ueoopHrBjTvuxOggiHX6SPcN6CaoGZFP6A==
X-Received: by 2002:a50:cd5c:: with SMTP id d28mr7003744edj.176.1548348079760;
        Thu, 24 Jan 2019 08:41:19 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id v14sm10571105edq.74.2019.01.24.08.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 08:41:19 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <C8AA0F1E-6299-49CA-B470-6E95CD1FA081@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_CB5E0AD3-CC1C-4386-9277-4D0657284990";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v1] : Switch to use new generic UUID API
Date:   Thu, 24 Jan 2019 17:41:18 +0100
In-Reply-To: <CAHp75Ve1BUr1hHWhhHfr0nLCzj0ERbocrn27K_r=mpePYppjtw@mail.gmail.com>
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
 <5FF168CC-9372-4DE5-BF62-DD3A2EE08384@javigon.com>
 <CAHp75Ve1BUr1hHWhhHfr0nLCzj0ERbocrn27K_r=mpePYppjtw@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_CB5E0AD3-CC1C-4386-9277-4D0657284990
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 24 Jan 2019, at 17.38, Andy Shevchenko <andy.shevchenko@gmail.com> =
wrote:
>=20
> On Thu, Jan 24, 2019 at 4:36 PM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>=20
>> It is not pushed anywhere yet, but I have been working on a tool to =
make
>> a pblk recovery tool to enable FTL repairs if something fails in the
>> kernel recovery path. Here, I use this uuid to identify the
>> instance - is there a way to reconcile guid_t with user space, which
>> currently uses the __u8?
>=20
> For Linux there is util-linux which contains libuuid. There is uuid_t =
type.
> Unfortunately there is no so called LE (little endian) variant.
> Perhaps someone would need to extend the support for that.

Ok. I can look into that when releasing pblk-tools. But for now, I am OK
with applying with the changes Christoph suggested and aligning with
guid_t if you also think helps maintaining common helpers.

Javier

--Apple-Mail=_CB5E0AD3-CC1C-4386-9277-4D0657284990
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxJ6q4ACgkQPEYBfS0l
eOCnHxAAmFxnn+kQuwX12OUqikvK1eSgARh74d8Sy2cZZQElrU3s+6m4V7YzLN81
gXYl3KYVbG31qFubOGtCcb2YHYfBiqya2M3Qz/qgIq449iR2LNwo3g40Ucgh+Aub
Ij0fjj1j6n4qIQOehlxeIRkpAx+FgZ/rUTkwMrsabibYHWOPRR6qWLlT2UXUn16E
EOvfP9iSv/doRWkSV6xLkWBhMBFr3IvwMjkzDQOnGl1KAuUIJfi5+oYBhPNMnhH/
fsqH8IZv8EN88lzXaxTWJSFoBJTmqrPkhgjHmVqpOrAoAvdigJ2W8+8tA8++sexS
sl8nebLyHMmhjCGTsyHz17Bc1YiiABus4NWpaq2QdnxUKvq3/ueWfmSKMpMDU57u
BSZdKkjOKoeiBagrE27HB8FmnGZYufJvofCoqq1t7bsBSxz0YXM7ZkctpOoXhNL6
D8gNXGvYciImx8Osx92rCmneaQI2XXaqJ5ybQbamni0Ee0nIh+J+h29XJTlH4sFy
J3F9u0DE2FWy3JzCB3oKDAliCWZwksaFVLDtfbpTSAVsmH+YKmj883Hjocy04/A2
LRoE9ICPHkaB9WTXxpSSDi2gOtYcdla6MBPjjX7upgB87PVZC32QC+HLKFM6WzCm
Vw/rCtjaAl5rsMj6cfSGh3Pn+XfuplquwWBIPRzhUz1xSD5aJCQ=
=UxAG
-----END PGP SIGNATURE-----

--Apple-Mail=_CB5E0AD3-CC1C-4386-9277-4D0657284990--
