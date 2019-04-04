Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49D2C4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 06:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9914520855
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 06:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m04GjEUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfDDGxv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:53:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40353 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDDGxv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 02:53:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so2150700wre.7;
        Wed, 03 Apr 2019 23:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m8dOxwjMtjeJjK8uyvoYPtzscfPEToyarYRhNuN7daA=;
        b=m04GjEUtk/8dDC++jLq89ABXBHqoLwnsPYnnbUwHCqdNeIjo5PxHRQ+cmtu8/fyagn
         OPFxNwMGzgJiVxibtYiOOF9a7a2l+IsSwXpM2lnz+UrfaVeCMzCuYygW+/ZxiAcir7Ng
         co0+nwF4PJ8s7j0tEsFGCupF4yqGccLH6Wata+q1bdDXoJEBnEjg2expvBSqkUoUL2ah
         VfbF7GiYA9wwhbh4I0kF630srJKfE+7BT90d3RQI0qLgj3XUpCPQKKHi2lQMIPjzxH0g
         3UvvoSXhdyvl7QZ0nRgGdoEpHOrwAsTDDUxmwroRKL3/H67ElNbYYyiugviDYOmewkuH
         Xn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m8dOxwjMtjeJjK8uyvoYPtzscfPEToyarYRhNuN7daA=;
        b=NyCnaOpTpXBlfX3OXtvhdSoo2F/RmiwmaBj4zJAXC1fvEXyESFQ8LKvmtLQLuli8Hr
         1fBUbFW16np6VTnuL9Wq0hnkdwcJfcOoGt4O/6uEWh7AGgQbH4uZZB9loD7cR345ZvP1
         QaDK/F/saN7RP7xll5iGQcyHo/BIwstP/SxS7WL5OqL6fAP1BRglI8N4pLqUZxLmsgaw
         8reVKTeIPNuExUE2qSTMGS7QAWawtyLEp5LnlsF3HKGdW26vMZ2gdL/iXLP2DWXPSKfh
         05u2BCc/2UT0K0q/sSYwGphoJGcfgfpGaXd0PqDidTjS6B0DlhDfpxfnGKDgjfntTeM+
         fm5w==
X-Gm-Message-State: APjAAAWevE5GHinrVtEoJvLyFJ1fOXnKfsKoeMTpKz4LFhu90y9DuREj
        KNJSVk5Ph24VyYfRrua15f59okcaAJbSkfjoFWk7vNNI
X-Google-Smtp-Source: APXvYqwiqtc5h+Rpw3Q3tYZ9cYAYf+fRhLh97ZvLWT6aHebkBR1IP060PzOAYYtbFMiudKkvHe0SZJOeqaa7FLVjBjc=
X-Received: by 2002:adf:ce8f:: with SMTP id r15mr2569537wrn.90.1554360829785;
 Wed, 03 Apr 2019 23:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <1554346664-24038-1-git-send-email-dongli.zhang@oracle.com>
In-Reply-To: <1554346664-24038-1-git-send-email-dongli.zhang@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 4 Apr 2019 14:53:37 +0800
Message-ID: <CACVXFVOm17EvGVD7AiEWY8VUbPqCo2benoOLx-1hWyM99++0sA@mail.gmail.com>
Subject: Re: [PATCH 1/1] blk-mq: do not reset plug->rq_count before the list
 is sorted
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 4, 2019 at 10:54 AM Dongli Zhang <dongli.zhang@oracle.com> wrote:
>
> We would never be able to sort the list if we first reset plug->rq_count
> which is used in conditional check later.
>
> Fixes: ce5b009cff19 ("block: improve logic around when to sort a plug list")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  block/blk-mq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3ff3d7b..c162718 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1711,11 +1711,12 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>         unsigned int depth;
>
>         list_splice_init(&plug->mq_list, &list);
> -       plug->rq_count = 0;
>
>         if (plug->rq_count > 2 && plug->multiple_queues)
>                 list_sort(NULL, &list, plug_rq_cmp);
>
> +       plug->rq_count = 0;
> +
>         this_q = NULL;
>         this_hctx = NULL;
>         this_ctx = NULL;
> --
> 2.7.4
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming Lei
