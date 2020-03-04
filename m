Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9293DC3F2D1
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 11:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64083214D8
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 11:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="iejCa/9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgCDLWG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:22:06 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36572 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDLWG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 06:22:06 -0500
Received: by mail-io1-f67.google.com with SMTP id d15so1984033iog.3
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2020 03:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zd6EHh+Xv9ufD5cmWFroJXikeJWoDYrEYf9+1i38fSg=;
        b=iejCa/9cMUZhtr0AIkZB5yhas1R9TkZWtZeYbEL0vk5oZQxNNxr9wQIVT+0Q6OrVpy
         Eff/hB8i6MzX0y2a3kd5t46LI9PsNTUEYFg4ah9dw0mgfh4IuPIiVTKpRXgtgTA2NCP3
         jxKtKCY/CWBBBekZ+qzWHDQl57pRJEAPi/EPKCNcL/tUg9HFDQc0zjknVBxpc6MzXbos
         C0pj3Q6R/maREnO8weLahhVdKVVO3OxP/h9omsVHUNwE55XhCQhc49jFOBB6m+O0a0s6
         Ej5/xHb7N2ZHDdFx5dpkFSeTU5hMdB/uSskWLRCIfpstCS2E64MbFmT0fmphzoSy5RbT
         E2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zd6EHh+Xv9ufD5cmWFroJXikeJWoDYrEYf9+1i38fSg=;
        b=hfWssV5BCn/nCT098SdQlkFKSlYDvgNy/NJFUp3Ds01x4efjyZr7BS9jpPru/ETVIe
         6637vPe/Shq1+5qwZs/4l1zqgaFYC2vytfJxua3whQDU0iZkx8HccYbwajwQV7rL6xZK
         Rc2/6J+ZOPIrc0X5uDBpst2QlrJn60B7uXQBovGIvoTfLLg9K5wjv68EWOkM6NaniPSC
         8T6wSXAAVEklDs6czSBOBlZREN4TN7FVoswDGsGfUqV673rYkV0nU/1VplaLcusvDc4v
         6FAc7UZLzr8u6V8aS1G9VTUgsUAa/jn4MabL1UsZAZkcWmFej09bQG+igu5kQZwN+fEc
         diqg==
X-Gm-Message-State: ANhLgQ3V2hu88vDQqv6nayR8Q2BLW6kOSj74CRAMkItt4ztygoD2G6j6
        TYVcXZGJqIuJ7o8LDi23TOmeq4Pl4algY4XNh/0cfA==
X-Google-Smtp-Source: ADFU+vs6pyVQKZY2alGuHv76hcwShmYLnruT8s3fRJrGGedN1GLZ++agFzo20ZUPfC/YHoa9O6Ub4hNqaZQyBAWJOq8=
X-Received: by 2002:a02:3b24:: with SMTP id c36mr2228568jaa.23.1583320924768;
 Wed, 04 Mar 2020 03:22:04 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-5-jinpuwang@gmail.com>
 <20200303095713.GK121803@unreal>
In-Reply-To: <20200303095713.GK121803@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 4 Mar 2020 12:21:52 +0100
Message-ID: <CAMGffEkf2i2cLxNCOep7P=R69dn=gSD=HEkDR4atXaQ=kmLBqw@mail.gmail.com>
Subject: Re: [PATCH v9 04/25] RDMA/rtrs: core: lib functions shared between
 client and server modules
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 3, 2020 at 10:57 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Feb 21, 2020 at 11:47:00AM +0100, Jack Wang wrote:
> > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> >
> > This is a set of library functions existing as a rtrs-core module,
> > used by client and server modules.
> >
> > Mainly these functions wrap IB and RDMA calls and provide a bit higher
> > abstraction for implementing of RTRS protocol on client or server
> > sides.
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs.c | 594 +++++++++++++++++++++++++++++
> >  1 file changed, 594 insertions(+)
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.c
>
> <...>
>
> > +
> > +static void dev_free(struct kref *ref)
> > +{
> > +     struct rtrs_rdma_dev_pd *pool;
> > +     struct rtrs_ib_dev *dev;
> > +
> > +     dev = container_of(ref, typeof(*dev), ref);
> > +     pool = dev->pool;
> > +
> > +     mutex_lock(&pool->mutex);
> > +     list_del(&dev->entry);
> > +     mutex_unlock(&pool->mutex);
> > +
> > +     if (pool->ops && pool->ops->deinit)
> > +             pool->ops->deinit(dev);
> > +
> > +     ib_dealloc_pd(dev->ib_pd);
> > +
> > +     if (pool->ops && pool->ops->free)
> > +             pool->ops->free(dev);
> > +     else
> > +             kfree(dev);
> > +}
> > +
> > +int rtrs_ib_dev_put(struct rtrs_ib_dev *dev)
> > +{
> > +     return kref_put(&dev->ref, dev_free);
> > +}
> > +EXPORT_SYMBOL(rtrs_ib_dev_put);
> > +
> > +static int rtrs_ib_dev_get(struct rtrs_ib_dev *dev)
> > +{
> > +     return kref_get_unless_zero(&dev->ref);
> > +}
> > +
> > +struct rtrs_ib_dev *
> > +rtrs_ib_dev_find_or_add(struct ib_device *ib_dev,
> > +                      struct rtrs_rdma_dev_pd *pool)
> > +{
> > +     struct rtrs_ib_dev *dev;
> > +
> > +     mutex_lock(&pool->mutex);
>
> The scope of this mutex is unclear, you protected everything here with
> this mutex, but in dev_free() you guarded list_del() only.

Looks the mutex only need to guard poll->list, I will run some tests to verify.

Thanks!
