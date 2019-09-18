Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E64C4CEC4
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 16:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7793F207FC
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 16:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="AJpEVX6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfIRQFw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:05:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50582 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbfIRQFv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Sep 2019 12:05:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id 5so785871wmg.0
        for <linux-block@vger.kernel.org>; Wed, 18 Sep 2019 09:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Af9Cdulw4q7srqZuhUQyn+hRAqzd94sDxeWyEO6s9c=;
        b=AJpEVX6leYrrW7IsKErz5RLmIxuGxxP8mwsBrP+jy+BTGbq9BzxlimqWvPNptBhNq9
         IZ6pnWFDfYR0U0zO33GKUh17x3l9ym4RAQHFbUsCRGkCNGZh/m9aSzDRmBzSCIS37dH+
         t36fVC+xAxPvUKypvowCEUyIc158xGNq5/e35H4qASO3pJocJvvdd6oesObnTygiU6bq
         9NxK/IPHRnJa8iJ8VmaTo3V3iytue79Bw8kin8GL5rtdr3aidSeFqdL4qhCgySY+O8zR
         HXY2PI3AYTAfkKjlAszEvq4TwOvXxgrgTB3I6QZv/IeUoFKOZmzrvIFZpfgbPymvFldG
         VFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Af9Cdulw4q7srqZuhUQyn+hRAqzd94sDxeWyEO6s9c=;
        b=kdAZ5+2MO4qzzT+CCzU6uvE4E4XVOuZMZxEuY+jWjXiC/rDCuFl8uFp2el2HJuL+Ee
         BCefbSJhyEdsOxOFCCVAgOYWAeUFnhHCW30DCjuXqwA++lNVkkBUWOXDFUp0AEdmA3Go
         AvxChnpLunWrKg0t5Cdb3j2AcMySzYW11jP+9BVQtotorIxibHTO0J+QF5MBYeGDB/RU
         yx34UwE0LMdp64lI/MLDYm0kMTTJrtSZFRK6J7xRyxoZuG69S2olM9vTA4diUUqjnHJC
         RiISMgwr6P37E67tXiWG8blfmQt2d57rpK6wsWwKeGGziol8Oh1slKWyPNEDVe7PSaBl
         c3fA==
X-Gm-Message-State: APjAAAXZIqEkmuu1MKCzctR6ZKw5LZauzI/YPNbeOYlCW0J0Yv1xkQKo
        cRJyJB/pa/bF+cr5tlN38eKgrkLEOpjskBtrySdEpw==
X-Google-Smtp-Source: APXvYqzS8d0FXM09U5a5BaQzms9ev4/1tLwd/tqmLh3O2bt4X/pOwkXpPuasVXAiPT6H2TbwMOWMLKOfk3ggYMvJpfU=
X-Received: by 2002:a1c:4384:: with SMTP id q126mr3879637wma.153.1568822749203;
 Wed, 18 Sep 2019 09:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org>
In-Reply-To: <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 18 Sep 2019 18:05:38 +0200
Message-ID: <CAMGffEm-HUWJ4hPc4kqX5-f7Y4CPKWnRswKVMTZgLqBfPy+WjQ@mail.gmail.com>
Subject: Re: [PATCH v4 17/25] ibnbd: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > +static void destroy_gen_disk(struct ibnbd_clt_dev *dev)
> > +{
> > +     del_gendisk(dev->gd);
>
> > +     /*
> > +      * Before marking queue as dying (blk_cleanup_queue() does that)
> > +      * we have to be sure that everything in-flight has gone.
> > +      * Blink with freeze/unfreeze.
> > +      */
> > +     blk_mq_freeze_queue(dev->queue);
> > +     blk_mq_unfreeze_queue(dev->queue);
>
> Please remove the above seven lines. blk_cleanup_queue() calls
> blk_set_queue_dying() and the second call in blk_set_queue_dying() is
> blk_freeze_queue_start().
>
It was an old bug we had in 2016, we retested with newer kernel like
4.14+, the bug is fixed,
I will remove the above seven lines.

Thanks
Jinpu
