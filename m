Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9285C3DA7D
	for <linux-block@archiver.kernel.org>; Thu, 29 Dec 2022 08:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiL2ISr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Dec 2022 03:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiL2ISF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Dec 2022 03:18:05 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA1813DD7
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 00:17:36 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s5so25763954edc.12
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 00:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7n+B+X0KvL5FYpt4R5yWJ/ag0L0NLxa0tbY9qucKwuI=;
        b=aM/Ttwb0xqobbPsfNShnECgwZZ0RVTZPBATDxWKlrmgoYc131+i6w0GKSBj1PdVklm
         gbChCXaQ6kiGtiwXqjToSpSW7zNn+YGWX5SWfwTFn1L5KuHM7Q7U66SHcHp9Wg2KrYUe
         zxjDtJAp6e++CJq9Z/mH0g4XiyUZ6LJVU+4AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7n+B+X0KvL5FYpt4R5yWJ/ag0L0NLxa0tbY9qucKwuI=;
        b=Dzeb3mJBUESaRx2DEMBUQWbuo8yKN5nUk6qzG/aC9U2edzJi4Skkiq57SNuGqIsW02
         9zcDxJ1ztQmGPeryY+LoNNs+k9HwpEtFjtNqAhw/XS6TsNNJeqQpfohay1+GA5iiU3UN
         2hqwyypwTbbl+UpFr5xq7MeCWRZoos8GgVs/O0Q9IbMi5wPZ6BsIW8dj56QvCPieBUg2
         16GGi/B+CT3l4wCYeVZcpNz5Bcvb2sw0nfwSJhVqmalBTTZXFmV8PlV90/y4i+fShB8r
         ELgAAirkBvfAW1DIzIqJn7vRfn5tNPwuMy7c+/n+b03bBXU1RgHq1SG8TlOe4RxCYdVD
         MR3A==
X-Gm-Message-State: AFqh2kqEfdJLaV7Ttu+tcaVPISd86Gzj+LPd8zLrgKp3d2jfhVa93Rf9
        mzbG3XZsCVylZb6ZzTtwWkGjths9Jbh/Co5x+eJNXw==
X-Google-Smtp-Source: AMrXdXulwl3zEgOGWwmMivflDb4UfyGNGI7lU4m/aeAvt/3L5Hf+inrJtG+WSFp0FPQl5mpy0l5FjfKOF5TBfRVSOU8=
X-Received: by 2002:a50:fe17:0:b0:487:e554:31e8 with SMTP id
 f23-20020a50fe17000000b00487e55431e8mr670416edt.353.1672301854647; Thu, 29
 Dec 2022 00:17:34 -0800 (PST)
MIME-Version: 1.0
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-2-sarthakkukreti@google.com> <Yy3NeY02zEMLTdsa@redhat.com>
In-Reply-To: <Yy3NeY02zEMLTdsa@redhat.com>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Thu, 29 Dec 2022 00:17:23 -0800
Message-ID: <CAG9=OMO=j=kOGX4hnYSt490wURF_a8ZM5MctKpeV2TaiKS8RhQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/8] block: Introduce provisioning primitives
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 23, 2022 at 8:15 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> On Thu, Sep 15 2022 at 12:48P -0400,
> Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:
>
> > From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> >
> > Introduce block request REQ_OP_PROVISION. The intent of this request
> > is to request underlying storage to preallocate disk space for the given
> > block range. Block device that support this capability will export
> > a provision limit within their request queues.
> >
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  block/blk-core.c          |  5 ++++
> >  block/blk-lib.c           | 55 +++++++++++++++++++++++++++++++++++++++
> >  block/blk-merge.c         | 17 ++++++++++++
> >  block/blk-settings.c      | 19 ++++++++++++++
> >  block/blk-sysfs.c         |  8 ++++++
> >  block/bounce.c            |  1 +
> >  include/linux/bio.h       |  6 +++--
> >  include/linux/blk_types.h |  5 +++-
> >  include/linux/blkdev.h    | 16 ++++++++++++
> >  9 files changed, 129 insertions(+), 3 deletions(-)
> >
> > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > index 8bb9eef5310e..be79ad68b330 100644
> > --- a/block/blk-settings.c
> > +++ b/block/blk-settings.c
> > @@ -57,6 +57,7 @@ void blk_set_default_limits(struct queue_limits *lim)
> >       lim->misaligned = 0;
> >       lim->zoned = BLK_ZONED_NONE;
> >       lim->zone_write_granularity = 0;
> > +     lim->max_provision_sectors = 0;
> >  }
> >  EXPORT_SYMBOL(blk_set_default_limits);
> >
> > @@ -81,6 +82,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
> >       lim->max_dev_sectors = UINT_MAX;
> >       lim->max_write_zeroes_sectors = UINT_MAX;
> >       lim->max_zone_append_sectors = UINT_MAX;
> > +     lim->max_provision_sectors = UINT_MAX;
> >  }
> >  EXPORT_SYMBOL(blk_set_stacking_limits);
> >
>
> Please work through the blk_stack_limits() implementation too (simple
> min_not_zero?).
>
(Sorry, I might have misunderstood what you meant) Doesn't the chunk
at L572 handle this:


@@ -572,6 +588,9 @@ int blk_stack_limits(struct queue_limits *t,
struct queue_limits *b,
        t->max_segment_size = min_not_zero(t->max_segment_size,
                                           b->max_segment_size);

+       t->max_provision_sectors = min_not_zero(t->max_provision_sectors,
+                                               b->max_provision_sectors);
+
        t->misaligned |= b->misaligned;
