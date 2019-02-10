Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F25C282C2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 09:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C6321841
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 09:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG0RU987"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbfBJJRz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 04:17:55 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41691 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfBJJRy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 04:17:54 -0500
Received: by mail-ot1-f65.google.com with SMTP id u16so12848767otk.8;
        Sun, 10 Feb 2019 01:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EFr+hrz2O53PiwqmX3QTtSp5XOzA10YBuRNlgpk5lRI=;
        b=SG0RU9870xNNfMYjUSgdedMKAVqHQ/Gb5wx70W29faMoiyEyK/10ZJ0tWhkflRbqn5
         uh63T5WBN3cGijq6MdV/LKswSWMSSdhtgQBAnkxFEfTB+7gBKFhZ6BNokS0mkGEFx55N
         uU2/IvLfLzYAaKiSJunCpANsfTc6okCLOCwykwbs7CmAXbgTaEMxf2P9MUNwtQCDpaB0
         K8+JCCuC51xB7zEqBT03Ounxe/9psbdT2mG8sSH0fazJMNBLdzxsiA6x4Ip0nJ9rcRFP
         pvmeROZ3fo8ZmTtwqHSWIHI4cdziZroVWqnxPyLzGBahBw0n7j4zq1tod2YXQRSt7EFf
         33cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EFr+hrz2O53PiwqmX3QTtSp5XOzA10YBuRNlgpk5lRI=;
        b=JvJDwU4Y1XrGS0VtMW2Dks/QBegtOiGQi2QQyJsxdOVMiAOIUp7+DCB687+ORUQkLN
         Y5Cu9+qu8mt+ChPD1V1+iKEtb2q7sv9/YqO31VddJ9zNBTZ9h7RQJ6dRNPJzsV4e6RfI
         /1jmNBeIBhShD6wfbvb+VICvqVijP1Ub93j6JS5iLW9U8qZOC3hAAWWuHgCy5ng1LX3w
         z8mFu9Yryl7PhpJ32b6a3SXZQO52LDWJs0qOju2ttT89g2zYfwtRtslKNxU6Xr7gaGRU
         LzGjNbE2ZZrhVX3d5PiPwlRiCnZ4glx0YT3uFuEYccVsRTUZDgiYeDxs59JBRZw6ZjjS
         RnYA==
X-Gm-Message-State: AHQUAubFr7jD/QyeiCPQOoKAsyiLUyvTkaokbBDFwv2sO2HLfdMk7Z06
        8n20QSn1TZUnnUwshY34NSGIHarTfiwpNOZMPIfy8w==
X-Google-Smtp-Source: AHgI3Ia61A8ocEQHNaBrWbLS0V0k/nsaEzIySZDplbldwgnmc936zox5jw3CojIg10PjHY4Ab9/YRuHWBqZR2HL8tvU=
X-Received: by 2002:a9d:61c8:: with SMTP id h8mr20982929otk.279.1549790273575;
 Sun, 10 Feb 2019 01:17:53 -0800 (PST)
MIME-Version: 1.0
References: <CAM43=SO6bdDAEULEPArfgdbjLAYDo9OiPBa8gL4fsSg7Dky=gA@mail.gmail.com>
 <1549736341.2971.7.camel@HansenPartnership.com>
In-Reply-To: <1549736341.2971.7.camel@HansenPartnership.com>
From:   Mikael Pettersson <mikpelinux@gmail.com>
Date:   Sun, 10 Feb 2019 10:17:42 +0100
Message-ID: <CAM43=SPUMzOLRmkoT+DQSpzu2DYRTyOhU6o8KRUU_Q902o2e1Q@mail.gmail.com>
Subject: Re: [5.0-rc5 regression] "scsi: kill off the legacy IO path" causes 5
 minute delay during boot on Sun Blade 2500
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Linux SPARC Kernel Mailing List <sparclinux@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 9, 2019 at 7:19 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Sat, 2019-02-09 at 18:04 +0100, Mikael Pettersson wrote:
> > 4.20 and earlier kernels boot fine on my Sun Blade 2500 (UltraSPARC
> > IIIi), but the 5.0-rc kernels consistently experience a 5 minute
> > delay
> > late during boot, after enabling networking but before allowing user
> > logins.  E.g. 5.0-rc5 dmesg has:
> >
> > [Fri Feb  8 17:13:17 2019] random: dbus-daemon: uninitialized urandom
> > read (12 bytes read)
> > [Fri Feb  8 17:18:14 2019] random: crng init done
>
> I've had the same problem on several of my test systems.  Are you sure
> it's not this bug report:
>
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=912087
>
> ?
>
> The solution for me was to install the haveged package which does
> active entropy gathering during boot and can make /dev/urandom
> available much earlier.

Thanks for the hint, I'll look into using haveged on this machine.

>
> > During this interval the machine answers pings but won't allow user
> > logins either on the console or over the network.
> >
> > A git bisect identified commit
> > f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Thu Nov 1 16:36:27 2018 -0600
> >
> >     scsi: kill off the legacy IO path
> >
> > as the point where this 5m delay was introduced.
>
> I think the reason for this is that the block mq path doesn't feed the
> kernel entropy pool correctly, hence the need to install an entropy
> gatherer for systems that don't have other good random number sources.

That does sound plausible, I admit I didn't even consider the possibility that
the old block I/O path also was an entropy source.

/Mikael
