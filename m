Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C86C433EF
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 16:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349828AbiAKQPS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 11:15:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349852AbiAKQPR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 11:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641917715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CC1i5tpLMiW1d6bdv7f77XtvYY1n5qxfZPIldyU34eI=;
        b=XIReghv8xVgycXV9Qno6O5jm+U2gsnwabtHDxf7WRmRcL6IFWioFNdS51qhbiu/8qq0QRb
        71/yfdhFjVlSzTpw3NKtyk+Xz5pwsXSUiCS9hELGHdAbrwtkOkHbdeZYjzfAoFD5sie1f0
        9lF3KaG4pGd22RqAjUkqHktV9TBYjqs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-kNNscN0xOBeJrPuVjgjEEA-1; Tue, 11 Jan 2022 11:15:14 -0500
X-MC-Unique: kNNscN0xOBeJrPuVjgjEEA-1
Received: by mail-qv1-f71.google.com with SMTP id o14-20020ad45c8e000000b004112b52fc2cso16587328qvh.6
        for <linux-block@vger.kernel.org>; Tue, 11 Jan 2022 08:15:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CC1i5tpLMiW1d6bdv7f77XtvYY1n5qxfZPIldyU34eI=;
        b=tMP/HWu+FymPihuKsUx8t49NK0KbLj0sjZAzZ4zWsRqFJUDUZwalIwG9baDbWnP1Nh
         idTnOLEy8RQ7SgfmmCGm3hGxkQqenMAOpg0BUpA1P3V9Lb9pGiXH+NMF2SXQn0m7Brcl
         +TjW28ibyrvkzThxtdXl/tsJIb4deFknDrJ7Dlr/ipp55LeplJY5LNntLZtYCS+M+FeY
         Ri7JC88gRXLjkFI1syot+qedK91wJx0ml+nfGtT8NuIX+0SZK0gy6MF/Bj7bXse1mduX
         3DfT2O7w3UTa/pm852zJgWgTAtx/qI1wMmRnfJPOM+rSrWBTt4HzBH67x6Q7afzlTzHF
         AlIw==
X-Gm-Message-State: AOAM5335XJPKKucjOztSni5nx2VjiZJZcHUBxHZr3R90riFsfRoQK5rW
        FkqPKUXjGcLCNBQ4bKFd4RHtVjLszZptgsnCMXMTA/pbXrANVe8ciaQOT32tsnO+H9iWoGnB2p/
        9Cc1fu4RH/qGoMwjpg8zqXA==
X-Received: by 2002:a05:622a:13ce:: with SMTP id p14mr4232674qtk.562.1641917712074;
        Tue, 11 Jan 2022 08:15:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9rn8Dc2sri+sXStNgRwr2Ijq9qi5yvFpyULm8k4zkoftteb5wEjtKYGDbnDA0U+OKT8LYwQ==
X-Received: by 2002:a05:622a:13ce:: with SMTP id p14mr4232630qtk.562.1641917711671;
        Tue, 11 Jan 2022 08:15:11 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id j13sm7195820qta.76.2022.01.11.08.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 08:15:11 -0800 (PST)
Date:   Tue, 11 Jan 2022 11:15:09 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3] blk-mq/dm-rq: support BLK_MQ_F_BLOCKING for dm-rq
Message-ID: <Yd2tDWuP+aT3Hxbj@redhat.com>
References: <20211221141459.1368176-1-ming.lei@redhat.com>
 <YcH/E4JNag0QYYAa@infradead.org>
 <YcP4FMG9an5ReIiV@T590>
 <YcuB4K8P2d9WFb83@redhat.com>
 <Yd1BFpYTBlQSPReW@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd1BFpYTBlQSPReW@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 11 2022 at  3:34P -0500,
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Dec 28, 2021 at 04:30:08PM -0500, Mike Snitzer wrote:
> > Yeah, people use request-based for IO scheduling and more capable path
> > selectors. Imposing bio-based would be a pretty jarring workaround for 
> > BLK_MQ_F_BLOCKING. request-based DM should properly support it.
> 
> Given that nvme-tcp is the only blocking driver that has multipath
> driver that driver explicitly does not intend to support dm-multipath
> I'm absolutely against adding block layer cruft for this particular
> use case.

this diffstat amounts to what you call "cruft":

 block/blk-core.c       |  2 +-
 block/blk-mq.c         |  6 +++---
 block/blk-mq.h         |  2 +-
 block/blk-sysfs.c      |  2 +-
 block/genhd.c          |  5 +++--
 drivers/md/dm-rq.c     |  5 ++++-
 drivers/md/dm-rq.h     |  3 ++-
 drivers/md/dm-table.c  | 14 ++++++++++++++
 drivers/md/dm.c        |  5 +++--
 drivers/md/dm.h        |  1 +
 include/linux/blkdev.h |  5 +++--
 include/linux/genhd.h  | 12 ++++++++----
 12 files changed, 44 insertions(+), 18 deletions(-)

> SCSI even has this:
> 
> 	        /*
> 		 * SCSI never enables blk-mq's BLK_MQ_F_BLOCKING flag so
> 		 * calling synchronize_rcu() once is enough.
> 		 */
> 		WARN_ON_ONCE(shost->tag_set.flags & BLK_MQ_F_BLOCKING);
> 

Round and round we go.. Pretty tired of this.

You are perfectly fine with incrementally compromising request-based
DM's ability to evolve as block core does.

Seriously, this patchset shouldn't warrant bickering:
https://patchwork.kernel.org/project/dm-devel/list/?series=598823

Jens, this incremental weakening of what it is that DM is allowed to
do is not something I can continue to work with (nor should Ming's or
others' contributions be rejected for such reasons).

This tribal war needs to stop.

Mike

