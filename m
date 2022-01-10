Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46298C433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 19:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243186AbiAJT0g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jan 2022 14:26:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243038AbiAJT0e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jan 2022 14:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641842793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yZ08XZ8idEJY7dNL/CjmIYmeW6lP9L5GGjs6T10cj9s=;
        b=K9ExXwrZtIhLRb0PGg4uVChsHUwconXfBhnWKXmkMvIioFg66Dch2VVv772u47a+g75rmt
        oYEIEAmEPPIZHeNx4BMNnN9m7EOnLq16E7hvjAV8/HtLPtNzuQqW9Sgm1/79wlRx7OWd5U
        b6hmSM1vn0xQvzVba4jYyXAc7c3pEbk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-Ygy16UhGPwaMYrs51C8O9Q-1; Mon, 10 Jan 2022 14:26:32 -0500
X-MC-Unique: Ygy16UhGPwaMYrs51C8O9Q-1
Received: by mail-qt1-f200.google.com with SMTP id cp8-20020a05622a420800b002c617119aafso2509516qtb.4
        for <linux-block@vger.kernel.org>; Mon, 10 Jan 2022 11:26:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yZ08XZ8idEJY7dNL/CjmIYmeW6lP9L5GGjs6T10cj9s=;
        b=tE817WvQmp7enG6EhsaSadCRGfd03cxGgRV3d4jQa3NRZtseoMy/GMNisOypFp7jHD
         tr+KQEJKzP/RHjBnGPm3go/czr9FSnU+v6JEgP9+Z6UixMoN87YPvN1h3x4GVrvDYTd6
         AqNMBDc8j63lXRBfDstmbaUG2GbqnM6dHYBgRgnH4+bC33zBGCI+6pkCztNQ1rDvCXR8
         Dbws5Y/WGJOBC7l/KPHYWd6gzC+z4pWyI5ozw0jFnf03Ps+ck6jfhPUyXLbJYzFupF+e
         tcTz3G3qicCwyBFkK2L4uHm/fV726Plpy9g8T9xi8UbdNlqDa9cOOoZzoYsXlSdtjhjg
         hiQA==
X-Gm-Message-State: AOAM532qR9073Hdw4n8nBitat1i0sZ+rGIXC32b7yXfQ/KlZvWkITXrx
        W2H8lWQVxThK5bd4e5ao/fMQm8Z0ACg8Muam4P1fGR4xd9jRr+hAvjHT32fneJIKlLdKp2GEZ9G
        1R0CWHj/qNZsUX4WI2GZ1Qw==
X-Received: by 2002:a05:620a:2015:: with SMTP id c21mr883060qka.383.1641842791595;
        Mon, 10 Jan 2022 11:26:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwHjM+t1bgDCUU60h+0opXhwpp98ZNY2fG6MTGB7kRs/0equHHPiJppDI0OZXqDMqD3jRW+w==
X-Received: by 2002:a05:620a:2015:: with SMTP id c21mr883046qka.383.1641842791400;
        Mon, 10 Jan 2022 11:26:31 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id o21sm5295158qta.89.2022.01.10.11.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 11:26:30 -0800 (PST)
Date:   Mon, 10 Jan 2022 14:26:29 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [PATCH 0/3] blk-mq/dm-rq: support BLK_MQ_F_BLOCKING for dm-rq
Message-ID: <YdyIZR4LkQTVjhWf@redhat.com>
References: <20211221141459.1368176-1-ming.lei@redhat.com>
 <YcH/E4JNag0QYYAa@infradead.org>
 <YcP4FMG9an5ReIiV@T590>
 <YcuB4K8P2d9WFb83@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcuB4K8P2d9WFb83@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 28 2021 at  4:30P -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Wed, Dec 22 2021 at 11:16P -0500,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > On Tue, Dec 21, 2021 at 08:21:39AM -0800, Christoph Hellwig wrote:
> > > On Tue, Dec 21, 2021 at 10:14:56PM +0800, Ming Lei wrote:
> > > > Hello,
> > > > 
> > > > dm-rq may be built on blk-mq device which marks BLK_MQ_F_BLOCKING, so
> > > > dm_mq_queue_rq() may become to sleep current context.
> > > > 
> > > > Fixes the issue by allowing dm-rq to set BLK_MQ_F_BLOCKING in case that
> > > > any underlying queue is marked as BLK_MQ_F_BLOCKING.
> > > > 
> > > > DM request queue is allocated before allocating tagset, this way is a
> > > > bit special, so we need to pre-allocate srcu payload, then use the queue
> > > > flag of QUEUE_FLAG_BLOCKING for locking dispatch.
> > > 
> > > What is the benefit over just forcing bio-based dm-mpath for these
> > > devices?
> > 
> > At least IO scheduler can't be used for bio based dm-mpath, also there should
> > be other drawbacks for bio based mpath and request mpath is often the default
> > option, maybe Mike has more input about bio vs request dm-mpath.
> 
> Yeah, people use request-based for IO scheduling and more capable path
> selectors. Imposing bio-based would be a pretty jarring workaround for 
> BLK_MQ_F_BLOCKING. request-based DM should properly support it.
> 
> I'm on vacation for the next week but will have a look at this
> patchset once I'm back.

I replied last week and hoped Jens would pick this patchset up after
my Reviewed-by of patch 3/3.

Christoph wasn't back though, so best to kick this thread again.

Thoughts on this patchset?

Thanks,
Mike

