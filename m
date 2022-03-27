Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D88C433EF
	for <linux-block@archiver.kernel.org>; Sun, 27 Mar 2022 17:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbiC0Rzo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Mar 2022 13:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbiC0Rzn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Mar 2022 13:55:43 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A398DBE1B
        for <linux-block@vger.kernel.org>; Sun, 27 Mar 2022 10:54:03 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p15so21176763lfk.8
        for <linux-block@vger.kernel.org>; Sun, 27 Mar 2022 10:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20fQNXQ8IbsOge8G/055Q2flAhZSXzjgoB+iB3M/J+k=;
        b=Jzl+rhxcvVTNobrsLj2PiaS2xlyciHyVzQ5ZXDA5dtZfTh70OS7LSI5QmWFzIHVkE7
         gr21qqpEM8MIGcQdRuxfxPobOnK4iDRnScuwmMesvMnOhqiDRpI0Q9hEKp47FAvrgpyA
         yd0WX6TWcBJSjYC+z2/+6d/43QOEKIk02lHtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20fQNXQ8IbsOge8G/055Q2flAhZSXzjgoB+iB3M/J+k=;
        b=0TrWuRoAmMJImoHJi66Pam3laSSqBv1QAjC7YGFA4ikpSJ7zgYUV/jHM8kz5wQJkKh
         TV9ipE5HlUkYPJTqtGXZWaD9HVOdNAVTLcLTKShCHl/Byu+dfD7m/4hKHBXuHfEWK9Wo
         NFXC5Pn5fFFeQDF1Fm9+Jbn5I998OjkHQ6iLmlYrDv+kAzJGUeirjmZLgSmh9359PasJ
         LJl7975R2SCnmSEVGYfLdRsMXWLWaUT175ozX+IzIDPKf6EN7NbMEvxV9FDG26tw1vvg
         FyDRCUu7VPBexpOmHXhkWpnAMYKaTH+Z6sVqLz5hT31Tl3Rx4VdDExgLYdD/mt07bm4L
         YP1A==
X-Gm-Message-State: AOAM530q/Jr4+EWz+C6a29/WhX+F0t0HYwAKVW/7/nsVmhtNUj7NKKV/
        Sb6OSi5LuJVL6Mua4Dk71e+tGG1nyOr2GGoNhWI=
X-Google-Smtp-Source: ABdhPJxw/pxxkxrlInx7ygF+4CtRVJ6GXZqq+sieKdTNXQQWDTPYtVXmyKphclHA9WN7EtXd0zkJOA==
X-Received: by 2002:a05:6512:159e:b0:44a:31d7:3711 with SMTP id bp30-20020a056512159e00b0044a31d73711mr16440573lfb.40.1648403641644;
        Sun, 27 Mar 2022 10:54:01 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id x40-20020a056512132800b004489691436esm1423424lfu.146.2022.03.27.10.53.59
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 10:54:00 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id z12so7385602lfu.10
        for <linux-block@vger.kernel.org>; Sun, 27 Mar 2022 10:53:59 -0700 (PDT)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr16752520lfj.449.1648403639277; Sun, 27
 Mar 2022 10:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220327173316.315-1-kbusch@kernel.org>
In-Reply-To: <20220327173316.315-1-kbusch@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Mar 2022 10:53:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whktuOOGYoNC=pAVX3KOMo4AD8dFsVdD_CAesMqef_9JQ@mail.gmail.com>
Message-ID: <CAHk-=whktuOOGYoNC=pAVX3KOMo4AD8dFsVdD_CAesMqef_9JQ@mail.gmail.com>
Subject: Re: [PATCH] block: move lower_48_bits() to block
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 27, 2022 at 10:33 AM <kbusch@kernel.org> wrote:
>
> The function is not generally applicable enough to be included in the core
> kernel header. Move it to block since it's the only subsystem using it.

Thanks.

Btw - replying on the list too, because at least last time you were on
the participants list, I got bounces about "mailbox too large".

WTH? Are you living in some hut in the wilderness in the good old
nineties using AOL for email?

Because admittedly the 21st century has been all that great so far,
but at least we got rid of mailbox limits.

               Linus
