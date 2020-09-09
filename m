Return-Path: <SRS0=1Rjj=CS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D449C433E2
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 11:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F4821D7F
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 11:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="DOpEExo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgIILnx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Sep 2020 07:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbgIILnm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Sep 2020 07:43:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA4EC061795
        for <linux-block@vger.kernel.org>; Wed,  9 Sep 2020 04:43:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so2587647wrx.7
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2020 04:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IoOwfF+G1FhxX5cbjmmLGfMHMYzBv9TU48vhKftxc4E=;
        b=DOpEExo5OekREeixjcSIiA4XaYFDzY4R5rQVYK7Yr3+aRN49fKpEnlSQn1p3NL2szo
         jJl9XLfdxe6ZtZ7o+2zglk5PkyocqIXdOfMz2yFObqPab392C+AtYgOSXQufb+LCfJRs
         cH1IMgxzKfteJy63eRcUtTn4xx0b6VGOomM714xvPCKb6b3JYwwN2qfXNOR9dPZQIfoe
         hJp8uFXVxFGgmpPTmTzqie2dcHgMqpqO2HEBUt4EzxgrYpp87b2byLdAxwNqDG/PyL3s
         Wy6/kOGt/1vl9SSBaGRqunmiclb7e3XOUTL9YiseNP2HRlQJps/neAjQjVpv2eewDDJx
         7Ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IoOwfF+G1FhxX5cbjmmLGfMHMYzBv9TU48vhKftxc4E=;
        b=secGgSU7/6BKi9r71QoemwrAjUfYIqYk0IKUUlnq/9yaXYbXSh1uvgfjs6BjbhmBmZ
         gNfNA1lrG2KvILKi/8ITDCsUTr+KxwVYzQRd2LsUn2l2F7qOgpt9yJq9keO93EAPKyF2
         dWIjJX72C4G9ZoKU7XlgkW5dGeft6c92IY9oN6hXCSYxsQqFb/CF7BWhTK9peBqjk7E8
         PW1cH9EwxFAvxYx8PzrfU0Ns00MFJWme9zuhF+X6CUV0lDj2Xfk6e5wWFxc8wtOHo1YF
         vzeRlAv7O81Nut57mIIOB3fjfjRE+bVTlmWx+dOYBHDI9FJNtaA9ACeQuoq0R+zjiwut
         jLPQ==
X-Gm-Message-State: AOAM532El9woakBJ786OksQ8AP3e/usiuFttJNcZkTrtLdLtuNlrP2ff
        jdDqCBA1U85dqJ9LqllgkInFnMlJ5XoNyGt/THqR
X-Google-Smtp-Source: ABdhPJxoVFaBjvxkgoCd8gkWhxu1oRIRDUlJoJokVKR9f7iE4SskInZ+QaVYiFzUBkT0z331yEU5ggJyNx3ZC+udIvA=
X-Received: by 2002:adf:81e6:: with SMTP id 93mr3473456wra.412.1599651785016;
 Wed, 09 Sep 2020 04:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHg0Huzvhg7ZizbCGQyyVNdnAWmQCsypRWvdBzm0GWwPzXD0dw@mail.gmail.com>
 <3b2f6267-e7a0-4266-867d-b0109d5a7cb4@acm.org> <CAHg0HuyGr8BfgBvXUG7N5WYyXKEzyh3i7eA=2XZxbW3zyXLTsA@mail.gmail.com>
 <cc14aa58-254e-5c33-89ab-6f3900143164@acm.org>
In-Reply-To: <cc14aa58-254e-5c33-89ab-6f3900143164@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 9 Sep 2020 13:42:54 +0200
Message-ID: <CAHg0HuxJ-v7WgqbU62zkihquN9Kyc9nPzGhcung+UyFOG7LECQ@mail.gmail.com>
Subject: Re: [RFC] Reliable Multicast on top of RTRS
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 4, 2020 at 5:33 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-09-04 04:35, Danil Kipnis wrote:
> > On Thu, Sep 3, 2020 at 1:07 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >> How will it be guaranteed that the resulting software does
> >> not suffer from the problems that have been solved by the introduction
> >> of the DRBD activity log
> >> (https://www.linbit.com/drbd-user-guide/users-guide-drbd-8-4/#s-activity-log)?
> >
> > The above would require some kind of activity log also, I'm afraid.
>
> How about collaborating with the DRBD team? My concern is that otherwise
> we will end up with two drivers in the kernel that implement block device
> replication between servers connected over a network.

I have two general understanding questions:
- What is the conceptual difference between DRBD and an md-raid1 with
one local leg and one remote (imported over srp/nvmeof/rnbd)?
- Is this possible to setup an md-raid1 on a client sitting on top of
two remote DRBD devices, which are configured in "active-active" mode?

Does anybody know?

>
> Thanks,
>
> Bart.
