Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044EEC2D0E4
	for <linux-block@archiver.kernel.org>; Fri, 27 Nov 2020 12:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB9322245
	for <linux-block@archiver.kernel.org>; Fri, 27 Nov 2020 12:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="AA2qPhXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbgK0MyQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Nov 2020 07:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbgK0MyP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Nov 2020 07:54:15 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DF6C0613D1
        for <linux-block@vger.kernel.org>; Fri, 27 Nov 2020 04:54:15 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y16so5845114ljk.1
        for <linux-block@vger.kernel.org>; Fri, 27 Nov 2020 04:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vkFn5MkJ5eHFvGe+cSGhjvF50/P+N434NKcke2py+jk=;
        b=AA2qPhXsKGN1XSpp/ecMKBH/+y59S29puXcMtCdXmxAihXLqjwAgcw+5ft/XbW4YFN
         8C+p3hDTO9T3Ifp7WBMtU4I32Wo5endD2EwqljyadvpOG0HuVEBCW/FRbjxyEIJylCEE
         iegsUHwBSZhI+NFU4S0QhGpnRnaZNfweDEbyBsO97S/c0eXCxpcvwF9M8aDMPXcRmDJF
         y1L8rbs+j9Fp3OJBELKR46YO6UBjB+pTIGD/mRdms7u3Rnng302Mp6HrXri4e/RDiud9
         HHdUjvfh9Pa+ap9QVh4+s1jSbQMHhoIH5slEaGNqixT4l2OtsDv+I4gU9UQb8glC0VDW
         o/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vkFn5MkJ5eHFvGe+cSGhjvF50/P+N434NKcke2py+jk=;
        b=mUCxB+yxUTM5n+ApisPLzaaonJYpCg69yyap87v4hqFyjoFKqnzfOZTOc+USUor7S+
         ttD5bcoThQ+n74GvblU2QhEiIBoKswxXCEjZUl6TdvpFj2MbsS4Fbyc3wpkFFuoTDY6l
         Y3AIsJf3/rs4stu6ibAqlL3iwwkrcBdwBubutHTbeDfw//ou/9ZJB9s1xpaZMAfLHvh3
         nG22WuG9bYdDZtdFWSgfyVo2awbMucLHFjG2Lo1bfjq8i9wG7YdEwrAKp75LemU0yutO
         3wukQundy5QH3+wH+gRuVbJE0ai6uF3X5GdRBMPAHYAR/GPW3Dcs04lVI2iEfDRyk2G6
         yJpw==
X-Gm-Message-State: AOAM53191EaEPHU2165SB/8i6DvcYCtmJms0Cbj9C0RI48+8f29+b6/j
        ey6hMaTZCWyRtkXahIzWH6+6sOKo7yNDye9LgdAk
X-Google-Smtp-Source: ABdhPJxnpJuH1qCcyBG7IdsjjfT2699qABDMeft535WgILhcwKBQromZU8ced70LvOULG8f2QdwuKZNaKM5pVqsXHGQ=
X-Received: by 2002:a2e:8910:: with SMTP id d16mr3480658lji.295.1606481653890;
 Fri, 27 Nov 2020 04:54:13 -0800 (PST)
MIME-Version: 1.0
References: <1606479915-7259-1-git-send-email-ingleswapnil@gmail.com>
In-Reply-To: <1606479915-7259-1-git-send-email-ingleswapnil@gmail.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Fri, 27 Nov 2020 13:54:02 +0100
Message-ID: <CAHg0HuzKb0e21bo3V53zskKtk+zaJXhxkU8m4w6Q2DWoWPkU6w@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: Adding name to the Contributors List
To:     Swapnil Ingle <ingleswapnil@gmail.com>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:RNBD BLOCK DRIVERS" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 27, 2020 at 1:31 PM Swapnil Ingle <ingleswapnil@gmail.com> wrote:
>
> Adding name to the Contributors List
>
> Signed-off-by: Swapnil Ingle <ingleswapnil@gmail.com>

Acked-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>

> ---
>  drivers/block/rnbd/README | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/block/rnbd/README b/drivers/block/rnbd/README
> index 1773c0a..080f58a 100644
> --- a/drivers/block/rnbd/README
> +++ b/drivers/block/rnbd/README
> @@ -90,3 +90,4 @@ Kleber Souza <kleber.souza@profitbricks.com>
>  Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
>  Milind Dumbare <Milind.dumbare@gmail.com>
>  Roman Penyaev <roman.penyaev@profitbricks.com>
> +Swapnil Ingle <ingleswapnil@gmail.com>
> --
> 1.8.3.1
>
