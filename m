Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0A0C433EF
	for <linux-block@archiver.kernel.org>; Sun, 15 May 2022 15:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbiEOPwM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 May 2022 11:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiEOPwL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 May 2022 11:52:11 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35A8E012
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 08:52:10 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h85so13663208iof.12
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBji4KQFZohPMCtfC2LgkEoHa9fMpfG3LA35DHej7Dk=;
        b=CsI5DPmU6QpRStLT4qAAO0PcDnfXDVuiL/q8jWRnmpGs9mTILFGtYkzQguO/djyiK8
         UqxFBFAMbH4BJw9FmsoWpiuAdUSY2eYydm6o20Y/lMnUBB+vIDpeMr3j2gs7u+sFPUhy
         RscSoTcJB4M3o4oYSiHQE44k7qiqKLO/Zmgr6WcSxVSiEKC8vs7HkslsMwLJx75j422u
         ubFvhaI1iqChHSJE0zOnrxp2NIs+uZe1hKBmXynZF4jWU8fxSFenFj7MFXCFmj6/mtn6
         l4Gq8dWyEgy0xU6eQa0rleGiPucpI7WfXsG21Wzw1d0fS5iB14hJg34NE9TDBjRCm18I
         3ODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBji4KQFZohPMCtfC2LgkEoHa9fMpfG3LA35DHej7Dk=;
        b=its2cHrOgpusc1Ljgdlb5pOKYVi7ui/sset4YLlg3lbc9N1EikbJL3yAw9nveAPNin
         5JhXKdWIzgh8mmiE9s6jtxiPhFkUgZ0g0OYXEqbDcQFVPxm0km7oh5/u3kqSbRbbEY60
         Qvhe9xt+DEXMy2tvQcPUYiBuqW9TN6uyfQ5vzTnjLRfkjcrCIqbXstAr42GFeyK1XY4x
         w5YtXUI79oUEACybXY/3rHMnv64KtB2e1Fb+MwxITGa+7m0sh1i7+grmWSM+QqEHJEoy
         bL9+izUQS5T5oIfsovI3mfsuRLn3LFiNn0LLDlTV0OCffDw3HzHJZ1pdCyUYMl0BBTbd
         5APA==
X-Gm-Message-State: AOAM531/dE/DMAcEq9kWJSNdZ8z8UpeH0BHTfYLgiZODP8eAFcUxNYED
        Zp2ndVordIoXaA/gAyvzoCU4buPWtYwAFIRxcZAy80q4EKE=
X-Google-Smtp-Source: ABdhPJxZ+ulQ5b/lWSlKfeyJdGpS7c+Rg6OpRVeRSrE+SM/VtbmT7NOZtfpy3tE/GlVzD25CIkuH3e5oJjGgK130cBo=
X-Received: by 2002:a05:6638:f09:b0:32e:aa2:b318 with SMTP id
 h9-20020a0566380f0900b0032e0aa2b318mr5413190jas.313.1652629929974; Sun, 15
 May 2022 08:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <04a0a06b-e6dc-48b7-bc29-105dab888a56@www.fastmail.com>
In-Reply-To: <04a0a06b-e6dc-48b7-bc29-105dab888a56@www.fastmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 15 May 2022 11:51:59 -0400
Message-ID: <CAEzrpqe0qfhPsCOsUjR4kzFA5oyN52nAjvX8c-0-BDb6tudt3A@mail.gmail.com>
Subject: Re: Communication issues between NBD driver and NBDKit server
To:     Nikolaus Rath <nikolaus@rath.org>
Cc:     libguestfs@redhat.com, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 15, 2022 at 11:45 AM Nikolaus Rath <nikolaus@rath.org> wrote:
>
> Hi,
>
> I am observing some strange errors when using the Kernel's NBD driver with NBDkit.
>
> On the kernel side, I see:
>
> May 15 16:16:11 vostro.rath.org kernel: nbd0: detected capacity change from 0 to 104857600
> May 15 16:16:11 vostro.rath.org kernel: nbd1: detected capacity change from 0 to 104857600
> May 15 16:18:23 vostro.rath.org kernel: block nbd0: Possible stuck request 00000000ae5feee7: control (write@4836316160,32768B). Runtime 30 seconds
> May 15 16:18:25 vostro.rath.org kernel: block nbd0: Possible stuck request 000000007094eddc: control (write@5372947456,10240B). Runtime 30 seconds

The server isn't responding to the request fast enough, and you don't
have a timeout set so it'll just hang until you disconnect.

> May 15 16:18:27 vostro.rath.org kernel: block nbd0: Suspicious reply 89 (status 0 flags 0)

The server double replied to a request.  Thanks,

Josef
