Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C86C433F5
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 14:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbiCGOgM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 09:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243276AbiCGOgL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 09:36:11 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4477EDAA
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 06:35:15 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g3so7990814edu.1
        for <linux-block@vger.kernel.org>; Mon, 07 Mar 2022 06:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=6dSLXUKX3NW0Fa8qXV7oOutXYyq7YGWGX4BjnApZXgU=;
        b=5Y4iz9jJKvd9hFYwKTGI1dKIHn8Nkk39I9LhMBUyLNfsy6lODXwRe/EGIRvZdtJ7Ez
         Y4vybepc9CwcZEQndWub7NxkU/FXkFQFL9knej7G5tu5h8LTyTZavdDcn0qpqv6yiU19
         dUmG+mSYL9OByE94Npe2wvJ130pa66O4FWB2XKA6ibCZYArkusnRFPtDt00rJ6OMaRp0
         VeS0lIQf1gDSLuwU7doas/AgWW7XR6ayVHEqnMVtQP8pOh90gP0eOLe6z87+a0tgkVQX
         Ar7G3yRoSOkEzHIw1dg/mYxrcoV3OUEI19UPth9ANLgwf1L+dYaTiDFA8MbtsNZWNV6m
         SAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=6dSLXUKX3NW0Fa8qXV7oOutXYyq7YGWGX4BjnApZXgU=;
        b=gZdK34gOPS/TFAIeefg/BHcTpVF6xJ/WEXQPdP/7CPXdbTQiDh1V+V2CDQuZQuswnS
         4uDMiMEjtA0GLDeqYewvlxZ55r8nBVg1f11XKl3rIIlZn8PUsS+9bst6lhaDA7EDq8FK
         uYphjGooAXASYk3X4EW4utTxQRvsM+mfPap3GgHjCNy2dXbQ0wmzq6Q4+x1dqE+xq2+c
         OdOLroAP2gYaAoA2FlhkFRk9jqlU04tbgRPs2e7f+TGjyj4jresJaFglcKJWXO2fivYf
         9iycb0AHMZMK1uFqhenByYKzJOXGn5CRsBFecQ9C8CJnEVNRAaeYqk9INJ/+TBigQglr
         9OjQ==
X-Gm-Message-State: AOAM532AmrYnQ57N2cnJi5JrkAsOwO/Wl1s7/7XLbQ5HVVAG5GRA8Oag
        QbqBGaOsNmbaKS5zaS0o16mqnA==
X-Google-Smtp-Source: ABdhPJzegDFMMsHyBsWeAZ3gzkleDH1GbEAFWxPGsnrPB4UKAqzvlUCuE1vPwqI+7Qr2cgFXQpDBHA==
X-Received: by 2002:a05:6402:51d0:b0:416:523e:a779 with SMTP id r16-20020a05640251d000b00416523ea779mr3319763edd.264.1646663714212;
        Mon, 07 Mar 2022 06:35:14 -0800 (PST)
Received: from smtpclient.apple (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id c6-20020a05640227c600b00415e926bbe1sm5889318ede.89.2022.03.07.06.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 06:35:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Date:   Mon, 7 Mar 2022 15:35:12 +0100
Message-Id: <DD05D9B0-195F-49EF-80DA-1AA0E4FA281F@javigon.com>
References: <69932637edee8e6d31bafa5fd39e19a9790dd4ab.camel@HansenPartnership.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <keith.busch@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
In-Reply-To: <69932637edee8e6d31bafa5fd39e19a9790dd4ab.camel@HansenPartnership.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
X-Mailer: iPhone Mail (19D52)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On 7 Mar 2022, at 14.55, James Bottomley <James.Bottomley@hansenpartnershi=
p.com> wrote:
>=20
> =EF=BB=BFOn Sat, 2022-03-05 at 08:33 +0100, Javier Gonz=C3=A1lez wrote:
> [...]
>> However, there is no users of ZoneFS for ZNS devices that I am aware
>> of (maybe for SMR this is a different story).  The main open-source
>> implementations out there for RocksDB that are being used in
>> production (ZenFS and xZTL) rely on either raw zone block access or
>> the generic char device in NVMe (/dev/ngXnY). This is because having
>> the capability to do zone management from applications that already
>> work with objects fits much better.
>>=20
>> My point is that there is space for both ZoneFS and raw zoned block
>> device. And regarding !PO2 zone sizes, my point is that this can be
>> leveraged both by btrfs and this raw zone block device.
>=20
> This is basically history repeating itself, though.  It's precisely the
> reason why Linux acquired the raw character device: Oracle decided they
> didn't want the OS abstractions in the way of fast performing direct
> database access and raw devices was the way it had been done on UNIX,
> so they decided it should be done on Linux as well.  There was some
> legacy to this as well: because Oracle already had a raw handler they
> figured it would be easy to port to Linux.
>=20
> The problem Oracle had with /dev/raw is that they then have to manage
> device discovery and partitioning as well.  It sort of worked on UNIX
> when you didn't have too many disks and the discover order was
> deterministic.  It began to fail as disks became storage networks.  In
> the end, when O_DIRECT was proposed, Oracle eventually saw that using
> it on files allowed for much better managed access and the raw driver
> fell into disuse and was (finally) removed last year.
>=20
> What you're proposing above is to repeat the /dev/raw experiment for
> equivalent input reasons but expecting different outcomes ... Einstein
> has already ruled on that one.

Thanks for the history on the raw device. It=E2=80=99s good to the perspecti=
ve on history repeating itself.=20

I believe that the raw block device is different than the raw character devi=
ce and we see tons of applications that don=E2=80=99t want FS semantics rely=
ing on them. But I get your point.

If we agree to get ZoneFS up to speed and use it as the general API for zone=
 devices, then I think we can refocus there.=20

As I mentioned in the last reply to to Dave, the main concern for me at the m=
oment is supporting arbitrary zone sizes in the kernel. If we can agree on a=
 path towards that, we can definitely commit to focus on ZoneFS and implemen=
t support for it on the different places we maintain in user-space.=20=
