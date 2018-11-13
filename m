Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7694C43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 11:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8DA2243E
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 11:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb1BkDrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8DA2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732488AbeKMVhf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:37:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34638 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732475AbeKMVhe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 16:37:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so12927608wre.1;
        Tue, 13 Nov 2018 03:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2CpLFe2KTL73T2p5ompiXP62kr9nKvYl/O1I/wllgc=;
        b=Qb1BkDrQguKkgZcN89Nhvr2GtoQPd9+SxkbneaitgxFRHpOk9P0KqgsFmpLngvVq3R
         0op6Xgt5YRivpN1No7zDBhf2ysUByHHvWmCDeTSz9Ck24DpBVt/X0OEGkh1VgnYRbZlg
         xNLxnnlMR1wDfcy8uKhhcFyk/IiPXgHcWqzkPryOQEtWJ/xLiuWYq2q2SPVCp4op1tFk
         6L7azWmke5e3wtAD9y7UrLx4sHpCotFcpxXV2LC05t/U84GuaoD3WlTi08Yr26fTsyhF
         mIl1xkQ0RqwL9bxgqKKWfjfe2web8vVH7p+S50g3RvWTRP/96bUcwLogbNCGQwWjlk5C
         1bEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2CpLFe2KTL73T2p5ompiXP62kr9nKvYl/O1I/wllgc=;
        b=ebtMMC/794zzZbJ51B3GsHdgGA2mnhrpHVcExXXsC3jk0LWj2fO8Wod1FQguwZj8uX
         +1b/HbuCXVXVavqHfW/s8MOwfHKsCkW7c3FZvQk3/xWmoZPl4DV2KTLCsMcuTB6O1+4w
         x1u2TB+nWrORqhctKFu7iZIHvt49NHEUpnaare32SMiiE/xAEWLS1G0VzAtTrpv9eUvW
         OxGMuoKbR2qgNdEUlXrgPFYfNKpiezAEJW2ti8vUjQMxRgGQ1GzWdxRg407UqAtIAT2g
         4FcW/pEpTertA19wtW9/mqp2B4DRi5J+AD+vga5rAxR+IrDbGa3+gBmDFQ/jwS6AtPab
         QOOA==
X-Gm-Message-State: AGRZ1gJoUapFtX+F2zvPgXyap24TkeXtUFBGrxJY2eBGqkxAWHya3iut
        HcaMOgTr/rx66tGh/IKW94bN5XNRVn+AG/vqgtLi1FBtCSw=
X-Google-Smtp-Source: AJdET5doI8olLiOq8ERHEq0Hffj9Xy3ziIBfhX8yBLa7shs9ZJ4+vYnT9B/ouklXcAdJ28YshqJg5yGJX+JbVmOLnbY=
X-Received: by 2002:a5d:4b05:: with SMTP id v5-v6mr4540203wrq.5.1542109188889;
 Tue, 13 Nov 2018 03:39:48 -0800 (PST)
MIME-Version: 1.0
References: <20181109162610.18981-1-ming.lei@redhat.com> <20181109162610.18981-14-ming.lei@redhat.com>
In-Reply-To: <20181109162610.18981-14-ming.lei@redhat.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 13 Nov 2018 19:39:36 +0800
Message-ID: <CACVXFVM9kdz5+eyTuCf=5MuZdQxCMVW1tx6s0GLqugoeBF8jOA@mail.gmail.com>
Subject: Re: [PATCH V8 13/18] block: enable multipage bvecs
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 10, 2018 at 12:29 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> This patch pulls the trigger for multi-page bvecs.
>
> Now any request queue which supports queue cluster will see multi-page
> bvecs.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/bio.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index 6486722d4d4b..b2ce42e89076 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -767,12 +767,23 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
>
>         if (bio->bi_vcnt > 0) {
>                 struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> -
> -               if (page == bv->bv_page && off == bv->bv_offset + bv->bv_len) {
> -                       bv->bv_len += len;
> -                       bio->bi_iter.bi_size += len;
> -                       return true;
> -               }
> +               struct request_queue *q = NULL;
> +
> +               if (page == bv->bv_page && off == bv->bv_offset + bv->bv_len)
> +                       goto merge;
> +
> +               if (bio->bi_disk)
> +                       q = bio->bi_disk->queue;
> +
> +               /* disable multi-page bvec too if cluster isn't enabled */
> +               if (!q || !blk_queue_cluster(q) ||
> +                   (page_to_phys(bv->bv_page) + bv->bv_offset + bv->bv_len !=
> +                    page_to_phys(page) + off))
> +                       return false;
> + merge:
> +               bv->bv_len += len;
> +               bio->bi_iter.bi_size += len;
> +               return true;
>         }
>         return false;
>  }

This patch caused regression on iomap & xfs for sub-pagesize io vec, which
has been addressed in the following patch:

https://github.com/ming1/linux/commit/46ea6acb175fbc68f98f645f14d77b1b4178e593

Because iomap needs to know if the merged page is one freshly new page, however
__bio_try_merge_page() won't tell us if that is true.

I will post out V9 once the new change passes my tests.

Thanks,
Ming Lei
