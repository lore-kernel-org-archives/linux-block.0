Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38783C5479D
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 19:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbjAITNO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 14:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjAITM5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 14:12:57 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D906B6AD99
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 11:11:59 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id d127so7989549oif.12
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 11:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CLv/P4JEp5Ex9rXibMOi19GoQyezrkIjWD2yymGGSY=;
        b=OoGCPFxFgLV7aQGpsUf6D9b1RoicEIwWIXMQAapFlcjL2K2uuwKku8DTjmFRw9MSLH
         HeoBi0Thj3idj3GAXd7tt6WV7dCeUZ1H3XutKHWEBM79tbeHssor5C9cCPeWKkg84H1k
         4fCo+ouuiKc75DwhFVdbQJVgqGXKzaxDjdUz8q6Bvno/PWGzUrAtlnD+3qE70T/VqBA2
         yZ0UV4XAPVrXzNl/taVpXO3Kcqr23nb2W9C15wMw7gf0g+N9vxjefGX8nl/a7MZyRmLi
         sW/GcJ7qBn4FDY5eAOGd2k3QORzLykXN5z0LmFq2NTH1q3ddD/Lu6y7ir5m+FuxQcOkE
         nRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CLv/P4JEp5Ex9rXibMOi19GoQyezrkIjWD2yymGGSY=;
        b=Bk7jODc0gVf6tiOB9i+/uBBkZDlwU3Jem38jjqXgAQoEC8CUEjohv6ryViZaMoVO2V
         aLcCZPBNVCPHco0Xvimx2lhc3IDXXjxK0oC9E5x/YhJTn21Wfgu2jVXsnOmQApRirVUc
         JQXdX/2Jw+5tUbFg0Ii7OjS6VjEDYrYTHpkBI64je/A1pf7lofy0yYPuiKMFN5/EvxmI
         SbDigcQZ7xsf0OeNLxLzOB7zvRtzAWPwFZ79SWbpDZeNfmsYYNHSyQCo95g1EevReETK
         PArVj3UtydKegzryQu51G8NAz7M9cGz4PIHudYUVp68SphvNCcRuTmmZRWWA5SEaksSj
         sqbg==
X-Gm-Message-State: AFqh2kpQgw/iRWoF0Su1COtYfRNC8clDMz0VByS5S+4qq8rMEHBNS6VJ
        V4kBC2VIWbV6LUQZlTxlJ2zO8QOntnA7fz08
X-Google-Smtp-Source: AMrXdXs8cnNq0YovQmXXwRPdxXElha0EMlat+xn4izmbck79CAnVPkLi8QNiIBXLawzROmB1Z3vq7g==
X-Received: by 2002:aca:6285:0:b0:363:a5fd:9cd5 with SMTP id w127-20020aca6285000000b00363a5fd9cd5mr14032797oib.3.1673291519152;
        Mon, 09 Jan 2023 11:11:59 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id i9-20020a9d6109000000b0066c3bbe927esm4977350otj.21.2023.01.09.11.11.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jan 2023 11:11:58 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [External] [LSF/MM/BPF BoF] Session for Zoned Storage 2023
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <20230109153315.waqfokse4srv6xlz@mpHalley-2.localdomain>
Date:   Mon, 9 Jan 2023 11:11:46 -0800
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        lsf-pc@lists.linux-foundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AF3750AD-1B66-4F8A-936F-A14EC17DAC16@bytedance.com>
References: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
 <Y7h0F0w06cNM89hO@bombadil.infradead.org>
 <4CC4F55E-17B3-47E2-A8C5-9098CCEB65D6@dubeyko.com>
 <CGME20230107015641eucas1p13c2b37b5ca7a5b64eb520b79316d5186@eucas1p1.samsung.com>
 <5DF10459-88F3-48DA-AEB2-5B436549A194@bytedance.com>
 <20230109153315.waqfokse4srv6xlz@mpHalley-2.localdomain>
To:     =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> On Jan 9, 2023, at 7:33 AM, Javier Gonz=C3=A1lez =
<javier.gonz@samsung.com> wrote:
>=20

<skipped>

>>>=20
>>> (1) I am going to share SSDFS patchset soon. And topic is:
>>> SSDFS + ZNS SSD: deterministic architecture decreasing TCO cost of =
data infrastructure.
>=20
>=20
> Would be good to see the patches before LSF/MM/BPF.
>=20

I am making code cleanup now. I am expecting to share patches in two =
weeks.

> I saw your talk at Plumbers. Do you think you have more data to share
> too? Maybe even a comparisson with btrfs in terms of WAF and Space =
Amp?
>=20

I am working to share more data. So, I should have more details.
I have data for btrfs already. Do you mean that you would like to see =
comparison
btrfs + compression vs. ssdfs? By the way, I am using my own methodology
to estimate WAF and space amplification. What methodology do you have in =
mind?
Maybe, I could improve mine. :)

<skipped>

>>>=20
>>=20
>> I think we can consider such discussions:
>> (1) I assume that we still need to discuss PO2 zone sizes?
>=20
> For this discussion to move forward, we need users rather than vendors
> talking about the need. If someone is willing to drive this =
discussion,
> then it makes sense. I do not believe we will make progress otherwise.
>=20

As part of ByteDance, I am on user side now. :) So, let me have some =
internal
discussion and to summarize vision(s) on our side. I believe that, =
maybe, it makes
sense to summarize a list of pros and cons and to have something like =
analysis or
brainstorming here.

<skipped>

>=20
>> (4) New ZNS standard features that we need to support on block layer =
+ FS levels?
>=20
> Do you have any concrete examples in mind?
>=20

My point here that we could summarize:
(1) what features already implemented and supported,
(2) what features are under implementation and what is progress,
(3) what features need to be implemented yet.

Have we implemented everything already? :)

>> (5) ZNS drive emulation + additional testing features?
>=20
> Is this QEMU alone or do you have other ideas in mind?
>=20

My point is the same here. Let=E2=80=99s summarize how reasonably good =
is emulation now.
Do we need to support the emulation of any additional features?
And we can talk not only about QEMU.

Thanks,
Slava.
=20
