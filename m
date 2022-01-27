Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838A8C433EF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 14:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242480AbiA0Oif (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 09:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiA0Oif (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 09:38:35 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173FEC061714
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 06:38:35 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so7724501pju.2
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 06:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5OC6d3lGaiCactmd/xMDmrnP0MikjxAmGKwgY6B8rNA=;
        b=BRy4W+xYso6FWfmNoAQig2ZnwCU+Pqrczm0lNLitMBWjXPxZzaT25dQCnSvtDuPWEW
         mSXC4yFdQrnzSuc0QlaVDDXjXbc3IU7QzaBPs5iVma0PKtjWWmfSGisU+r5fRLK33NKF
         aIrfYxdqQlN6eJ0rNPsqEJwtmi4JkPHFo6T8orNS23sn0lGKJMcxu00urRsT4Xuh7vLU
         lTvuA/At8LN3g1iHHKv7avFwjgtkdjQoHfhSgpktyzfI4AhotBsqEuCMsdKhcqrhyTSK
         r74gA21UDb45f5+ZppsGpR9AGK/lQjmDfhQmZXP/1heUU1aIixqhe3t1uqAhJiWH6Qn7
         qeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OC6d3lGaiCactmd/xMDmrnP0MikjxAmGKwgY6B8rNA=;
        b=fvPikKDnfEzsKEdkLcs9wIwT1dyLnGE5Olu0rLekLYNJSvWD2BYHZC1ii5rJi44xwN
         U4QeEnUTtCOUh3mWxytunM6xDdw4MMpKY/NErazJ8ZSAXDMd6yNiHQ30mG1JyY7NnBO/
         QZ9sT0VvpBTUHj3P8sKXtJD+Lpc4lWHVGlNOUpxA8E5KLvojBUUG4Zye7sXZB83JszVC
         LSYN16ONF0kDX/pzPN20ITaQTNQ4QpubsZxsStc/0dKLXtRhd99D7qLU+m+oqW2J/k9O
         8Gyo6waGgYEOX1hVz5OE2PZB4SnEuTX+plHL09g+drym5YxD0cDgkD9rEUfbe6e5M9Oj
         SEzQ==
X-Gm-Message-State: AOAM530jplv9TxWN6W7QFeyhNlBCgZo+HJHNgckpCr+cfySZFDl1lfWi
        QhJ5Dk6ixGlO34OYrpwCuTDVZlJDD2/moNJYOZ8=
X-Google-Smtp-Source: ABdhPJybFXXY9mmFQkfuJzQBLrraeIouIJJp9xPpVJ/3yElzmYBK/hQYvnyadQ53YF4fstj50Vni0rIpjiDgMzuCKI8=
X-Received: by 2002:a17:902:c652:: with SMTP id s18mr3688054pls.1.1643294314524;
 Thu, 27 Jan 2022 06:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20220127082536.7243-1-joshi.k@samsung.com> <CGME20220127083034epcas5p4aaafaf1f40c21a383e985d6f6568cbef@epcas5p4.samsung.com>
 <20220127082536.7243-2-joshi.k@samsung.com> <20220127092746.GA14431@lst.de>
In-Reply-To: <20220127092746.GA14431@lst.de>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Thu, 27 Jan 2022 20:08:08 +0530
Message-ID: <CA+1E3r+ohVCy4dTPwYLmPCsH6y6R2zg0GGv_-NQybP83Y1yfLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] block: introduce and export blk_rq_map_user_vec
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kanchan Joshi <joshi.k@samsung.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 27, 2022 at 2:57 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jan 27, 2022 at 01:55:35PM +0530, Kanchan Joshi wrote:
> > Similiar to blk_rq_map_user except that it operates on iovec.
> > This is a prep patch.
> >
> > Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> > Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> > ---
> >  block/blk-map.c        | 19 +++++++++++++++++++
> >  include/linux/blk-mq.h |  2 ++
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/block/blk-map.c b/block/blk-map.c
> > index 4526adde0156..7fe45df3e580 100644
> > --- a/block/blk-map.c
> > +++ b/block/blk-map.c
> > @@ -577,6 +577,25 @@ int blk_rq_map_user(struct request_queue *q, struct request *rq,
> >  }
> >  EXPORT_SYMBOL(blk_rq_map_user);
> >
> > +int blk_rq_map_user_vec(struct request_queue *q, struct request *rq,
> > +                 struct rq_map_data *map_data, void __user *uvec,
> > +                 unsigned long nr_vecs, gfp_t gfp_mask)
> > +{
> > +     struct iovec fast_iov[UIO_FASTIOV];
> > +     struct iovec *iov = fast_iov;
> > +     struct iov_iter iter;
> > +     int ret;
> > +
> > +     ret = import_iovec(rq_data_dir(rq), uvec, nr_vecs, UIO_FASTIOV, &iov, &iter);
> > +     if (unlikely(ret < 0))
> > +             return ret;
> > +     ret = blk_rq_map_user_iov(q, rq, NULL, &iter, gfp_mask);
> > +     kfree(iov);
> > +
> > +     return ret;
>
> I see very little point in adding this function vs just open coding it.

Fine, I will kill this and open-code in nvme instead.


-- 
Kanchan
