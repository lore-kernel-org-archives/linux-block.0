Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C326C48BD3
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030C72086D
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMmJVSWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfFZUM0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:12:26 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38728 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfFZUMX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 16:12:23 -0400
Received: by mail-yw1-f68.google.com with SMTP id k125so31517ywe.5
        for <linux-block@vger.kernel.org>; Wed, 26 Jun 2019 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0ag//sSTBXe5XwvoTeu79SND79oGWRbV/V2H0jwuDc=;
        b=eMmJVSWFTXgd+rzN4EgYIz43VtVe7SHefB84LydsW1hd//DXNDpVKyAiRfV8sOy1RB
         oy/AON7b+WlP5prltaZG69S0gGnapYL+SNAzCbXOucIC+pfvg2C9SQhDeNqFQfTqTA5w
         U13vpROZ6fNJWE7FdsP7mByucPksx+KUqhUJyaVXtkc0+U1Xe2ZtHZ4ClVK9F5WyZGDd
         eu1cH22XJTVtSRt+y5TTpFaAtth8jGWDh/kbx2qjGi9lj+MYcKKlKpALSEOoC8pHf+U4
         3XLdBD1Yleo2WXcDrTaQBftfS6T7Acwuo+//1x2XB4BHhPOT4w8/aNDkNPVwrisK5bGs
         4t+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0ag//sSTBXe5XwvoTeu79SND79oGWRbV/V2H0jwuDc=;
        b=eujRnqudb/QlstfiQihxj47QwmVdZr+YkTblAMftGaRXaT0ip/YnyAyCADqUnztjbQ
         FlS0FtswmayFce7PeGOvZ5hZBocWE9OpEVZRTnDkleeCKjPlB/YGUvJJV0BBI3P9yHM1
         qw0t7jiquWF7ld+LnuwBXdyIPzIaFicdTpE+YVMJAXoxpeBhAJd2uEqUQoLOHSts73o6
         LgppU5OxmdNyQIedXWVBwx3Av3VkFrDaI1eZ5L6JogmLFkhsDZIbB9lG6GhsAr6wsbqr
         8P5fndVh7gYKimZCQOgjOSuC7DPIj8qq0Q4UgOcvND/T7iQ4fKBlLS3XoCS0AFU21FIk
         qwpQ==
X-Gm-Message-State: APjAAAWcaEUxJVtwxHdY7hWA/2y7KrXz03PpSKn/7E/ieIs7UKGoSWwV
        ZEH52E1NKHrbYULNeLgU6NZeoazDv1F5sM6GfSjA+w==
X-Google-Smtp-Source: APXvYqyXgfBznM5WvMnMY1IBu6vtv0FfLfZ6WnZ1HnfaUfpy8CQptRkzmR+1cowaTM3vodbQT6bKM9UpbY2fNHUsi/U=
X-Received: by 2002:a81:a909:: with SMTP id g9mr4063332ywh.233.1561579941805;
 Wed, 26 Jun 2019 13:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190626195919.107425-1-dianders@chromium.org>
In-Reply-To: <20190626195919.107425-1-dianders@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 26 Jun 2019 13:12:10 -0700
Message-ID: <CABXOdTcKo=r9Yxj9KQEAdqgO5ok_4udak9x3ae7WEe_B7r5fZg@mail.gmail.com>
Subject: Re: [PATCH] block, bfq: Init saved_wr_start_at_switch_to_srt in
 unlikely case
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 26, 2019 at 1:00 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Some debug code suggested by Paolo was tripping when I did reboot
> stress tests.  Specifically in bfq_bfqq_resume_state()
> "bic->saved_wr_start_at_switch_to_srt" was later than the current
> value of "jiffies".  A bit of debugging showed that
> "bic->saved_wr_start_at_switch_to_srt" was actually 0 and a bit more
> debugging showed that was because we had run through the "unlikely"
> case in the bfq_bfqq_save_state() function.
>
> Let's init "saved_wr_start_at_switch_to_srt" in the unlikely case to
> something sane.
>
> NOTE: this fixes no known real-world errors.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Paolo Valente <paolo.valente@linaro.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

>
> ---
> Paolo said to add his Reviewed-by in https://crrev.com/c/1678756.
>
>  block/bfq-iosched.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 72840ebf953e..008c93d6b8d7 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2678,6 +2678,7 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
>                  * to enjoy weight raising if split soon.
>                  */
>                 bic->saved_wr_coeff = bfqq->bfqd->bfq_wr_coeff;
> +               bic->saved_wr_start_at_switch_to_srt = bfq_smallest_from_now();
>                 bic->saved_wr_cur_max_time = bfq_wr_duration(bfqq->bfqd);
>                 bic->saved_last_wr_start_finish = jiffies;
>         } else {
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
