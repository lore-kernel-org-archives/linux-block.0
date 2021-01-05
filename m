Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5EAC433E6
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC512075B
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbhAEN54 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 08:57:56 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57519 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbhAEN54 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jan 2021 08:57:56 -0500
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1kwmpl-0000zU-W9
        for linux-block@vger.kernel.org; Tue, 05 Jan 2021 13:57:14 +0000
Received: by mail-wr1-f71.google.com with SMTP id q2so14889999wrp.4
        for <linux-block@vger.kernel.org>; Tue, 05 Jan 2021 05:57:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wVh8jZDenKs7jZkIG5lokK+Lb8BlIIF/jnmR6raOQA=;
        b=ZQNnUgcM/ecVyZpAs4zgod12+uxy3OB3qxpvg+DomF/5vC3zyrz2/MuznL6JgYyA4X
         +v2jWT4wQezEemE5HXK/pCVLzMcFVz2MRF+PKte0GnXfPbeQuKcm8rnE7U/KuY0ZrRUF
         M+PxyFnrodI4GpLiVFTM8hbmdTRnqIqVsBlChyn79zF4hKd0iWsSH1OSN9GEcYlcMh1Z
         /cvcuLvYX2EWQK0kvaIwj9TBSNn6di2SAr6VskuyD+0XzSvu/0UXpEUesAIkdLdBm/ja
         mSTWpgHV7JaeTETMaPNytusdTJRUjKrsG9QyguuG8gYd9XSZ/XjVSLWBSmpuqdL9abls
         0COQ==
X-Gm-Message-State: AOAM532vwd85YXy3jwQ/WbkR9kraP5lWoQaAgd9Hedbj2ZaHbln97iTd
        VlseuvInK0QIkeYnChrZ1pKhjuQOdwbJdTo1ROk0XzwOUNvUnSJ4VzisEBoHUVJIAyWG7zL/KzA
        IusbNHSF+GPvDNtpw7RjMxqrzOzPoZUXZbPEvLzdJe+FucNB44wNJjAdY
X-Received: by 2002:a05:600c:21c7:: with SMTP id x7mr3504974wmj.75.1609855033556;
        Tue, 05 Jan 2021 05:57:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1eCs3cnpgc7t2ZRYYu0yqUEDLQMIdZspYe16BgatCG55sWB4HV0JKnFbOK8Fyn8Z0ZBdoWA4QQNrjrBI1wmc=
X-Received: by 2002:a05:600c:21c7:: with SMTP id x7mr3504969wmj.75.1609855033444;
 Tue, 05 Jan 2021 05:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20201231162845.1853347-1-mfo@canonical.com> <87k0sv6hv2.fsf@collabora.com>
In-Reply-To: <87k0sv6hv2.fsf@collabora.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Tue, 5 Jan 2021 10:57:02 -0300
Message-ID: <CAO9xwp11Y_n=Nm8a=0dubaJ_bVztXe4fiJxYvxNyQ6o4m0P+FQ@mail.gmail.com>
Subject: Re: [PATCH] loop: fix I/O error on fsync() in detached loop devices
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jan 2, 2021 at 2:14 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Mauricio Faria de Oliveira <mfo@canonical.com> writes:
[snip]
> > Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> > Co-developed-by: Eric Desrochers <eric.desrochers@canonical.com>
> > Signed-off-by: Eric Desrochers <eric.desrochers@canonical.com>
>
> This sign-off chain is not sorted correctly.  See Documentation/process/submitting-patches.rst.
>
> Other than that, I think the fix makes sense.
>
> Tested-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>

Hey Krisman,

Thanks for testing and catching that; sent V2.

[snip]
> --
> Gabriel Krisman Bertazi


cheers,
-- 
Mauricio Faria de Oliveira
