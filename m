Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5F1C432BE
	for <linux-block@archiver.kernel.org>; Tue, 31 Aug 2021 01:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C344261027
	for <linux-block@archiver.kernel.org>; Tue, 31 Aug 2021 01:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239315AbhHaB5j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Aug 2021 21:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbhHaB5i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 21:57:38 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19F3C06175F
        for <linux-block@vger.kernel.org>; Mon, 30 Aug 2021 18:56:43 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y6so29142314lje.2
        for <linux-block@vger.kernel.org>; Mon, 30 Aug 2021 18:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ocjIUDmX3hKTbJbz6QQbvjMwP3S46wm9qukXiYRtxYY=;
        b=HBHocZLVMlDdUfo0yXUUjJIhXpPD2TTZFmPkL4Y412SVwPrraMCtcYt0ka38Sm7YDc
         6zw77Zd+Vt2mbCr7jdQZOI2Xe7Yk/Jdy+ZWr+ZaVTx+oxuwiEuVSaR0/gez5tBvUBfLH
         tsSDwXF+8mJsV2hhXt8tOg09FDFIn4LTeQ/Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocjIUDmX3hKTbJbz6QQbvjMwP3S46wm9qukXiYRtxYY=;
        b=QftvV1WPJ4V/PCVKccx8CT2iWkt+v81MHC71jnJIWEascEd94njlOx25oJrq08HrYt
         lpI6L6xInavsAif8C9Ou3xSBn4of22O4+i8IGIO85aVuM/fUc+ksQE0B5Ns8TWMl68Jk
         2MDjrMC7xPXSYPnDDEMhMyUQ0nfmn+xFN5dPKLZ/TEjtvDyTsZ5sBflWpkdnMz1zJCrX
         l9joSNd20iCbnMG3OH3in1cXY/WPg2unFDSOizV/n35T5VgH5L+8Axqj5tpjO5UNJ+VT
         w0Zqag/ChtcsVk1jdDGkKyJl4xL7zCGJqrbq04vlM7WjcAFDXPuE7hcWj0SLc4hkpOKc
         njCA==
X-Gm-Message-State: AOAM532rUvjizo7OuDt9ZZRiG7EIkoOfu5tOK20wNuRkc4srclFfLhfV
        cvLegWco/7bgURMJUriWzxvQHb1SA9h7E4dWHtQ=
X-Google-Smtp-Source: ABdhPJwjNA6bM8yzymPUbszvGUMtWdDzffIJvaNOtCeex/0U++gWAJdXeK+JkgZShYKf6mmP/P2Xuw==
X-Received: by 2002:a05:651c:200e:: with SMTP id s14mr23333319ljo.306.1630375002038;
        Mon, 30 Aug 2021 18:56:42 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id j5sm1563167lfu.1.2021.08.30.18.56.41
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 18:56:41 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id q21so29048366ljj.6
        for <linux-block@vger.kernel.org>; Mon, 30 Aug 2021 18:56:41 -0700 (PDT)
X-Received: by 2002:a2e:84c7:: with SMTP id q7mr22463936ljh.61.1630375001358;
 Mon, 30 Aug 2021 18:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <e1a3e2aa-ad96-c9c6-af38-16b7300a5612@kernel.dk>
In-Reply-To: <e1a3e2aa-ad96-c9c6-af38-16b7300a5612@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Aug 2021 18:56:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbPcDsJqKoW1HO_8c=FCUGhOifDR+tUpdt4bALAgtTJA@mail.gmail.com>
Message-ID: <CAHk-=whbPcDsJqKoW1HO_8c=FCUGhOifDR+tUpdt4bALAgtTJA@mail.gmail.com>
Subject: Re: [GIT PULL] Block changes for 5.15-rc1
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 30, 2021 at 7:32 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> 2) drivers/block/virtio_blk.c - error handling fix later in the 5.14
>    cycle ends up touching the same out path. My resolution:
>
>  -              goto out_cleanup_disk;
> ++              goto err_cleanup_disk;
..
>  -out_cleanup_disk:
>  +err_cleanup_disk:

I did it the other way, and used "out_cleanup_disk" to match all the
other "out_xyz" cases in that function..

That should obviously be equivalent, unless something strange is going on.

              Linus
