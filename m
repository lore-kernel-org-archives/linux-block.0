Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6512ECAAD5
	for <linux-block@archiver.kernel.org>; Mon,  5 Sep 2022 11:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbiIELmJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Sep 2022 07:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbiIELmJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Sep 2022 07:42:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9BD5A3F7
        for <linux-block@vger.kernel.org>; Mon,  5 Sep 2022 04:42:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id u6so10940136eda.12
        for <linux-block@vger.kernel.org>; Mon, 05 Sep 2022 04:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kPhqrZI190RrT5dmSAXDRJ04O2Jq0fRqXUjgTNlv3yA=;
        b=YjlsZ9kdl/GbTdeAhP+TubZOB35Ze+WFiBjYTH65t5kik2RGIjE7H89o42vEQDeRMn
         TQGHQEx7S2AveGlzRryLgqJ74pTJFmBRJq71HM+SA/1y5avph3NtixqnzComqWF4yIcz
         WFiPWKWMM+yZibJ+CRpTxOZk+rzWrA+94zsTUioQzdTPA5QRe1FtV6OwKEbypqmSCwR1
         naLuVSYCZmSeCdFpQ8bkkp6zoLGpavtfVAS1q7Cuy06qG27ep1F5E7OTapx713ZPnT6p
         p0kdJPUYYUiyEr+/8WuNCSDdyYdARmzzYyJ0ooTARJldLfv1T1RCaM9bYqryLkHjdJm7
         xStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kPhqrZI190RrT5dmSAXDRJ04O2Jq0fRqXUjgTNlv3yA=;
        b=X5Ulpl51ABHs+eKVBxhkSVRLmYNLzvJRkxDwZTyDSVu7/mMGDtiKZvQ3j1nfXc8AWK
         yWzZZYKBQ61DXi8nvvbzWPkSt9uuD7PTkt/zBZVrshvnDskXdOjTiXOQg3YCOlgupdMO
         Fa9MdUH+/BS7VYRzxyjkK56ljZ77HH0BDjJ2lZyJpUmqza2BqmUEWF2JnhUHxvSWTndq
         M88g+BohZVLfM7aey2/rUsAiGXhijezG1+WYk3TFhN6hPYgg62xOnxJw0Nh9ZL//MLi0
         wOFtLDipSuqMGxsbEDKCOyen9GawznQ2hjO+wRj+RlGgIKUvFuiYteotOeOK1UTqKo9i
         kfDg==
X-Gm-Message-State: ACgBeo3PWEbju/4ZBJUjT890sWyPIQcbR/RVYhPf4bCG5O9x0BUggKyg
        myiMOFqv7HTXoRg9UKQtOCDhwSNju1qiek7iigQs1w==
X-Google-Smtp-Source: AA6agR6jpQhscHMrzBaaaAPeZK2h4prZE1fpXrWV6LVit+6JLRtgq3zoKtPPtnfW5jKuRXw0wBiP6gkL36aVlz6jr5Y=
X-Received: by 2002:a05:6402:510a:b0:43d:ab25:7d68 with SMTP id
 m10-20020a056402510a00b0043dab257d68mr42601300edd.102.1662378126456; Mon, 05
 Sep 2022 04:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220902100055.25724-1-guoqing.jiang@linux.dev> <20220902100055.25724-2-guoqing.jiang@linux.dev>
In-Reply-To: <20220902100055.25724-2-guoqing.jiang@linux.dev>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 5 Sep 2022 13:41:55 +0200
Message-ID: <CAJpMwygCbd5ZSEHDjBug8GpSWnh0ooQeQW-rs5ByO6PhNo1AKA@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] rnbd-srv: add comment in rnbd_srv_rdma_ev
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     jinpu.wang@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 2, 2022 at 12:01 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> Let's add some explanations here given the err handling is not obvious.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---

Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>

Thanks.

>  drivers/block/rnbd/rnbd-srv.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> index 3f6c268e04ef..a229dd87c322 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -402,6 +402,11 @@ static int rnbd_srv_rdma_ev(void *priv,
>                 return -EINVAL;
>         }
>
> +       /*
> +        * Since ret is passed to rtrs to handle the failure case, we
> +        * just return 0 at the end otherwise callers in rtrs would call
> +        * send_io_resp_imm again to print redundant err message.
> +        */
>         rtrs_srv_resp_rdma(id, ret);
>         return 0;
>  }
> --
> 2.31.1
>
