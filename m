Return-Path: <SRS0=6FHI=5E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485A1C4332D
	for <linux-block@archiver.kernel.org>; Thu, 19 Mar 2020 19:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE222072D
	for <linux-block@archiver.kernel.org>; Thu, 19 Mar 2020 19:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6zKJVqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCSTM6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:12:58 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:44509 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgCSTM6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Mar 2020 15:12:58 -0400
Received: by mail-lj1-f169.google.com with SMTP id w4so3779368lji.11
        for <linux-block@vger.kernel.org>; Thu, 19 Mar 2020 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QVkzVRwG8di2tV6d9YdwSc9NIMTzCM+uJhyKylo1Pzk=;
        b=E6zKJVqsleblpxQaJ1FWAniwuWP5ugaz/XSRDSzVEdINjBKBZjI48DRwXAI0x0p8Zd
         hpsF1BtFBG0z3GYhzFEBRTCRSN7i5vW8Y8YQWKEMSDh2Vylf9Hxw0qpD8NAozGRmQ4ja
         xoYO3rqRtyRWZGHfjwHPeqK9LLmCyCN6vMea8BAN8nXDw22vyXLzC2wx7/4DKyZQMwPW
         e3ZlBHjyFdX1TU01dMWDe4h354svsio3n203GM5AN2sVlSI8VgHVsl5qDyEY+xS7D1X8
         pVlkt91FpDoXKqSsmj1GK0sgNY+wW3W1UY9q38ghDisL2LigK+qlapoCy3PgDQNU1FeL
         Pn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QVkzVRwG8di2tV6d9YdwSc9NIMTzCM+uJhyKylo1Pzk=;
        b=HrGrF8eEvyi1exOTu5NuXPNYt1s+qhL4qkebfpSlpPRXW7r104by0Mcm6BxA1XQusc
         cYW+7FtUXNA4einrm78EBMazLjLRG9c6oBukD2/sG+TWed2RXauLYkSwO412e93SpJYj
         7WXdp+TWW6Mfn7zmbBre/tOREqfJmH/eHCjNsSb5LmwUIvWFu7ZbVhfiJlx2nX9WogsN
         C2rSup+TWaM6JmCvdEsb2iUionaYWVh2+BOQvMWGlqaMGd4cQODrpl6o1xzd3GM4URJn
         XV7aaEKwRZ+gpxPdwUWIbyB3uiz81F8/NxhK9Hw5hZrnCK60Hy6CVm+KJgJy8WMAHTjW
         F/Vw==
X-Gm-Message-State: ANhLgQ09r/PW/PJ0Szk1UEU27zJAxrFG4wkZp0qWLotRLI4WVg6QBu1x
        1+IwSCtouq/8Io5AbFGszxT1n3SHuGQRjc+nmy3v+Q==
X-Google-Smtp-Source: ADFU+vsKLCuj84BZqh1D35j+IPEy0J1WwDoWmAn2x/8mm/THSHMQB4laIrHvWqUIzr6HPJRVjNoMN4BhVjiGfEqvO34=
X-Received: by 2002:a05:651c:285:: with SMTP id b5mr2911047ljo.165.1584645174876;
 Thu, 19 Mar 2020 12:12:54 -0700 (PDT)
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
 <CAPDyKFqWRGK6LCevwXQoZnRqfMkUDWNUMqbGqnqv+OopmhvBeg@mail.gmail.com>
In-Reply-To: <CAPDyKFqWRGK6LCevwXQoZnRqfMkUDWNUMqbGqnqv+OopmhvBeg@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 20 Mar 2020 00:42:43 +0530
Message-ID: <CA+G9fYv+bhdmq9O5rmnOkigCossK5WX9AMr76AF57f8KKydV9g@mail.gmail.com>
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
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

FYI,

The arm device x15 running stable rc 4.19.112-rc1, 5.4.27-rc1 and 5.5.11-rc2
kernel pops up the following messages on console log,
Is this a problem ?

[ 0.000000] Linux version 4.19.112-rc1 (oe-user@oe-host) (gcc version
7.3.0 (GCC)) #1 SMP Thu Mar 19 12:55:45 UTC 2020

[   15.737765] mmc1: unspecified timeout for CMD6 - use generic
[   16.754248] mmc1: unspecified timeout for CMD6 - use generic
[   16.842071] mmc1: unspecified timeout for CMD6 - use generic
...
[   20.580541] mmc1: unspecified timeout for CMD6 - use generic
[   20.588216] mmc1: unspecified timeout for CMD6 - use generic
[   20.604011] mmc1: unspecified timeout for CMD6 - use generic

ref:
https://lkft.validation.linaro.org/scheduler/job/1298207#L4037
https://lkft.validation.linaro.org/scheduler/job/1298945#L4132
https://lkft.validation.linaro.org/scheduler/job/1299973#L4232

- Naresh
