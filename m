Return-Path: <SRS0=+z0d=5F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2EBC4332B
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 09:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9E120739
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 09:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cq5MnfQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgCTJUn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:20:43 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46952 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCTJUn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Mar 2020 05:20:43 -0400
Received: by mail-vs1-f68.google.com with SMTP id z125so3502050vsb.13
        for <linux-block@vger.kernel.org>; Fri, 20 Mar 2020 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tysNXQSXEegrfkbWuhGVsTTREcDkE4Z0pfyJN3lEVqE=;
        b=Cq5MnfQUF/eClcnJqhe0dc3QbsSBmHYDIrVAoczrT9JBt0XOopRtxqAu7nM6Q9VsaA
         6Jkw5CKSMnID70kn+d/MPNouPA1i8lU+g3fpgR8mr+nmHcVFG+czuLWOpMwgJV2m2W6n
         aCGTJ/1P8oaVU5/mbzdG9BV89zpy11p33E5hGOxrWa44KLhPbZEwN1a80AA9AZin1s5N
         V12KqiapGWqPJzrwrbzl1S7SbySGvzfYVyCqs/lZIZRN8HrF6g6OgKAEZS/KX9/yw84c
         dfaX03v0SG/GkuIzOqH/TzsDfyXbpkCnS+tcYgvAZhoNhxyStEXhfsyx/uzKwEMIYsIq
         pKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tysNXQSXEegrfkbWuhGVsTTREcDkE4Z0pfyJN3lEVqE=;
        b=dly4FLI1U+CsUvb0W+AZka6tYnTXZcDqHsGE+rBjgL1HWYaCzIZrz4XX26HUNP+I8E
         9j5dp/cmtMPddByCsUO3/ZPIMKu19MONMNt0ZB6XZlLTke6eilryhEuRDbyDWBQP8XS4
         FGJL0Dz86VqC1dhkIJ+qxrH+A7itKCGTf1Prw+20Xz/SPOOolZ+2oMjluaMxe0jTBIHM
         TmAuP1pJkv1jfTQWupFJ69HPYkcAlxdvlGBDc2nkMzX+g0Xco7ikSgyO5h9r1PgC1xyN
         /8FPyqkSoeuwHW+feK/Rj4zI9GuGdYPbMpeqxisE8Atdl2ZwzQ0nhKEBfycH8LVjt+Ou
         UHHw==
X-Gm-Message-State: ANhLgQ20jwXCmugZDBoc3XWDrn02ayjpC1bKHZNldcib7GAxE1uREVt0
        iMPzlg+x0WXHpUAuPTC2Pbpv8IU7NPL3UwavEx1GDQ==
X-Google-Smtp-Source: ADFU+vuri1vRZK9FSAJUMr5b0/R4hhZYiB8vilrBtMV4l1LgVmapVFCJ8ZQb/uJFaC3d94Lj8r9aSYpqPp3je7q7lvM=
X-Received: by 2002:a67:646:: with SMTP id 67mr5128706vsg.34.1584696040606;
 Fri, 20 Mar 2020 02:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <757853cf-987e-f6b6-9259-b4560a031692@nvidia.com> <d12fe142-7e72-ab58-33ab-17817e35096f@nvidia.com>
 <c216f131-6f83-c9c9-9d17-8d44ec06972d@nvidia.com> <87ad7586-9569-4276-044a-adb64e84ca15@nvidia.com>
 <a0962e0b-0f1d-9f32-f6e9-92f69f93167f@nvidia.com> <57ddddc2-3ee8-d867-bba0-0dd9929ba37d@nvidia.com>
 <CAPDyKFqZSd9E3+16yFsmpee2JsbRJ-DGThxx7NJHu6UE00Xi1Q@mail.gmail.com>
 <26ee7225-9483-4664-c2d7-b5cefeadcd4b@nvidia.com> <CAPDyKFqwVQDEnPNi33mc9ycTxpaT1cRLejbR3Ja4c8dha4gFRw@mail.gmail.com>
 <0301bbd5-8d4d-4a77-42c7-8a1391c2d60a@nvidia.com> <CAPDyKFp93H0=ttazofW9NMBtL5VnjB4PdkwN0FDCtWR0pMHrPA@mail.gmail.com>
 <f01b5533-124a-d978-a90a-9c9c6235fb65@nvidia.com> <CAPDyKFqJjsuHect-azQKO8cCoq5JJQrZ=eShsdLHq97NXgXnuQ@mail.gmail.com>
 <227d9f08-582e-fd79-e1dc-7695bddd162d@nvidia.com> <2456654f-2724-0b6d-8936-afa05f345344@nvidia.com>
 <df939962-2cb4-1c36-0baf-d82e3527d05a@nvidia.com> <41348c8f-6bc7-a5a3-e1ed-9143f60cbdae@nvidia.com>
 <CAPDyKFqWRGK6LCevwXQoZnRqfMkUDWNUMqbGqnqv+OopmhvBeg@mail.gmail.com> <CA+G9fYv+bhdmq9O5rmnOkigCossK5WX9AMr76AF57f8KKydV9g@mail.gmail.com>
In-Reply-To: <CA+G9fYv+bhdmq9O5rmnOkigCossK5WX9AMr76AF57f8KKydV9g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 20 Mar 2020 10:20:04 +0100
Message-ID: <CAPDyKFr_WjRA9Cr3htSAd+LqcZLorY6AwvS2KZ0_89H1pJfLLg@mail.gmail.com>
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Kishon <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 19 Mar 2020 at 20:12, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> FYI,
>
> The arm device x15 running stable rc 4.19.112-rc1, 5.4.27-rc1 and 5.5.11-rc2
> kernel pops up the following messages on console log,
> Is this a problem ?
>
> [ 0.000000] Linux version 4.19.112-rc1 (oe-user@oe-host) (gcc version
> 7.3.0 (GCC)) #1 SMP Thu Mar 19 12:55:45 UTC 2020
>
> [   15.737765] mmc1: unspecified timeout for CMD6 - use generic
> [   16.754248] mmc1: unspecified timeout for CMD6 - use generic
> [   16.842071] mmc1: unspecified timeout for CMD6 - use generic
> ...
> [   20.580541] mmc1: unspecified timeout for CMD6 - use generic
> [   20.588216] mmc1: unspecified timeout for CMD6 - use generic
> [   20.604011] mmc1: unspecified timeout for CMD6 - use generic
>
> ref:
> https://lkft.validation.linaro.org/scheduler/job/1298207#L4037
> https://lkft.validation.linaro.org/scheduler/job/1298945#L4132
> https://lkft.validation.linaro.org/scheduler/job/1299973#L4232

The commit below is the problem, it shouldn't be applied for stable.

commit 533a6cfe08f96a7b5c65e06d20916d552c11b256
Author: Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed Jan 22 15:27:47 2020 +0100
mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()

Let me sort it out with Greg/Sasha. I will keep you in the loop,
thanks for reporting!

Kind regards
Uffe
