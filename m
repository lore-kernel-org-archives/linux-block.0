Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6DCC2BBCA
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 06:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002AB2335A
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 06:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgLPG3O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Dec 2020 01:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgLPG3O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Dec 2020 01:29:14 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1C2C0613D6
        for <linux-block@vger.kernel.org>; Tue, 15 Dec 2020 22:28:33 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id q22so13345245eja.2
        for <linux-block@vger.kernel.org>; Tue, 15 Dec 2020 22:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OUbQn9gI6Y9byE+OVB6xI/iZcBXpPFEFI+/OxjCYHSU=;
        b=dCHyrJ9ldolqIV3vm3kKdZtj/L6zf+1aycMFo5vCfPgOrqAqvrXdvL2RDOsPm8qIcs
         lpHgpSPNkXGCJ1iddrUjOOY8CMjtycqnFZkkyz6cUzCth37Obo/W8/pzEuFGz+thQAkb
         BG2Ts112Z8PYQUIjjnrboZuu9bgrFp164h+pp+RHvAWh88rzdpQo+EbLeSQdVJChAOVA
         N9lqvsvFpS0nE8UO25kBaauNDcZMgv9GvgBy54+nxdYvheMmqKQJ1ChEiu+WRP65mh9U
         02iZQOjUI4w3jER2zBDGDteukb7IdriWYc4oI2Ut066hlALJ05hq5j1XG7Sv6viR2l/+
         aHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUbQn9gI6Y9byE+OVB6xI/iZcBXpPFEFI+/OxjCYHSU=;
        b=KZzdMLZHUdPbanTz2YJDVzQxKNSdn4r24ZRbL488KzSVSdJluC1hjRfp3FUHVGAcTJ
         wTZrVd4l8WhFOAsegYFqY4nFFPWFpnwbgvJSrv+Myltyqdcz/WF7oLGNxIbwiInts1TE
         aPuYQVSgwhBUTCr7OcQRwMJOwIhxeahLGQppfy9JeAcxslAZenO8ZhMvxaa5TDAETDPJ
         csKUIzsbVMsC1iRLes2m5K2bNCVpiYWyRMdA1BkZ2OZ7oyJWfoi9e57bYZw403f7sNXR
         Rod6jzqVfxEgWv2KSnf9Kr5zhpjgQeThV/is3lO/Azq7ok62y7M7qitjRJ93kTaaXTJV
         VbVA==
X-Gm-Message-State: AOAM530pdAWie1wuP1NwkFyke+cYXMDUNZynXdKHMLBQ+8KmtJbVCREf
        dFRF9uI4Yg8WuhJIZ3vUYXn6Qg76EoWksjwwBivH0id29Qc=
X-Google-Smtp-Source: ABdhPJyKM7ndsuhZUkF18D7UC4RlAZySXJwF30MnRXLrk/OKhA7Ew3XAe9PdEkSCuYaKDef4JPgyzhaEbnUZHwbr4HE=
X-Received: by 2002:a17:906:9452:: with SMTP id z18mr20915828ejx.389.1608100112305;
 Tue, 15 Dec 2020 22:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20201210101826.29656-1-jinpu.wang@cloud.ionos.com>
In-Reply-To: <20201210101826.29656-1-jinpu.wang@cloud.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 16 Dec 2020 07:28:21 +0100
Message-ID: <CAMGffE=F0i_HqLNQBuek76-WNe9s+iKP24SRnHkkezQBejy+DA@mail.gmail.com>
Subject: Re: [PATCHv2 for-next 0/7] Misc update for rnbd
To:     linux-block <linux-block@vger.kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 10, 2020 at 11:18 AM Jack Wang <jinpu.wang@cloud.ionos.com> wrote:
>
> Hi Jens,
>
> This is the misc update for rnbd. It inlcudes:
> - 2 follow-up fixes for commit 64e8a6ece1a5 ("block/rnbd-clt: Dynamically alloc buffer for pathname & blk_symlink_name")
>   one warning, and one possible memleak.
> - one fix for race with dev session sysfs removal.
> - fix for write-back cache & FUA.
> - reduce memory footprint by allocate sglist on demand and do not request pdu
>   from rtrs-clt.
> - Typo fix.

Ping?
>
> change since v1:
> - use kstrdup as Bart suggested.
> - fix return code and leaking iu in block/rnbd-clt: Dynamically allocate sglist for rnbd_iu
>
> v1: https://lore.kernel.org/linux-block/20201209082051.12306-1-jinpu.wang@cloud.ionos.com/T/#md330070d0688bbc57325ce0a6b2181f39dca495c
>
> The patches are based on block/for-next.
>
> Gioh Kim (3):
>   block/rnbd: Set write-back cache and fua same to the target device
>   block/rnbd-clt: Dynamically allocate sglist for rnbd_iu
>   block/rnbd-clt: Does not request pdu to rtrs-clt
>
> Jack Wang (2):
>   block/rnbd-clt: Fix possible memleak
>   block/rnbd: Fix typos
>
> Md Haris Iqbal (2):
>   block/rnbd-clt: Get rid of warning regarding size argument in strlcpy
>   block/rnbd-srv: Protect dev session sysfs removal
>
>  drivers/block/rnbd/rnbd-clt-sysfs.c    |  5 +-
>  drivers/block/rnbd/rnbd-clt.c          | 94 +++++++++++++++-----------
>  drivers/block/rnbd/rnbd-clt.h          | 12 +++-
>  drivers/block/rnbd/rnbd-proto.h        |  9 ++-
>  drivers/block/rnbd/rnbd-srv.c          | 12 +++-
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c |  6 --
>  drivers/infiniband/ulp/rtrs/rtrs.h     |  7 --
>  7 files changed, 87 insertions(+), 58 deletions(-)
>
> --
> 2.25.1
>
