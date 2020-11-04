Return-Path: <SRS0=E+wN=EK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746EBC2D0A3
	for <linux-block@archiver.kernel.org>; Wed,  4 Nov 2020 14:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CAC2221E2
	for <linux-block@archiver.kernel.org>; Wed,  4 Nov 2020 14:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n75odohM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgKDOMs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Nov 2020 09:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbgKDOMs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Nov 2020 09:12:48 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9786FC0613D3;
        Wed,  4 Nov 2020 06:12:47 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 10so17374596pfp.5;
        Wed, 04 Nov 2020 06:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EPrDk3OcYNyDhIZUacjjrRgEf+nd1FGeAeZGvJook8o=;
        b=n75odohMXmXjK5Gtt7yUnKqFQNOMgXbugS2iFkSF6ejIwbzUIaTKwdgeb+dIJ50hFy
         ISgJHr8opymyloi7CvjFQUIaAUfZfJdoLMDgbVxxGPMHl7dYa4/ZqRlS4Fr65T1cL2V4
         xCagKOsnON6sKqD8lLSUdRZg8PbR3qTSyNo4+1CH4biHLKOsam9TiTZBoXrPbvROGzCB
         LfHFiT/uOiZtLJ8m1SzMdlxuMO+aVBKHRKSfu59JKXxMYHz+kmeGfL1aDz1fwpreP3ZL
         sy/rIwARcY1GqMCO7zam6wg76rsNQP1WwI61rTOXF8eCj6PIuunoy0g2XveAS9lNBlaq
         9e/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPrDk3OcYNyDhIZUacjjrRgEf+nd1FGeAeZGvJook8o=;
        b=sRwLyK2an5/Y5juAzwbVKjh4kAdV18M5rkr+d3WNAihDu11wQh3JDOB5P1wk5IUqzG
         2fM8j6aaio/FWitMzLAKev+qbivvGnUiP3+OEi0iQ9FaNJYSnJUGMBs8MnycZByk4kPq
         J9xjjHeeM7bi7zuVbeX88fX61xj9QhFiL/Pkoj8cJd8nskb/oZtuoWfFOGTjMnrM58KK
         SdyUoJoIsoqa7h1SrpX40eHBmQBLknMu4oXtH0dm6zhZhLhRNaFArmpFF/zyh/xu9VX7
         C4JjOgWDlJPXYUFRmBYGjeXYnCOrqOvG4oJ0wsNcAFu4Sx+2dRna4EyQX4LclBujoLMF
         utxA==
X-Gm-Message-State: AOAM532QEKMWqczh5A6R+nnm1830SUWHVuL/jdwvNriDh1X+ByyXGsEE
        T95ium1mgnC2nCumUka75ch1rhs0UinQ6tqKqg==
X-Google-Smtp-Source: ABdhPJysatzLZwdMrcFQ6VeD4kgctIDbBwW/oD34F16XBh+iwftoZ+K+Zi7eGTY/Sjm5pzvg+/8Sb8mnAZUzkQnG5p4=
X-Received: by 2002:a05:6a00:44:b029:152:8967:1b2a with SMTP id
 i4-20020a056a000044b029015289671b2amr30026838pfk.48.1604499167010; Wed, 04
 Nov 2020 06:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20201028115921.848-1-rsalvaterra@gmail.com> <20201028185927.GB128655@google.com>
 <20201103212847.GA1631979@google.com>
In-Reply-To: <20201103212847.GA1631979@google.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 4 Nov 2020 14:12:35 +0000
Message-ID: <CALjTZvZpjgSqT8fRF90yooTV6S5eoz+PBJn7BfesT=y2uW8nmA@mail.gmail.com>
Subject: Re: [PATCH v4] zram: break the strict dependency from lzo
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, ngupta@vflare.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Minchan,

On Tue, 3 Nov 2020 at 21:29, Minchan Kim <minchan@kernel.org> wrote:
>
> Can't we just provide choice/endchoice in Kconfig to select default
> comp algorithm from admin?

I'm fine with whatever you guys decide, just let me know what works
best for everyone.

Thanks,
Rui
