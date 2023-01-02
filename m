Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E64C54E76
	for <linux-block@archiver.kernel.org>; Mon,  2 Jan 2023 11:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjABLqk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Jan 2023 06:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjABLqa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Jan 2023 06:46:30 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96625274
        for <linux-block@vger.kernel.org>; Mon,  2 Jan 2023 03:46:29 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bt23so24605520lfb.5
        for <linux-block@vger.kernel.org>; Mon, 02 Jan 2023 03:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Y98ewzD474EukyeaTfOcqfK8VaXxEFGI17GCteSXqE=;
        b=LLfFOTp836RMUM64bBH7hDXpq0oYNS6Pk6xlDaDhA565yJyZ6NsyLawBiiNWrTKVht
         sI7OvSerZLB5XdjOoK7hxdnZ+M9K2nlY+crRtuBQIhLNpvQVVWLBc+SLLW7IK7XJUTDf
         6qp2OwP0ai30ia8VABb9UIOwselbUDXx/9mbHXamxt5SacgMk9QuI03/5hV6mQDCAtZK
         HQq5VJHEVJRZUCWQO4mMaUpUj8uLrv2U3KWRyj4M9KNrtr+oZUd2nfsb4AmXK3rcFgLx
         imQhEvo7DPyCZbII3t+Q6hUlw+XEXNBjMXaAney6iOtPEA8y7vDsjXwLQlaARRoTH/DM
         YvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Y98ewzD474EukyeaTfOcqfK8VaXxEFGI17GCteSXqE=;
        b=NJvHmB3QcKVPCQ7G9ALn6ecnmiZE4ysByR5ZHAxHt+strnWqmsnLD6kR7hYevAo2mj
         9698lM7Pn3BnQDLSEoi4rLQSs82DIxqVqKIY+Zp8CI6vl1BPBcP5cCHw39Dbg/rTHVTJ
         YSxZr4/nQj4GJEzJv2lbgw5yY6GI9onzKPwoMmcaNB3jRxogzxVwhzbl2PlDZy5RIQLj
         vFT5iul/xISgRy9vXPi+5N3I30KaZKSCU0r4sHQgOzSLAcJVk9ImTeWZrbUktzREwbKj
         GFAsfDiGZre1orOlhVoUhwkErtrslu+rzLAN0Fut3tHFXImjAOfeCxWHnzJfLW4w+RAQ
         y/sQ==
X-Gm-Message-State: AFqh2ko2zsVxxAyrFd6CYY/vsDyvmNnaOH0/pxoRFyUr2ZM57KrFkx8u
        tEBrapntDnsDZtjtAQmcLCXK+CzOWZnlzx6bwrekvz3lj4To0w==
X-Google-Smtp-Source: AMrXdXu2fT0/LtGExSEYcqO5+gfLI1dRvI5NjmSZe5SwqdSRF2/qFKKktgG2RXhiLFZ3stXqHNSskVG+1vQo7BteuQE=
X-Received: by 2002:a05:6512:12c9:b0:4b6:ef9b:c51a with SMTP id
 p9-20020a05651212c900b004b6ef9bc51amr4092607lfg.471.1672659987845; Mon, 02
 Jan 2023 03:46:27 -0800 (PST)
MIME-Version: 1.0
References: <20221230010926.32243-1-guoqing.jiang@linux.dev>
In-Reply-To: <20221230010926.32243-1-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 2 Jan 2023 12:46:16 +0100
Message-ID: <CAMGffE=AM_gXf3mK+mD3EeMFvDmTGk_5eqCk0_KXsbRs=6b6Hw@mail.gmail.com>
Subject: Re: [PATCH V2] block/rnbd-clt: fix wrong max ID in ida_alloc_max
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk,
        christophe.jaillet@wanadoo.fr, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 30, 2022 at 2:09 AM Guoqing Jiang <guoqing.jiang@linux.dev> wro=
te:
>
> We need to pass 'end - 1' to ida_alloc_max after switch from
> ida_simple_get to ida_alloc_max.
>
> Otherwise smatch warns.
>
> drivers/block/rnbd/rnbd-clt.c:1460 init_dev() error: Calling ida_alloc_ma=
x() with a 'max' argument which is a power of 2. -1 missing?
>
> Fixes: 24afc15dbe21 ("block/rnbd: Remove a useless mutex")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
> V2 changes:
> 1. add parentheses around =E2=80=98-=E2=80=99 per lkp
>
>  drivers/block/rnbd/rnbd-clt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.=
c
> index 78334da74d8b..5eb8c7855970 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1440,7 +1440,7 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_cl=
t_session *sess,
>                 goto out_alloc;
>         }
>
> -       ret =3D ida_alloc_max(&index_ida, 1 << (MINORBITS - RNBD_PART_BIT=
S),
> +       ret =3D ida_alloc_max(&index_ida, (1 << (MINORBITS - RNBD_PART_BI=
TS)) - 1,
>                             GFP_KERNEL);
>         if (ret < 0) {
>                 pr_err("Failed to initialize device '%s' from session %s,=
 allocating idr failed, err: %d\n",
> --
> 2.35.3
>
