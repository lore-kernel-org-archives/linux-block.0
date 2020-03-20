Return-Path: <SRS0=+z0d=5F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CD6C4332B
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 09:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D739D20781
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 09:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584697802;
	bh=Z/kVjRw39UyG/6Q4s/JhfLJ7uXIoe8UKLT9/YqwjAtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WAFYTFr+6n+43LyNMOWwejlFmaaz9lVvQI6ssaI5yjzJwXMjEIoDs8WeGFiiS2xIh
	 FaynaOxjeqKdNXXxnxrUvV+fgm2OXNHEQPB5J8874wkCsEvQxx6AOtQC2Yp9qNNd+n
	 uwl9koUSGElEfssGANtdvBNPY+BDuxQD7Tt97bZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCTJt6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:49:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbgCTJt5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Mar 2020 05:49:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D87220753;
        Fri, 20 Mar 2020 09:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584697797;
        bh=Z/kVjRw39UyG/6Q4s/JhfLJ7uXIoe8UKLT9/YqwjAtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=chlaewNlYQdOzUTOC3qYgdOswN6BxXsLqo53aeb7c7rsULZQ/vXqPo3YUlEVmCviY
         lJr/zl+X3ZU7deOr9TQ/UAuu7N0qk6wUHy4utKw561Ttt/G4NELDyJqjuVlce0lPZ6
         RZ14vEKPtHmQbt7CbBextmieVskspDWd4uvgGVrE=
Date:   Fri, 20 Mar 2020 10:49:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
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
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
Message-ID: <20200320094954.GB421650@kroah.com>
References: <CAPDyKFp93H0=ttazofW9NMBtL5VnjB4PdkwN0FDCtWR0pMHrPA@mail.gmail.com>
 <f01b5533-124a-d978-a90a-9c9c6235fb65@nvidia.com>
 <CAPDyKFqJjsuHect-azQKO8cCoq5JJQrZ=eShsdLHq97NXgXnuQ@mail.gmail.com>
 <227d9f08-582e-fd79-e1dc-7695bddd162d@nvidia.com>
 <2456654f-2724-0b6d-8936-afa05f345344@nvidia.com>
 <df939962-2cb4-1c36-0baf-d82e3527d05a@nvidia.com>
 <41348c8f-6bc7-a5a3-e1ed-9143f60cbdae@nvidia.com>
 <CAPDyKFqWRGK6LCevwXQoZnRqfMkUDWNUMqbGqnqv+OopmhvBeg@mail.gmail.com>
 <CA+G9fYv+bhdmq9O5rmnOkigCossK5WX9AMr76AF57f8KKydV9g@mail.gmail.com>
 <CAPDyKFr_WjRA9Cr3htSAd+LqcZLorY6AwvS2KZ0_89H1pJfLLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr_WjRA9Cr3htSAd+LqcZLorY6AwvS2KZ0_89H1pJfLLg@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 20, 2020 at 10:20:04AM +0100, Ulf Hansson wrote:
> On Thu, 19 Mar 2020 at 20:12, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > FYI,
> >
> > The arm device x15 running stable rc 4.19.112-rc1, 5.4.27-rc1 and 5.5.11-rc2
> > kernel pops up the following messages on console log,
> > Is this a problem ?
> >
> > [ 0.000000] Linux version 4.19.112-rc1 (oe-user@oe-host) (gcc version
> > 7.3.0 (GCC)) #1 SMP Thu Mar 19 12:55:45 UTC 2020
> >
> > [   15.737765] mmc1: unspecified timeout for CMD6 - use generic
> > [   16.754248] mmc1: unspecified timeout for CMD6 - use generic
> > [   16.842071] mmc1: unspecified timeout for CMD6 - use generic
> > ...
> > [   20.580541] mmc1: unspecified timeout for CMD6 - use generic
> > [   20.588216] mmc1: unspecified timeout for CMD6 - use generic
> > [   20.604011] mmc1: unspecified timeout for CMD6 - use generic
> >
> > ref:
> > https://lkft.validation.linaro.org/scheduler/job/1298207#L4037
> > https://lkft.validation.linaro.org/scheduler/job/1298945#L4132
> > https://lkft.validation.linaro.org/scheduler/job/1299973#L4232
> 
> The commit below is the problem, it shouldn't be applied for stable.
> 
> commit 533a6cfe08f96a7b5c65e06d20916d552c11b256
> Author: Ulf Hansson <ulf.hansson@linaro.org>
> Date:   Wed Jan 22 15:27:47 2020 +0100
> mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()
> 
> Let me sort it out with Greg/Sasha. I will keep you in the loop,
> thanks for reporting!

Now dropped from the 4.19, 5.4, and 5.5 stable queues, sorry for the
noise.

greg k-h
