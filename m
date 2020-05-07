Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AECBC38A2A
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 12:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3072F2082E
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 12:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcyjC2vu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgEGM65 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 08:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbgEGM65 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 08:58:57 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A5FC05BD43
        for <linux-block@vger.kernel.org>; Thu,  7 May 2020 05:58:57 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b6so108346qkh.11
        for <linux-block@vger.kernel.org>; Thu, 07 May 2020 05:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OwnEBzVwDcojjtYHnHImbVqq41waqshUN9/b/o5AzuY=;
        b=lcyjC2vuK078yyHvn1/rju0xFuTTuwECrmXq6qh1HZBNp99f+cTplWI88gxI0TiPXK
         K/bPKcSM4lJMatxZXvtsGJPYSxxQteP++7Yu4u1KgYNQ+feAWyB8ou7OkrlLNKYb75jO
         RzrcK0oCzF0CMhcId9580w2zG9tpvLxsj9dW98o/BTFtIf6o304wd9U5JBC9HW/Ohb+H
         JzDr6PAWV9SxrdLObz9nzoDzUlFlHxEqcc/G4I1gqzIw3DtWU6f7imuDWOVpsyFa92bM
         sRdMufGuXxqNy5qjm380ED2HPd2C0dBa0gQy7/iTDluJ3rCv+iE9c0/evO8f04TEwsnU
         LzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OwnEBzVwDcojjtYHnHImbVqq41waqshUN9/b/o5AzuY=;
        b=AqvGieiVkfpCjDJ5lBY/TG2G4rxOOH+SQRllAqB/gGTjgO6aSG9Ec/0v82QDILyhjc
         cJAjuxqet6Gs7NqGyNf7L4sfR+9q68usDi6f4nIQy75xtAG5wa+CoZpjPdcMbWb8/dxU
         rFsLAo6e5Zt0tM7x494IrbmytPli+0DlyfleRWxaFT0BPWgf2rTzeQF5D6Uq7PeQWmbz
         VaVqN3irXCOmKEwr46WYZnnmIflND4POGR4Jh+b1qPWpqXNOIG0AXkrCt9Iv+GAEit3D
         9RuYYgehgNhNvgS8EWy9CTEYf7BqXQyQzIiD4QTyGI1I50eDETeLsw84+pQxE1CaIiz4
         4t8w==
X-Gm-Message-State: AGi0PuZ5zf+ZU7hCLYHPUjrMWO7okASp3z1ElblJ2v5Lo1J+LXZwI/v0
        ejLgv9RGBc7itI7pCSvi8uzh1V9rLBG6kcR56l8=
X-Google-Smtp-Source: APiQypIJdT2tdgfq3eB2eq1A7Y3notP0xAkUKLwbA/Gnqnf7VX7QQk4YzHDcSdEd9cYcrPmmeLROM3K2SpGCtVFUuHM=
X-Received: by 2002:a37:4d04:: with SMTP id a4mr15051209qkb.222.1588856336537;
 Thu, 07 May 2020 05:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588660550.git.zhangweiping@didiglobal.com>
 <7eaff8fdfc394ecb686abb186564d9e1aebcf9ae.1588660550.git.zhangweiping@didiglobal.com>
 <20200507061141.GC23530@infradead.org>
In-Reply-To: <20200507061141.GC23530@infradead.org>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Thu, 7 May 2020 20:59:06 +0800
Message-ID: <CAA70yB52KROUWtACb8si2pKdYvshQp-DHhKjL-X1++0cMiHVaQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] block: rename __blk_mq_alloc_rq_map
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, tom.leiming@gmail.com,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 7, 2020 at 2:12 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, May 05, 2020 at 02:45:58PM +0800, Weiping Zhang wrote:
> > rename __blk_mq_alloc_rq_map to __blk_mq_alloc_map_and_request,
> > actually it alloc both map and request, make function name
> > align with function.
> >
> > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > ---
> >  block/blk-mq.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index c6ba94cba17d..02af33f56daa 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2473,7 +2473,7 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
> >       }
> >  }
> >
> > -static bool __blk_mq_alloc_rq_map(struct blk_mq_tag_set *set, int hctx_idx)
> > +static bool __blk_mq_alloc_map_and_request(struct blk_mq_tag_set *set, int hctx_idx)
>
> Please fix the > 80 char line here.
OK, fix in v6.

Thanks
