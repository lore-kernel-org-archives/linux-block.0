Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2FFC41517
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 14:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D31822ADB
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 14:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P64B5njO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfGXOOp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:14:45 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:44939 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfGXOOp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 10:14:45 -0400
Received: by mail-lj1-f174.google.com with SMTP id k18so44649389ljc.11
        for <linux-block@vger.kernel.org>; Wed, 24 Jul 2019 07:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbhv8LhBo4aKuCuDZ4rTmdHYc9oX+NLCwFJRpoCernI=;
        b=P64B5njOFfeF04DpLURzFCzvVnBS2nOluBuBAbtqOFTIcnhPmMothXMtQJuPzohoXn
         f8muQ3nE7KcFqgLE0eheoVsqdNCLF3FxM75zUNVatLwbbDwBitqYCmXkrZM3y165nkS7
         JkcV+yMfE6SbLIysnoQAveESL5pa+RFIOeCNYDQFJonsR+fEis41AE6MDifCByRUslp0
         yVaXJKQRYoyLYA2PQLZGeIJQQWzB5uDBEbhGGB75Cygx/y81YqxJllAP++6AizZ97ER3
         1IwpMWPD1ve20LEodvydY4UVV/MkoiJdIVgBwUDQOO4M3HtIH8zyr6mhrmMKtbizL2kW
         2Fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbhv8LhBo4aKuCuDZ4rTmdHYc9oX+NLCwFJRpoCernI=;
        b=LkVmGlK4sJYBScOVPsdj+aAxp+lCwmfM9Tp12GIPmOvDu3QcIzE3qyAYsVp/2JJ8aW
         h6w6zL+u14bn31dEanynGwq0aMUnW9pKgE2gkr3WlDZYYLvdTL97416sGHHZVudxpIKB
         tbq/WK7V5R7JLc8XsS5JkXZL6TSzcWtES3rMhCLASX5L/NQEGo1miGycNHxIB/wynww0
         jnF8vmJdmaoAf04/sTx8pvqJfe4TzLW7JauM4uhhFJFSr1zMrirhMx5zCNxyCahIgXIP
         5FgRIzt5hWjhYsMCwpSSiVvYpg8571bZoWOEd7yWwWQoiJEHoA/A93uQGavz+bWAHi3h
         E8kA==
X-Gm-Message-State: APjAAAU9v0S5T/vhfBOY+WppY0iFLjBRVW1pqlpC+gyrCOfMSM8jvE7Y
        k3klm7+wYSfjdzBWckTLqY370265GOoUNwHrMAE=
X-Google-Smtp-Source: APXvYqy/v3ORWntBZmFE5+LYUxxgbFfkau47Yj2h7xiy0fBVA5HysjAp4i8i+z+PqqA/cv+tiRKv1/VLPnFJfH1VsPE=
X-Received: by 2002:a2e:7619:: with SMTP id r25mr42319011ljc.199.1563977683452;
 Wed, 24 Jul 2019 07:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <CABbHjzYH7q6zV8uErKJUTQWhrNw2DFH_7XFbPG7ORGcWTuH36g@mail.gmail.com>
In-Reply-To: <CABbHjzYH7q6zV8uErKJUTQWhrNw2DFH_7XFbPG7ORGcWTuH36g@mail.gmail.com>
From:   Daniel Kozak <kozzi11@gmail.com>
Date:   Wed, 24 Jul 2019 16:14:32 +0200
Message-ID: <CABbHjzZOUv91viBQUj3O_doHUMcWTRauXUfhHfTxpwAuuKaT+Q@mail.gmail.com>
Subject: Re: io_uring completly hang my pc
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I am playing with io_uring interface and for some reason it is causing
freezing my pc.
Here is some example code which cause this:

https://bitbucket.org/kozzi11/uring_hang/src/master/main.c

When runing this and test it with wrk (https://github.com/wg/wrk) :
wrk --latency -d 15 -c 2048 --timeout 8 -t 8 http://localhost:8080/

it completly hang pc.

Thank you for any hint if there is something wrong with way how I am
using io_uring interface or it is a bug in io_uring itself.

Daniel Kozak
