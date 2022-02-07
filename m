Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC86C433F5
	for <linux-block@archiver.kernel.org>; Mon,  7 Feb 2022 17:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbiBGR02 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Feb 2022 12:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242444AbiBGRTS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Feb 2022 12:19:18 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE25C0401D6
        for <linux-block@vger.kernel.org>; Mon,  7 Feb 2022 09:19:17 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w14so31628367edd.10
        for <linux-block@vger.kernel.org>; Mon, 07 Feb 2022 09:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Bpm5xCm6lbMEjb6E6FobgdnJVJasrPPGpl6KCiYRgM=;
        b=a3tojpRh9LyG1HB9vOiafOasa72XcjiwjX10yLoRyEC7dQcnzKXfNJyiElGB4x6efl
         Z6hkasrLGqkc8jsc5j0c0z1EI8mfP551kYSjK2lCvGnoCP3m4n5knLo3Aa8o8T6MBFSN
         FlVrsf7Yd/j0gc08gfY+FEvcHpJkpdF+RqysWyfYA3jiN4og7PgeiOb3Ot/A/NBAanFL
         Ftenw7Fg5w3L8S5WednZqylHpFxQrPXJlGY/3mJkdaouzi0O/Yl9ZOYGtutb28JeOuHs
         KsUw7X9H/lXD1Afmvqff79/cmxqIlJW3OqqwJTwotnBh90xT7Jm62hFgeJJ784TKEOYL
         ObLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Bpm5xCm6lbMEjb6E6FobgdnJVJasrPPGpl6KCiYRgM=;
        b=7aU/airhJ+n0wBe0r+Mf7+Ai3YSYGfmFYlJDmxj1Q3fREDPJPNJz8IJXXcUMD0Pihp
         VC2Qdvi1uxBqOJSWLHQfn5MC/zqfD3/X8C0KRDLKAFxrPj+hlg3Zl/wn48Yg7sFywhEG
         XAO+zY4lOVaJFnW4sMH5wDU4SuhYOtkT3/RaUObq7iRoRlTEzkzBXLnOaIor963O6sNQ
         nUJfR1ewVb3GeW49hr0ESv0KcEss9V/qaxOdrtExWJlTpSUrj7ZsHFI6kfht0HwgKRxR
         PbJX4WOWvGeRwGSJnaIiVJ/0RjcEsKVIWSppXFzpy/O0yWCiTrge4cNPwolkN5ABm73e
         451w==
X-Gm-Message-State: AOAM531pT/+7kHLv+IqEhGVSDxzpemlv7z7dENtV/2SVucF4bQV6+s7G
        18/qitDCHUQZ7F9uKEUhybHuIKx1C5t9sBT4CTIe59IA
X-Google-Smtp-Source: ABdhPJwAKRYJdNf+uA69YYkosJfUQE71jIk/ytcGZb2Pu0pClNz6GfjhhbbM4rCGVqY/JCqZlcslqJoD0z2fKZ4js/M=
X-Received: by 2002:a50:da87:: with SMTP id q7mr336881edj.64.1644254356577;
 Mon, 07 Feb 2022 09:19:16 -0800 (PST)
MIME-Version: 1.0
References: <20220205091150.6105-1-chaitanyak@nvidia.com> <20220205091150.6105-2-chaitanyak@nvidia.com>
In-Reply-To: <20220205091150.6105-2-chaitanyak@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 7 Feb 2022 09:19:04 -0800
Message-ID: <CAHbLzkosqBwCV8wFkfHtqvsrie8nb4CNBm9Hfw4xUpUjX5-s4Q@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] block: create event class for rq completion
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 5, 2022 at 1:12 AM Chaitanya Kulkarni <chaitanyak@nvidia.com> wrote:
>
> From: Chaitanya Kulkarni <kch@nvidia.com>
>
> Move the existing code from TRACE_EVENT block_rq_complete() into new
> event class block_rq_completion(). Add a new event block_rq_complete()
> from newly created event class block_rq_completion().
>
> This prep patch is needed to resue the code into new tracepoint

Just a minor nit:
s/resue/reuse

> block_rq_error() in the next patch.
>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  include/trace/events/block.h | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index 27170e40e8c9..1519068bd1ab 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -100,19 +100,7 @@ TRACE_EVENT(block_rq_requeue,
>                   __entry->nr_sector, 0)
>  );
>
> -/**
> - * block_rq_complete - block IO operation completed by device driver
> - * @rq: block operations request
> - * @error: status code
> - * @nr_bytes: number of completed bytes
> - *
> - * The block_rq_complete tracepoint event indicates that some portion
> - * of operation request has been completed by the device driver.  If
> - * the @rq->bio is %NULL, then there is absolutely no additional work to
> - * do for the request. If @rq->bio is non-NULL then there is
> - * additional work required to complete the request.
> - */
> -TRACE_EVENT(block_rq_complete,
> +DECLARE_EVENT_CLASS(block_rq_completion,
>
>         TP_PROTO(struct request *rq, blk_status_t error, unsigned int nr_bytes),
>
> @@ -144,6 +132,25 @@ TRACE_EVENT(block_rq_complete,
>                   __entry->nr_sector, __entry->error)
>  );
>
> +/**
> + * block_rq_complete - block IO operation completed by device driver
> + * @rq: block operations request
> + * @error: status code
> + * @nr_bytes: number of completed bytes
> + *
> + * The block_rq_complete tracepoint event indicates that some portion
> + * of operation request has been completed by the device driver.  If
> + * the @rq->bio is %NULL, then there is absolutely no additional work to
> + * do for the request. If @rq->bio is non-NULL then there is
> + * additional work required to complete the request.
> + */
> +DEFINE_EVENT(block_rq_completion, block_rq_complete,
> +
> +       TP_PROTO(struct request *rq, blk_status_t error, unsigned int nr_bytes),
> +
> +       TP_ARGS(rq, error, nr_bytes)
> +);
> +
>  DECLARE_EVENT_CLASS(block_rq,
>
>         TP_PROTO(struct request *rq),
> --
> 2.29.0
>
