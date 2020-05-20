Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48D5C433E0
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 10:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832CB2075F
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 10:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="hsxRs5C5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgETKEl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 06:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETKEk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 06:04:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D11C061A0E
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 03:04:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i15so2476715wrx.10
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=inIn2ONjibCnSjCghxYnKq2rJ8+ESmy4DRNsddh+5yQ=;
        b=hsxRs5C5YKYa0yGhhIMT8XTt4BoSeJuvqv1ep1IHg83tnHnWPY4qC0Ary05LJN/ytf
         MK+6DkmMTO9O0cs/6rjB0kxORhU0VilWrccz3QYeTs8o6uBYGgvisL5HVrzJNsF0M0Cm
         khtyZ8qYv/5VG54vdTkCJbphGw5c5EMeKbH8Ro+648vM+QF8RiY0AgPDyr7AgfxuCYYJ
         iNFQpZnN2WnqBrOWTtdai6yvUPzCjS+38ty6JN2Nw/wWgvgVcVxN43DCqKbos6f6w2Un
         EHqpC/elSDJHwrCkFAHHxsWWXCKf/owGUskeqyzFrGaTxyYkV1bHxnKz/elmGJiVfDEj
         DjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=inIn2ONjibCnSjCghxYnKq2rJ8+ESmy4DRNsddh+5yQ=;
        b=NK5rPsjX68p73bKQKlUtEjx7WMS7fmNHBzUJ3UdsnOyQ8XDlGl/FyELKdGwasn4rls
         HANRXGgpsgahaONttoNRJFwIfsSnwhx7OigEkbXyoQD7AdOIaCj0Mrf7tGF+4dX3v2TQ
         MJ8zqo3S6U4oMGVilY+M1/4G5kHCGY9sEkIi+F18a1Jt/wUaFUhnu/HASffneN/mQqeM
         SfAB4yd9G23zrwAI7IvDPCcnEKnCxGtcw0+nPEtZ0NvCasvtrkWliLpGkM+x/zdTs3Dr
         o3HykrlVirMundVETQf3yGYSGA+5D73cusg800YabHs3/hNR9TGCvpYhTqXKM0j8fVM/
         k1Tw==
X-Gm-Message-State: AOAM532ARLWHKmmlJaNwWGP7UnGc4xshrqYJ1gsfnmNlbF3+2SZsqYIb
        Xcgj7cVYkajp7Fv7xRLZVdOOHyu5tCmljikvtAJT
X-Google-Smtp-Source: ABdhPJwVhiOqJ6pZXZNbYxT2v3Gmlpbge7+a6xMaVWYDFGQk3afXhXJbIz+s1l5P0HUngJK5K88CcaSWqMTubKH3ZVc=
X-Received: by 2002:a5d:6705:: with SMTP id o5mr3608109wru.426.1589969078863;
 Wed, 20 May 2020 03:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200519112936.928185-1-danil.kipnis@cloud.ionos.com>
 <76b6b987-4f63-2487-7fbe-a1d9c2f06b76@acm.org> <20200519233847.GC12656@ziepe.ca>
In-Reply-To: <20200519233847.GC12656@ziepe.ca>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 20 May 2020 12:04:28 +0200
Message-ID: <CAHg0Huy3JmK=iFSrEFhbv==KFJusNr6Z+=H7Xwf+fHEZU2pYmQ@mail.gmail.com>
Subject: Re: [PATCH v2] rtrs-clt: silence kbuild test inconsistent intenting
 smatch warning
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 20, 2020 at 1:38 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, May 19, 2020 at 07:29:15AM -0700, Bart Van Assche wrote:
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > index 468fdd0d8713..8dfa56dc32bc 100644
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -727,18 +727,13 @@ struct path_it {
> >       struct rtrs_clt_sess *(*next_path)(struct path_it *it);
> >  };
> >
> > -#define do_each_path(path, clt, it) {                                        \
> > -     path_it_init(it, clt);                                          \
> > -     rcu_read_lock();                                                \
> > -     for ((it)->i = 0; ((path) = ((it)->next_path)(it)) &&           \
> > -                       (it)->i < (it)->clt->paths_num;               \
> > +#define for_each_path(path, clt, it)                                 \
> > +     for (path_it_init((it), (clt)), rcu_read_lock(), (it)->i = 0;   \
> > +          (((path) = ((it)->next_path)(it)) &&                       \
> > +           (it)->i < (it)->clt->paths_num) ||                        \
> > +                  (path_it_deinit(it), rcu_read_unlock(), 0);        \
> >            (it)->i++)
>
> That is nicer, even better to write it with some inlines..

You mean pass a callback to an inline function that would iterate?
>
> Jason
