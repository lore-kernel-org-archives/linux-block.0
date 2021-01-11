Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D7FC433DB
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 06:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B855522A85
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 06:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbhAKG57 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 01:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbhAKG56 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 01:57:58 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29055C061794
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 22:57:18 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id w1so23064400ejf.11
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 22:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+lyh1ppXIwVihU1vaSfQka7MGwNTcAyGaSNwcJGbRT4=;
        b=BQBzzfbH/m620+N7MJFkTRbdXbHw1MUrP0quVj3E0xdU1n2clxvwAGEiwraS10+8wv
         5YhjkZ3NlYaWjnaKX9eaU0oJjf87JLch1FudPerJMgAB7/qykhrg7meIlOpAS3GcWIv0
         FTHEDoNm/NR1NEbXDTo97QP4rm2/9SUSbQ5aEg/Sk44HEVGROyg3gteWKUGXJPuBSTga
         h1fvzfhtXT3hFNbeCb1DJf7GWqmDCYnxJZknrJn7yfWvsk1Dteqr8oQnR9HkIZlDZQyV
         ztqmSCP7kNR3rhoRWY2IVpXhkK5UxH2D2x9s9J64edPJWJySO1SKjzVGlxafdTuHJz+z
         ciqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+lyh1ppXIwVihU1vaSfQka7MGwNTcAyGaSNwcJGbRT4=;
        b=H0Fr93A6KFicvDTVsrcPV4ffUDEoyst1JyOg915GBgvPR9zVkVvfYfnnMhKSZgx3lj
         FyMnQpXKuR/Z2L/7NAOeEFA2+5sgv12pXxCyGf0GWZOo2zAUHFA40WfpiCqt/HAYdoHm
         o5Os61KVF1GQN9iUXdueEHFrx8KWfzpALcE2v4f/Jx8wbnOtmaM/5GlJrc6SBdxJRs88
         KmawQuA1NP62qoSx/janMdiTjvm5m7pf+wDUlMPXSIzHbkIhnZzfwNHtyGb5n98G3CiZ
         JmPnaUzJa+FBlAVd6MoA1NEM/o5RasE40VcDZyoV415evh/QDBnUtDDjMKx4FtLd1Q78
         oqJw==
X-Gm-Message-State: AOAM530hTpxaTqd8TRWKPsFgzsyeIUgAABwGMKChNNLDjADejJrDynuB
        tITUf9qA0zM1y+WL1bzk2qYMZc1PecyK34UFF5TqpCTHzwg=
X-Google-Smtp-Source: ABdhPJxcnwOKJW+7PaRjv13AJnR4ZY6ZtOFxqa2IamjgxWQFkIE/NHsiwfD6EjJH5ZqQEQnEASWUNRA8l4hbVsBzU6s=
X-Received: by 2002:a17:907:4243:: with SMTP id np3mr9714493ejb.212.1610348235838;
 Sun, 10 Jan 2021 22:57:15 -0800 (PST)
MIME-Version: 1.0
References: <20210110215726.861269-1-trix@redhat.com>
In-Reply-To: <20210110215726.861269-1-trix@redhat.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 11 Jan 2021 07:57:05 +0100
Message-ID: <CAMGffEnM0qD68x8bA17gWcqM-PkzveX+E02t-ircy68ses0rGw@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd-clt: improve find_or_create_sess() return check
To:     Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>, ndesaulniers@google.com,
        linux-block <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jan 10, 2021 at 10:58 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> clang static analysis reports this problem
>
> rnbd-clt.c:1212:11: warning: Branch condition evaluates to a
>   garbage value
>         else if (!first)
>                  ^~~~~~
>
> This is triggered in the find_and_get_or_create_sess() call
> because the variable first is not initialized and the
> earlier check is specifically for
>
>         if (sess == ERR_PTR(-ENOMEM))
>
> This is false positive.
>
> But the if-check can be reduced by initializing first to
> false and then returning if the call to find_or_creat_sess()
> does not set it to true.  When it remains false, either
> sess will be valid or not.  The not case is caught by
> find_and_get_or_create_sess()'s caller rnbd_clt_map_device()
>
>         sess = find_and_get_or_create_sess(...);
>         if (IS_ERR(sess))
>                 return ERR_CAST(sess);
>
> Since find_and_get_or_create_sess() initializes first to false
> setting it in find_or_create_sess() is not needed.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
Less LOC is better :)
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Thanks Tom and Nathan!
> ---
>  drivers/block/rnbd/rnbd-clt.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index 96e3f9fe8241..251f747cf10d 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -919,6 +919,7 @@ static struct rnbd_clt_session *__find_and_get_sess(const char *sessname)
>         return NULL;
>  }
>
> +/* caller is responsible for initializing 'first' to false */
>  static struct
>  rnbd_clt_session *find_or_create_sess(const char *sessname, bool *first)
>  {
> @@ -934,8 +935,7 @@ rnbd_clt_session *find_or_create_sess(const char *sessname, bool *first)
>                 }
>                 list_add(&sess->list, &sess_list);
>                 *first = true;
> -       } else
> -               *first = false;
> +       }
>         mutex_unlock(&sess_lock);
>
>         return sess;
> @@ -1203,13 +1203,11 @@ find_and_get_or_create_sess(const char *sessname,
>         struct rnbd_clt_session *sess;
>         struct rtrs_attrs attrs;
>         int err;
> -       bool first;
> +       bool first = false;
>         struct rtrs_clt_ops rtrs_ops;
>
>         sess = find_or_create_sess(sessname, &first);
> -       if (sess == ERR_PTR(-ENOMEM))
> -               return ERR_PTR(-ENOMEM);
> -       else if (!first)
> +       if (!first)
>                 return sess;
>
>         if (!path_cnt) {
> --
> 2.27.0
>
