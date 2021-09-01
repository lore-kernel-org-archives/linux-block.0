Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD6BC4320A
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 13:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF16A60234
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 13:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244136AbhIANoz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:44:55 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:37710 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242470AbhIANoz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Sep 2021 09:44:55 -0400
Received: by mail-ua1-f53.google.com with SMTP id g2so1363941uad.4;
        Wed, 01 Sep 2021 06:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gWwkSDKtYGpqljVYI1y+WfrFXR09Q3LdZi5r8xigkjk=;
        b=m1HTLPNjsWXmfN6HerDCFvrWzQD7uaJ6ME2c79x3oWwCbeGW71g729vuzQuVWK1amV
         m/gG5PdsI9OW8YZmKhxGoQTD9UZozHxkRlbdjwSkfPytpnH4cLS2gpQiDKg6lfqnmvak
         ek3y+mHOPP2KGM01N0HSvx+hGNSvqNUwnfhUr5/lXdCXgfChRahtJpJrQYBb59qaAYvF
         yL5awjgGtNGjRIS0ZnP+GgigOMLps3gnu8wBZ+mJ2mDDdfOkfTU0i+3CjljsB2UrRbJ1
         W/pDdTk8x5VF49bzjVlsQYFiR4n1FleQOCHcUACBpK5fxsCA6yk0B3KSp7sngMpZbWTZ
         Sc4A==
X-Gm-Message-State: AOAM532hra/ABhnITQ9bz/3V7nHBPjrXVhxf/CzwoFujfzBfij8xD/aw
        vqUeQ5XDwQiousuy3qJk9DYzWvkZSQ9qZaFtpDE=
X-Google-Smtp-Source: ABdhPJwQuBYdXPN25peyItUun+pLAld/i8v6Ep8jdmiUeF2ltHZxB5QeDFZxYSpkK7+IOC5bnXvgZm+ETQziLUn4arE=
X-Received: by 2002:ab0:2989:: with SMTP id u9mr22973907uap.122.1630503838209;
 Wed, 01 Sep 2021 06:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210830221000.179369-1-mcgrof@kernel.org> <20210830221000.179369-4-mcgrof@kernel.org>
In-Reply-To: <20210830221000.179369-4-mcgrof@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 1 Sep 2021 15:43:46 +0200
Message-ID: <CAMuHMdXCUhrnXSmjFP7nJKHZp2joVRz-Ka2BUNMcZFA06CJ1wQ@mail.gmail.com>
Subject: Re: [PATCH 03/15] m68k/emu/nfblock: add error handling support for add_disk()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, justin@coraid.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes.berg@intel.com>,
        chris.obbard@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>, thehajime@gmail.com,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Tim Waugh <tim@cyberelk.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Lars Ellenberg <drbd-dev@lists.linbit.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 31, 2021 at 12:10 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
