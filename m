Return-Path: <SRS0=tn0U=Z4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A041BC43603
	for <linux-block@archiver.kernel.org>; Fri,  6 Dec 2019 16:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7369A2054F
	for <linux-block@archiver.kernel.org>; Fri,  6 Dec 2019 16:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/swt7CB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfLFQRu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:17:50 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:36022 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfLFQRu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Dec 2019 11:17:50 -0500
Received: by mail-wr1-f45.google.com with SMTP id z3so8419728wru.3
        for <linux-block@vger.kernel.org>; Fri, 06 Dec 2019 08:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xPgiR07qhqZm5A9xM8+Iw1t/agTh+5S/g1k60Y08b7A=;
        b=q/swt7CBHg5vD+QNabPF9s4lCOTP66BQ1LmyaXUAOX4/jQEBD4shBj95j7PPSdV2b2
         KXMdsHxn/wZeKR+bhV901/AZIt03KBZd3ghVoJvO/sE/YGT1EVSYOB7MCddNGOIRNa1z
         JN2mOvTlgAjVAp5dFBgthT6H2yog7RcQXY1N0pxvEeAUE8sG6oPAash4OC2SsqLmncp2
         TUJbox7lbuYL30nJ8u6EQ8nuDhbKs4scs7SrNkfW+Sgt1dG3i26vskQ9lAVUaTt7LvuL
         RSusecS6dxIsTdj6zy7icnbS8A5hx3SoC+tqhhIyerRhf5sYdpTW7/jtAjP3AcAPvasI
         wvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xPgiR07qhqZm5A9xM8+Iw1t/agTh+5S/g1k60Y08b7A=;
        b=NUuLqTgKrq1DOezuu3tjv1O4+BkNFwhQGsAeaEiTIV1G0yl3qXEvVN02zWCpmR/js/
         5jsrz9G9wdkJiAlmFsyZ7tGmnwtI/HHD09gTR6K5It8fml5ZpaFkoy8bF3mxy/cUyWtK
         nLu6gJWQzIDg6OyynyLXR5JntkJexzCM9PzKsv0KDRFyXC/t8l6/KIEIubbZ7lqFc2Qu
         AH+nZmDWu0bT0zXWAkGpylwPiVCeT8sMkRbRC4ZPXZcdUB0LKKuQaAwp/Vm7NemP5qby
         ya9+qRuEwcroz5YRhpOWkkqFq9xvsnrlefi1JQ+gcn+NtuLQmtzq/dByVgf9gs5JcjmH
         KnlQ==
X-Gm-Message-State: APjAAAWyuuK+5Sp21JkZr75V+mbSZT2KiMbPPMT+ppxcrDMH4Hkrxl8k
        gpHoUEhrnA5OpC40jwxcuIXdIg==
X-Google-Smtp-Source: APXvYqzaeZEuz67KTTOQnA2npcQUl0F9ocyZi8VtH6jYME5Sp7wUkwlwgZhApAJ+QpK3B2gA3f3gVQ==
X-Received: by 2002:adf:b64e:: with SMTP id i14mr16150392wre.332.1575649068315;
        Fri, 06 Dec 2019 08:17:48 -0800 (PST)
Received: from [192.168.0.102] (84-33-74-162.dyn.eolo.it. [84.33.74.162])
        by smtp.gmail.com with ESMTPSA id i5sm6463500wrv.34.2019.12.06.08.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 08:17:47 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: Injecting delays into block layer
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <3D695D19-B226-4093-9C27-CE561ED08CB7@linaro.org>
Date:   Fri, 6 Dec 2019 17:17:45 +0100
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        SIMONE RICHETTI <206161@studenti.unimore.it>
Content-Transfer-Encoding: quoted-printable
Message-Id: <942604AE-5A91-4E05-869F-74A7EAC5A247@linaro.org>
References: <d7ee69fc368db16fa96a05643083674a@natalenko.name>
 <3D695D19-B226-4093-9C27-CE561ED08CB7@linaro.org>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 21 nov 2019, alle ore 09:00, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 21 nov 2019, alle ore 08:13, Oleksandr Natalenko =
<oleksandr@natalenko.name> ha scritto:
>>=20
>> Hi Paolo et al.
>>=20
>=20
> Hi
>=20
>> I have a strong suspect that something is going wrong when the =
underlying block device responds with a large delay. What makes me =
thinking so is that I use a VM on some cloud provider, and they have =
substantial block device latency resulting in permanently high (~20%) =
iowait. It spikes occasionally when their cluster is overloaded, and =
when that happens, the I/O in my VM may stop and never recover. This is =
a rare occasion, but it really happens.
>>=20
>> What's worse, so far I've seen such a behaviour with BFQ only. I'm =
still testing other schedulers though.
>>=20
>> Important note: I have no strict evidences that this is *the* case, =
thus I'm asking for some suggestions. My idea is to fire up a local VM =
and inject delays to a block device while performing some I/O from =
within the VM.
>>=20
>> So the question is: how can those delays be injected? Using dm-delay? =
Can those delays be random?
>>=20
>=20
> So far I have used scsi_debug [1] for this kind of tests.  In my S
> suite [2], it boils down to setting SCSI_DEBUG=3Dyes in the S config
> file, and then launching any of the benchmarks.  Unfortunately, AFAIK
> scsi_debug gives you only constant delays; but you can emulate delay
> spikes very easily, by changing the delay parameter manually during
> the test.
>=20
> If this option sounds reasonable to you, then I'm willing to help you
> for every step.
>=20

Hi Oleksandr,
Simone (in CC) and I have worked a little bit on reproducing the I/O
freeze you report.  Simone made a small change in SCSI_debug, which
makes the latter serve I/O with a highly varying random delay (100ms -
1s), about twice a second.

Then, to generate some fluctuating and heavy I/O, he ran the
comm_startup_lat.sh script of my S suite with SCSI_debug a few times.
Unfortunately, he didn't succeed in reproducing the problem.  If you
want, we can send you a patch with his change for SCSI_debug.

Any news on your side?

Thanks,
Simone

> Thanks,
> Paolo
>=20
> [1] http://sg.danny.cz/sg/sdebug26.html
> [2] https://github.com/Algodev-github/S
>=20
>> Thanks in advance.
>>=20
>> --=20
>> Oleksandr Natalenko (post-factum)

