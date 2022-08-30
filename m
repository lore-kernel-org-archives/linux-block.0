Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D4FECAAA1
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 13:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiH3N3P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 09:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiH3N3O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 09:29:14 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B43A50E4
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 06:29:07 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id og21so22165091ejc.2
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 06:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZYF1wkIgbk2TZTKVzLXtn5zqbB8KACfWfrcGmiD4Jqs=;
        b=KkdrGbhQQ4osFJ+bC9iyTviHxkUZh80Pzd11ANuePnMScDN4aVuigj9znglEY2nO2/
         +a4v+phBQwOECLMLlfUGEqYuNeIHLgDtChyn9mFIJTBuYxM5b2i92xdeQoFOooDVlZKo
         iCvSrbSDq29DF7dIVc11e6kTBEQRGNSztkK3mJb54hCNePX2ui/YuTi8607LkeAxXzF/
         ++f8qm+hADbjjtET+w/tgxX8NLu/2pmaFZ3iqRpd1A1l68dVnilimvn1BFirsyWJRUCt
         DoyE+uJA8XDuwpTnlq/IdaABZt2iCQ3DSHCo+QO8uQ4SYonZlEmn24pl+tcoPu8esBix
         7Pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZYF1wkIgbk2TZTKVzLXtn5zqbB8KACfWfrcGmiD4Jqs=;
        b=aUwNgoaxqRI+tyVwB8Y76lNqh3SqQOXsNOtBEvx58Y9pb2LFO9A2981WGbJsk6WpDu
         qBVxs2alcEU+ENLyjYVmrb0XoBVTDyifwhX+7g7rmh+vnKpGwxqM1wS0V8Nju5pRE/ew
         Im9poR7WY+d7NVcxYNG3tgc0/FPhD1Ckw9BiMLphk8vP5hfwuQzFyq/noo2SkIc1doPt
         bxDJCRziXhEEjzcCWO/+g5j5ddkHWQwLTqlSOPedNN9zK17LxevPBILRPz9TfOD3CiZr
         jbrAFsZBNYQCBz437XQjjW4Hq7Wej+y8nyhpYTbFaEiZcbZlGvJ+Qk31Zd81W0ojkYZj
         kQCw==
X-Gm-Message-State: ACgBeo30qMDC6q7ZcI34Ce4m35UcrG19yR1jbWxGG6tuS7TdHPaEJgpI
        kjWxVG6ZqcRtBgPe7CPOdTdvVsoXPgqrd8nkzMmPiQ==
X-Google-Smtp-Source: AA6agR49Xrb9+N6EjCEJ/hB/8ClGcAJBd8xEabd2yTnT/HpexwId8xQbYFNd/uVBmpmUVBYgAwKQYEOLLQ+KLwtVS/Q=
X-Received: by 2002:a17:907:7292:b0:733:1965:3176 with SMTP id
 dt18-20020a170907729200b0073319653176mr16912739ejc.318.1661866145694; Tue, 30
 Aug 2022 06:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220830123904.26671-1-guoqing.jiang@linux.dev> <20220830123904.26671-2-guoqing.jiang@linux.dev>
In-Reply-To: <20220830123904.26671-2-guoqing.jiang@linux.dev>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Tue, 30 Aug 2022 15:28:54 +0200
Message-ID: <CAJpMwyhT4mnbA4xi2xD4-EeJeXNJL6oQ66QfbddnPdZZBWA2_g@mail.gmail.com>
Subject: Re: [PATCH 1/3] rnbd-srv: fix the return value of rnbd_srv_rdma_ev
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     jinpu.wang@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 30, 2022 at 2:39 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> Since process_msg_open could fail, we should return 'ret'
> instead of '0' at the end of function.
>
> Fixes: 2de6c8de192b ("block/rnbd: server: main functionality")
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/block/rnbd/rnbd-srv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> index 3f6c268e04ef..9182d45cb9be 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -403,7 +403,7 @@ static int rnbd_srv_rdma_ev(void *priv,
>         }
>
>         rtrs_srv_resp_rdma(id, ret);
> -       return 0;
> +       return ret;

I think the point here was to process the failure through
rtrs_srv_resp_rdma() function. If you notice how the return of rdma_ev
is processed by RTRS, in case of a failure return; it tries to send a
response back through send_io_resp_imm(). Same would happen in the
function rtrs_srv_resp_rdma().

If we call rtrs_srv_resp_rdma() with the error, and return the err
back to the caller of rdma_ev, we may end up sending err response more
than once.

>  }
>
>  static struct rnbd_srv_sess_dev
> --
> 2.34.1
>
