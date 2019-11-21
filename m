Return-Path: <SRS0=S5B1=ZN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B4BC432C3
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 18:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EB02067D
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 18:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vRVFXkwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKUSYq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:24:46 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43626 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUSYq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Nov 2019 13:24:46 -0500
Received: by mail-oi1-f196.google.com with SMTP id l20so4067500oie.10;
        Thu, 21 Nov 2019 10:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6zhjCoXgb9L0IfgOzfxkxb6svBzYxjsHedjQIL5V7AY=;
        b=vRVFXkwJj2wwrePfM//SIRa3vMl9/Svx4A8nToAPGFIOEQqS8kSLAeYBZ/jWYg3h0R
         uqBgSuMfgk3qkOXzf2eCok8/gEivfrh7SYs36a7D08Oe1lOAdjrBXlLX5iOPbl24E/OD
         P12T3tZ4eum2QF5HLfPvhXqa6d9zdK09hmTj1uEhpcCGgwP9MO60HFEgW7FyJF+pvr75
         xevi0HaxcCccm4L87QqGSQdew0wI32K/kFU3nKPOVTJdMWhEENClQ/jeGBFED/8jb56M
         Y5XvnsmQQEp0kFcHKBD19YeoxMnKBxnN2N3gHEX2UNqdQZlaSoj40zGkt7FEslCwLUVn
         60dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6zhjCoXgb9L0IfgOzfxkxb6svBzYxjsHedjQIL5V7AY=;
        b=Oaphd5tfykluOFDL9rKsxFQyrEAIk8HKecMUyuc9j+2jWfh0YX34wtOhW1rpcd3Ul4
         WheTcSn9Y5j313XWaobpAW+V/eslrb/aW3qHbf4asZEXl0gxyMo8DLzUoRc35HTOXw6m
         9njQAKUi7/g3k3meE1mqDMJm1kgO9To/tkKQiRwDwn8GBZtN46sk+4tLiCxzsErj3LZt
         AmC30dp4qKTUCanNlaR+3BFrImmh3V8ehHxDTjqPDES+vl5ZxHsRVzO4MkAXi0qTaRlG
         Kw66xD0N0PZNsdU8+/RcH7OZGEC8JTnLNLaBFIwfLiGm8VoQqPYImRpui/Ywlg484QuV
         3WEQ==
X-Gm-Message-State: APjAAAXppbNKDhOQb2g7l7s194SPs4AxyPze5JTpkbIkGKHHHTbYsiMh
        2zkGgy5At+2jn2gER7OVGtD9h2GFuDw7MrzkdOA=
X-Google-Smtp-Source: APXvYqxa/ZxQuochzrKgMGSY6JqWP630ru10OjqlUUiFm+DEODIVeReXmbNUrOXc/d/hSXK1FQhJwu1sTMV28oPTEKw=
X-Received: by 2002:aca:c50f:: with SMTP id v15mr9239163oif.5.1574360685022;
 Thu, 21 Nov 2019 10:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20190923200959.29643-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190923200959.29643-1-navid.emamdoost@gmail.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Thu, 21 Nov 2019 12:24:34 -0600
Message-ID: <CAEkB2ERDAtBqWP12VrPb285ypMnQ8svExg2MZ3sBP6Q8B_006g@mail.gmail.com>
Subject: Re: [PATCH] nbd: prevent memory leak
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 23, 2019 at 3:10 PM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> In nbd_add_socket when krealloc succeeds, if nsock's allocation fail the
> reallocted memory is leak. The correct behaviour should be assigning the
> reallocted memory to config->socks right after success.
>
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---

Would you please review this patch?

Thanks,

>  drivers/block/nbd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index a8e3815295fe..8ae3bd2e7b30 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -987,14 +987,15 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
>                 sockfd_put(sock);
>                 return -ENOMEM;
>         }
> +
> +       config->socks = socks;
> +
>         nsock = kzalloc(sizeof(struct nbd_sock), GFP_KERNEL);
>         if (!nsock) {
>                 sockfd_put(sock);
>                 return -ENOMEM;
>         }
>
> -       config->socks = socks;
> -
>         nsock->fallback_index = -1;
>         nsock->dead = false;
>         mutex_init(&nsock->tx_lock);
> --
> 2.17.1
>


-- 
Navid.
