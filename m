Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99065C31E40
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 13:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C778206C2
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 13:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhLp6AZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfHLNk4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:40:56 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33143 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfHLNk4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 09:40:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id v38so10399034qtb.0
        for <linux-block@vger.kernel.org>; Mon, 12 Aug 2019 06:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dSKRXGL/+plLto3WJPtbZQ6KO+hSsWvmFnRTt1dlNH0=;
        b=ZhLp6AZoKqWhg8Ucptk+pLo9uaCCUU8mVjkyhgPemnxlkY14tpjJOfib2Wy1QBUndy
         hWMeKfomvd9goicQahQ7KK0c2eQuJRLIYnqFSAun5Jmcql+aS19QeSwPlV7W2VJqlFhn
         uF7Zw0qwmVgaByWOqqNN4YN3PJierJgbwPzk/tfwM3Un2e1DP+nOS8QTI0lzV6BjHrHH
         ubnFyvCbB5ZbgSw1tNBrius6ITeYQq5NyjYqnISSRPSqCiWpAeaiqBnmrTAJ5lbl9xzb
         zvaViyCzOMkxgm3uKzFOyOw3sgHk0Q9AujB4sunCqEXnZeQ4NQPkXAqREJPmVUEpddKU
         FBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dSKRXGL/+plLto3WJPtbZQ6KO+hSsWvmFnRTt1dlNH0=;
        b=Nkaoubf85ayvYgAp1U8jk7mPvpZfS8vEIuiZ/5oDdBXDayOyRv9eK66VtVzn3M9nbp
         EZ1TBFifHDTmWiQQZTjK/3L7Mk3NOXWo/4SWE7rEI1eEoQPVsS3el/ioxty+FT9xuNT1
         aViYThfGLO1xiRfVgpFg4qPFehUTBEdDeKk+P6/9XAoFlW5IQAvVhKYOH72v9xlzi98+
         o6W35oBnx3Eqea5Jh70QpaSUYL9fi7B+6dGAl99nlptJaXN4EmCTwxQ0jGopD+AsfE5L
         nrM2mja2d0EmrP25rOSkXYtSlIYULd28fPg0a7M0miBIy2PIgGUx4+2CQ3Ci+6LEqKD8
         cCCA==
X-Gm-Message-State: APjAAAVeVDwUvA8znkBCAWfohXfNA7DHCLzSugKTVXdwinl14NEEj5MA
        kX6lc7U5F5ekJ/oNrSRcDnz1c/PDmkxEAPvNVj6mk2dDAFQ=
X-Google-Smtp-Source: APXvYqzCzKuUpNLcRbh5woMxr/qfpgGqTqweAfP/qmr53h4CPwfvxG0/1omN+uNvTYFDSOaRV0lpbl7si2ltHvkMSZo=
X-Received: by 2002:a0c:d851:: with SMTP id i17mr30224587qvj.243.1565617255092;
 Mon, 12 Aug 2019 06:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190812123933.24814-1-jusual@redhat.com>
In-Reply-To: <20190812123933.24814-1-jusual@redhat.com>
From:   Stefan Hajnoczi <stefanha@gmail.com>
Date:   Mon, 12 Aug 2019 14:40:44 +0100
Message-ID: <CAJSP0QXoNOhuFQs2WRXT3md=xOT0RcYe77Xs+vphsZ_oRc4V1w@mail.gmail.com>
Subject: Re: [PATCH] liburing/barrier.h: Add prefix io_uring to barriers
To:     Julia Suvorova <jusual@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Aarushi Mehta <mehta.aaru20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 12, 2019 at 1:39 PM Julia Suvorova <jusual@redhat.com> wrote:
> diff --git a/src/include/liburing/barrier.h b/src/include/liburing/barrier.h
> index 98be9e5..4f3d1d7 100644
> --- a/src/include/liburing/barrier.h
> +++ b/src/include/liburing/barrier.h
> @@ -23,7 +23,7 @@ after the acquire operation executes. This is implemented using
>  /* From tools/include/linux/compiler.h */
>  /* Optimization barrier */
>  /* The "volatile" is due to gcc bugs */
> -#define barrier() __asm__ __volatile__("": : :"memory")
> +#define io_uring_barrier()     __asm__ __volatile__("": : :"memory")
>
>  /* From tools/virtio/linux/compiler.h */
>  #define WRITE_ONCE(var, val) \

Please prefix WRITE_ONCE() and READ_ONCE() with IO_URING_ as well.
They are fairly likely to be used in code derived from the Linux
kernel.

Otherwise:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
