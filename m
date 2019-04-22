Return-Path: <SRS0=Rcoh=SY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80530C282E1
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 09:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516FA206A3
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 09:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cK3dKLXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfDVJgF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:36:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40501 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfDVJgF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Apr 2019 05:36:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so15163207wre.7
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2019 02:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFNWBA3/MHCO9WcSdUWpSvNjHHUGg3/i9IxhJlJN4GY=;
        b=cK3dKLXU2+HadloWtWj58ebLz7y7oEDmsF6DtCBAxa8Fln3FQtp4ByZdLrFSVKxG7U
         jOR8i5kwX0VUAHOapDFoVxQKpAe8a+Xh3zCME9dVN1wtcITEQdkns8NDlTBCtI59R5Lp
         lkcsQmPdA4RdsKUUJha8KtcSG1Mc1oZxSjpDpvZAL/ua0baG4gjhPezyrYoOBfsZJfDm
         zVVAJwzFEwk+TqA9faajZ0uOqCpPxSNeQ1vZykapkCEU3vjn7F+60VHqjHQqDbBCXNFR
         OTPqvaqJCLO3slcF/nUfzk0VsCmDPG81fjnFKJe/CPNsvX/38L+XzEWfKl1awT3f4IO7
         mKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFNWBA3/MHCO9WcSdUWpSvNjHHUGg3/i9IxhJlJN4GY=;
        b=PQ9UPsHJLMeIJyBwLkUwE8j+hy5TnHLaK3urmF+yoUk6blLYTxo0qZE96nDODcu+Li
         HggjHmea2zhkNHR75bxgb3GnNyYhyk97KkYkvDQmPtDZavhMFEF0wMlJOhQofX89ognE
         PCaOV5YUa8XAHAhUiqBKvIW+3yJVR6ZJo8/umwcQA63dZ9eTVazhzilDkMp74xQeLj83
         QR5RsxiXGOf7592iZUlkKbZZwQqo5yQIsG1fhU0eaRDiOh0pu8Q2Pa9Hs/CWs+PIlEE8
         zfwVKecsWJPPKMjRhu90DqhdwRWbXySicChrobsKMTqpK0GCu/ij8OMysTZmjoTZN+Tr
         xiYA==
X-Gm-Message-State: APjAAAXF9uja3UMI+chQTsCtx6+wC3RBQIoxdc5L8rmvhB2HdUQjgRkY
        +4aByUTGYerBIZBOWqnwOqaFMP61VFqOr3zeT+HtMK8Me0g=
X-Google-Smtp-Source: APXvYqwESQFU9lZNsmCah55RoopXTaAscs7OzO1b0OojbBkP0HrTKpozTHAFrkGc7LqV7b0ReBzvBxlGgr2Ig87gTSA=
X-Received: by 2002:adf:edc8:: with SMTP id v8mr2956559wro.206.1555925763634;
 Mon, 22 Apr 2019 02:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190419065624.25583-1-hch@lst.de>
In-Reply-To: <20190419065624.25583-1-hch@lst.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 22 Apr 2019 17:35:52 +0800
Message-ID: <CACVXFVOagy6HDaPTadyXehWk6ru0adiBR8jhURdj3stHdguReQ@mail.gmail.com>
Subject: Re: [PATCH] block: avoid scatterlist offsets > PAGE_SIZE
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Guenter Roeck <linux@roeck-us.net>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 20, 2019 at 6:55 AM Christoph Hellwig <hch@lst.de> wrote:
>
> While we generally allow scatterlists to have offsets larger than page
> size for an entry, and other subsystems like the crypto code make use of
> that, the block layer isn't quite ready for that.  Flip the switch back
> to avoid them for now, and revisit that decision early in a merge window
> once the known offenders are fixed.
>
> Fixes: 8a96a0e40810 ("block: rewrite blk_bvec_map_sg to avoid a nth_page call")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-merge.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 247b17f2a0f6..21e87a714a73 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -474,9 +474,21 @@ static unsigned blk_bvec_map_sg(struct request_queue *q,
>         while (nbytes > 0) {
>                 unsigned offset = bvec->bv_offset + total;
>                 unsigned len = min(get_max_segment_size(q, offset), nbytes);
> +               struct page *page = bvec->bv_page;
> +
> +               /*
> +                * Unfortunately a fair number of drivers barf on scatterlists
> +                * that have an offset larger than PAGE_SIZE, despite other
> +                * subsystems dealing with that invariant just fine.  For now
> +                * stick to the legacy format where we never present those from
> +                * the block layer, but the code below should be removed once
> +                * these offenders (mostly MMC/SD drivers) are fixed.
> +                */
> +               page += (offset >> PAGE_SHIFT);
> +               offset &= ~PAGE_MASK;
>
>                 *sg = blk_next_sg(sg, sglist);
> -               sg_set_page(*sg, bvec->bv_page, len, offset);
> +               sg_set_page(*sg, page, len, offset);

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming Lei
