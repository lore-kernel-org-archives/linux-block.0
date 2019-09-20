Return-Path: <SRS0=iom0=XP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616DEC4CEC9
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 08:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5392190F
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 08:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Qz6XxsGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408216AbfITIaK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Sep 2019 04:30:10 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39518 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405437AbfITIaK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Sep 2019 04:30:10 -0400
Received: by mail-io1-f66.google.com with SMTP id a1so14317052ioc.6
        for <linux-block@vger.kernel.org>; Fri, 20 Sep 2019 01:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cfWuNy3xibIXl+j47fWfRq14jBulXO0LL+BHoT7mRk=;
        b=Qz6XxsGb+h6rTjluc/X3rSMVnQG6U9CcXmMFEcVOa8mcPyLF5AvYN3M9I2CU1+wGYC
         N1zFWY2CxCk4mCYlXYMC5WePGdbKo+rvjJSvOUspoZ20pbnQjVMU4U2j7pAztrT0MD2d
         eGva8Fjf47rJIosmdxDWRivxQYXPkhWotpYJc19FThOcWr3GbisX0E3dzk0PjhmKv0bi
         F4yP0YAKCOyX7JQ55HoSbmZwfdhkxP2nYYm4/zfALhu9RIL+dnru8oBGidj6znEIidt5
         dsvbg2k69UqEp1eJfXGCvmHhR/+2yv7HLpTC6Pf2eKt2wmMkG3e28Dzb4lc5S1RuuKgz
         H4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cfWuNy3xibIXl+j47fWfRq14jBulXO0LL+BHoT7mRk=;
        b=USrjpq05sI5Dd9/38D6msyERNrMBqnhvhHmiti6wBcMookeCNrwGfmfo17KDvUJ9u/
         JQIB0dM1SL8AAD9igrqbz1zSmLDZJEG7qss9alp1lS00Djkoh1ooYuNlyiMAleYTY6q5
         I1GsfCU0ZLnafQrjFUCZwMyUFlsuAEp9c7OugpTaPGc67PRzVr4tF9Cr8WrUB7/GwwUe
         OWh6kLE6+cpVLmNzddT6KsQJ4A8K/8kKIYokBb57Ri8yseL4BRobMDi0ZO6nMdxg7rUH
         A19BhWK8gi6dmHRZMAp03ZsJaMMNMK01KPKLBEVvCyNzbQCwTSNfbY8Dayhb7LOOZcQr
         Pt9w==
X-Gm-Message-State: APjAAAUtts0S9bdgHiiZCi/B/hBmt0HrDazxR/91mpILlAfai+l7pwSN
        IKLJz9TkCC+m4ucJHv5smBKT9DnC5yZ30yipPqj2
X-Google-Smtp-Source: APXvYqyYPlrTcpvJV+pdTyQWm2sPaWvfIN3T+LGpf3psCx84ynJyhnC4v76Nkcme3sq5h87l0rGSzvrIeJnGIp9Vvb8=
X-Received: by 2002:a6b:db0a:: with SMTP id t10mr18421833ioc.300.1568968209207;
 Fri, 20 Sep 2019 01:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org> <CAHg0HuwzHnzPQAqjtYFTZb7BhzFagJ0NJ=pW=VkTqn5HML-0Vw@mail.gmail.com>
 <5c5ff7df-2cce-ec26-7893-55911e4d8595@acm.org> <CAHg0HuwFTVsCNHbiXW20P6hQ3c-P_p5tB6dYKtOW=_euWEvLnA@mail.gmail.com>
 <CAHg0HuzQOH4ZCe+v-GHu8jOYm-wUbh1fFRK75Muq+DPpQGAH8A@mail.gmail.com> <6f677d56-82b3-a321-f338-cbf8ff4e83eb@acm.org>
In-Reply-To: <6f677d56-82b3-a321-f338-cbf8ff4e83eb@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Fri, 20 Sep 2019 10:29:58 +0200
Message-ID: <CAHg0HuzsbGMmk-_ooTMDKQJYuAdAVrOvW-tzWgN-NNX7tcGgxA@mail.gmail.com>
Subject: Re: [PATCH v4 17/25] ibnbd: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Roman Pen <r.peniaev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 18, 2019 at 5:47 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/18/19 12:14 AM, Danil Kipnis wrote:
> > I'm not familiar with dm code, but don't they need to deal with the
> > same situation: if I configure 100 logical volumes on top of a single
> > NVME drive with X hardware queues, each queue_depth deep, then each dm
> > block device would need to advertise X hardware queues in order to
> > achieve highest performance in case only this one volume is accessed,
> > while in fact those X physical queues have to be shared among all 100
> > logical volumes, if they are accessed in parallel?
>
> Combining multiple queues (a) into a single queue (b) that is smaller
> than the combined source queues without sacrificing performance is
> tricky. We already have one such implementation in the block layer core
> and it took considerable time to get that implementation right. See e.g.
> blk_mq_sched_mark_restart_hctx() and blk_mq_sched_restart().
We will need some time, to check if we can reuse those...

> dm drivers are expected to return DM_MAPIO_REQUEUE or
> DM_MAPIO_DELAY_REQUEUE if the queue (b) is full. It turned out to be
> difficult to get this right in the dm-mpath driver and at the same time
> to achieve good performance.
We also first tried to just return error codes in case we can't
process an incoming request, but this was causing huge performance
degradation when number of devices mapped over the same session is
growing. Since we introduced those per cpu per devices lists of
stopped queues, we do scale very well.

>
> The ibnbd driver introduces a third implementation of code that combines
> multiple (per-cpu) queues into one queue per CPU. It is considered
> important in the Linux kernel to avoid code duplication. Hence my
> question whether ibnbd can reuse the block layer infrastructure for
> sharing tag sets.
Yes, will have to reiterate on this.
