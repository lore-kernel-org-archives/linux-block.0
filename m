Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045ADC48BE5
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 15:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC72361166
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 15:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhFPPJL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 11:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbhFPPJL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 11:09:11 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF63C061574
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 08:07:04 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so2807039otl.3
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 08:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HxnSNJO/aYru61gYChHqJrtaGhaX+s82wfcK2X596kY=;
        b=cLvdpV7HsPoLnb9Kdl4h96EE3Te4GqhprP9XrStc/8sDTGiPx+ipNvK9JWgl6MTKSv
         bJSTMahmtJWLTb6aw3bTOLZny0RD/yAdclWKun+HHzp5JmG9TsCrMsZpUzUKITRhbacj
         itFDxU3d4WIMDgttLd8PA3CVfLuIa1WovM9iWkH4kPGK14eux58yUJsCX4sosCUOC8iP
         YUoC/gfolhyw5bd9O+WCMAK9L325fFfSzBZSD72rFYF/Qx6/GOZM0jS3sB4+33TkRwgM
         ZMYJcJJqkIYQvI/w5mHCF/+tQaD9L0WhE8tfHqz9LfV6JjrJ/X8kL7oVz7UWZWMz9T8g
         i8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HxnSNJO/aYru61gYChHqJrtaGhaX+s82wfcK2X596kY=;
        b=THxPrbPDZfYz1nTHujAA5zSUye4/woJqiKg+Ji9f4HOWZpHiAl1azLJGOSj9NgFAyq
         JjwJWFNsIOgocI8kjQQAQ6jX/ElZnlh72dtk1pLlzwfGEWqoP1smudIATzsjOGO4kOyE
         E/YhqvhIG4ib5ZBH/vNvYZ1u1TrbEoJ9cZPiPJ7X/wdBg2zzbQ1nzZM3+fdzChOY8mkP
         acRINl5Gl595pYyPIkgWdIulxEAvtOH+vzX+C1zulyiCNi5TH5N0AGbiN/lJs6fDuBd6
         5LnjFkJDC51rPWYAqRa7jXxp6RnCWSZ/P7Xcz4wo6ECTebQACLzAINw/Kye0JyFUAZ6b
         O6oA==
X-Gm-Message-State: AOAM533SWW0ZFK/1IfF4EEbH9VNuWcoWAz4C4UtJfLNQM7r+c3ezhqEZ
        1AEF5wYHnH1TB9L4UNByuMDfxpXFxBuBMWdLxs6i2Mdg
X-Google-Smtp-Source: ABdhPJxQPe9k0qs1D+Xct9/jZmbGtDdiO5/Kr77Vuw/u1wIqk5l7TjP14q2xcQAC29xxbwcvhSyo3JEZL+lmHqwTwzo=
X-Received: by 2002:a05:6830:1387:: with SMTP id d7mr323787otq.61.1623856023384;
 Wed, 16 Jun 2021 08:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <CA+8F9hggf7jOcGRxvBoa8FYxQs8ZV+XueVAd9BodpQQP_+8Pdw@mail.gmail.com>
 <YMhxY9svDeVApu95@T590> <CA+8F9hjFDE9b31-qsxsVJf4SV9Ctr-mwOJrsw0kVeC7DdN=5XQ@mail.gmail.com>
 <YMi0C5U0NeMdO04g@T590>
In-Reply-To: <YMi0C5U0NeMdO04g@T590>
From:   Omar Kilani <omar.kilani@gmail.com>
Date:   Wed, 16 Jun 2021 08:06:52 -0700
Message-ID: <CA+8F9hiKXfH2Pa_FL1M0KAqtDQRGXc6b-9rqM9CfytRfe5ha2Q@mail.gmail.com>
Subject: Re: Deadlock in wbt / rq-qos
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

I can confirm after a day of running my repro tests that the patch has
fixed the issue.

Thank you Jan.

Regards,
Omar

On Tue, Jun 15, 2021 at 7:07 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Tue, Jun 15, 2021 at 06:42:40AM -0700, Omar Kilani wrote:
> > Hi Ming,
> >
> > It looks to be the same issue based on the log timelines. I *think* tha=
t
> > patch will fix it but it=E2=80=99s really subtle so I=E2=80=99ll test.
> >
> > I can only trigger this on an AMD Milan machine for some reason that I
> > don=E2=80=99t understand. Sometimes in 800 seconds, sometimes in 5 hour=
s.
> >
> > I have a new build with printk=E2=80=99s on the atomic_inc_below to che=
ck the
> > acquire condition.
> >
> > I=E2=80=99ll add that patch and re-test. But I couldn=E2=80=99t find th=
at change in the
> > linux-block git? Is it in a specific branch?
>
> The patch is in the branch of for-5.14/block:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/com=
mit/?h=3Dfor-5.14/block&id=3D11c7aa0ddea8611007768d3e6b58d45dc60a19e1
>
> Thanks,
> Ming
>
