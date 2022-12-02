Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB00BC4332F
	for <linux-block@archiver.kernel.org>; Fri,  2 Dec 2022 10:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiLBK20 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Dec 2022 05:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbiLBK2Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Dec 2022 05:28:25 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086D32FA6F
        for <linux-block@vger.kernel.org>; Fri,  2 Dec 2022 02:28:23 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id h24so4460124qta.9
        for <linux-block@vger.kernel.org>; Fri, 02 Dec 2022 02:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylGtQ4aHoKpRgzGyzoZLymGQWp7U4G0g9FjRAEYlfNw=;
        b=V3PVfmtNHNYRNE2pJSDaG/8RaS7aQz7S/Fdlh0R6Fy+rKW217cEzNbYDRMM4qc6uf7
         pz5vOGAHyUpYFlL657H6UZGANWI9XFRUSvSyDQyJ2XHio6qyIB50q1BMRhzjLB5mu9iJ
         H1pUmlqRMKwmxfQYfXyWkU3AemuitdZxDDMvpinD6P7tVGhuZ+6y3yzr3iKC5YvhYgBQ
         XHpedY7krCDfE/rG6bWk0Ka8ZHHMRP1ZIOwGG1aaV3oCYyi5iWFHHJpnjzDhD0ZYiAtt
         QwcSKscQqU9R+njBFDX8L9nEEpV6TgBZ7wqewVsMg+05xgUAC0jpGSbqZVdt7I13MaMz
         Bqdw==
X-Gm-Message-State: ANoB5pkOAXbz4ZdZ7vZ4TbIzZTrgwkIMMKuQJaGXdSCdzL++hjGSu2WJ
        IouSJ6HGhfLd2D8FZxX6s2Yn1a5fYneaww==
X-Google-Smtp-Source: AA0mqf7SDDhauxJGVvcHzJqWjY5UqPEN939y/1ld8MvUf8LtOvQJJfd4iXp8PstfcjQYVMY44aCEaQ==
X-Received: by 2002:a05:622a:258d:b0:3a6:5758:e24 with SMTP id cj13-20020a05622a258d00b003a657580e24mr45291212qtb.261.1669976901997;
        Fri, 02 Dec 2022 02:28:21 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id q23-20020a37f717000000b006cbc00db595sm5018618qkj.23.2022.12.02.02.28.21
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 02:28:21 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id z192so5545657yba.0
        for <linux-block@vger.kernel.org>; Fri, 02 Dec 2022 02:28:21 -0800 (PST)
X-Received: by 2002:a25:a028:0:b0:6d5:a323:51b8 with SMTP id
 x37-20020a25a028000000b006d5a32351b8mr54222802ybh.33.1669976901384; Fri, 02
 Dec 2022 02:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20221202003610.100024-1-luca.boccassi@gmail.com> <20221202084845.66mn2m3srfabehnu@wittgenstein>
In-Reply-To: <20221202084845.66mn2m3srfabehnu@wittgenstein>
From:   Luca Boccassi <bluca@debian.org>
Date:   Fri, 2 Dec 2022 10:28:10 +0000
X-Gmail-Original-Message-ID: <CAMw=ZnQ+iPa9gv95_8Z4mVdBr-ma5ohd-Ys49WYOB+KmMQY_9g@mail.gmail.com>
Message-ID: <CAMw=ZnQ+iPa9gv95_8Z4mVdBr-ma5ohd-Ys49WYOB+KmMQY_9g@mail.gmail.com>
Subject: Re: [PATCH] sed-opal: if key is available from IOC_OPAL_SAVE use it
 when locking
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-block@vger.kernel.org, jonathan.derrick@linux.dev,
        gmazyland@gmail.com, axboe@kernel.dk, stepan.horacek@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2 Dec 2022 at 08:48, Christian Brauner <brauner@kernel.org> wrote:
>
> On Fri, Dec 02, 2022 at 12:36:10AM +0000, luca.boccassi@gmail.com wrote:
> > From: Luca Boccassi <bluca@debian.org>
> >
> > Usually when closing a crypto device (eg: dm-crypt with LUKS) the
> > volume key is not required, as it requires root privileges anyway, and
> > root can deny access to a disk in many ways regardless. Requiring the
> > volume key to lock the device is a peculiarity of the OPAL
> > specification.
> >
> > Given we might already have saved the key if the user requested it via
> > the 'IOC_OPAL_SAVE' ioctl, we can use that key to lock the device if no
> > key was provided here and the locking range matches. This allows
> > integrating OPAL with tools and libraries that are used to the common
> > behaviour and do not ask for the volume key when closing a device.
> >
> > If the caller provides a key on the other hand it will still be used as
> > before, no changes in that case.
> >
> > Suggested-by: Štěpán Horáček <stepan.horacek@gmail.com>
> > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > ---
>
> But it would be quite the change in behavior for existing users, no?
>
> It might be better to add an ioctl that would allow to set an option on
> the opal device after it was opened which marks it as closable without
> providing the key?

Closing with a zero-length key could not work before and would fail
with eperm, so I can't imagine anyone using it as such, so I didn't
bother.
But I don't mind either way, so I will add a new ioctl for v2.

Kind regards,
Luca Boccassi
