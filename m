Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA28AC04A95
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 09:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiJYJAe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 05:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiJYJAd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 05:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122B51119E6
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 02:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666688431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ffS7/S+akc8/x+RmIejdmt+s1na/0VWtBH57nlzZtYo=;
        b=aEX/upCJG0ildrIrJ2BUh/lEGvxPVqed9w+q/iH4Vw9XivGQuFZS+edWq6K9zX9bx/n9Wx
        M5p48Vpry2czIMXCwa1OK51lk4evzBY9ybJxipnoqfRNWBBNsEbizRz1mmty7nJaoLq7ED
        WhTLID4kkDUNjNcIxDymFkzHuViPie4=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-9BFMxVAyMZiJ47QInfKKDg-1; Tue, 25 Oct 2022 05:00:28 -0400
X-MC-Unique: 9BFMxVAyMZiJ47QInfKKDg-1
Received: by mail-vk1-f197.google.com with SMTP id n12-20020a1f270c000000b003a2e234386dso3500040vkn.23
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 02:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffS7/S+akc8/x+RmIejdmt+s1na/0VWtBH57nlzZtYo=;
        b=awFcZKtm40k+LeYmJfw+dyi8D9ofYwbZOCdQKdeWqjh1ImZTX6sHgfObL7CTjeuB6d
         3RgWHgWM8eVP4npyxdAMhVFRi5yoarKLH5I2XRE05iWi6R2wCjBHQYi9kTcKShX09/Al
         JF1WlX7yusAyly38NxsTE3q1SNEKgBraSWwWROSG2dQBSIbT7QAWCc+3lVJNP9qiZDJ3
         i6GbiZrN04KjlRF+Rzta6bv3PVSIcMz/5scv0ZMziUKd6u3KnlkXAxbA+xzV+9IQTJo/
         c4CFmnmFBewvjFfJFVXl3qs1EJOfSULITKBVaSwx01xrGhDsh3kkvLPo1XvbUFAMgez7
         4niA==
X-Gm-Message-State: ACrzQf02i3Nj/q6rBoYRmYEmymiqwn1DernDQzfrd1AZSTEK5WkXHrVc
        /REn+5Fur5Q5d9JFdZoM48ynB1XvTc5bsa+W2hebJRq0Jlfo+NyiZEi6gIAkzYj9CzNlujdqPAR
        9K0suye5OFZLYx0LXib7TOa9OVFu5sZVPZVIlkwM=
X-Received: by 2002:a67:f346:0:b0:3aa:2ae7:7b12 with SMTP id p6-20020a67f346000000b003aa2ae77b12mr3682670vsm.86.1666688427694;
        Tue, 25 Oct 2022 02:00:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6ePHCAZe9sOFrpoaAtGPVrlunRpr3ktgdgGKee8ha6/UviSPYtHFMHdHDgsJrryhiJuUTZhd9bLqRtR+wbFOA=
X-Received: by 2002:a67:f346:0:b0:3aa:2ae7:7b12 with SMTP id
 p6-20020a67f346000000b003aa2ae77b12mr3682660vsm.86.1666688427280; Tue, 25 Oct
 2022 02:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <1666454846-11749-1-git-send-email-john.garry@huawei.com>
 <Y1U9zNZtZjRHQBww@T590> <99c6ca81-746d-85f4-04d3-49d7a3de611b@huawei.com>
 <Y1aS3vIbuQTNGWJL@T590> <360c78dc-65ce-362f-389d-075f2259ce5b@huawei.com>
 <Y1cvJ4/uwUScAQq4@T590> <3513b14c-14e0-b865-628e-a83521090de9@huawei.com>
In-Reply-To: <3513b14c-14e0-b865-628e-a83521090de9@huawei.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Tue, 25 Oct 2022 17:00:16 +0800
Message-ID: <CAFj5m9JnSBBVGrp5CqeH99-+VOGRuroUAi3c-3=6XKa891Sfmw@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: Properly init bios from blk_mq_alloc_request_hctx()
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, hch@lst.de,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 25, 2022 at 3:40 PM John Garry <john.garry@huawei.com> wrote:
>
> On 25/10/2022 01:34, Ming Lei wrote:
> >>>> but sometimes we just need to allocate for a specific HW
> >>>> queue...
> >>>>
> >>>> For my usecase of interest, it should not impact if the cpumask of the HW
> >>>> queue goes offline after selecting the cpu in blk_mq_alloc_request_hctx(),
> >>>> so any race is ok ... I think.
> >>>>
> >>>> However it should be still possible to make blk_mq_alloc_request_hctx() more
> >>>> robust. How about using something like work_on_cpu_safe() to allocate and
> >>>> execute the request with blk_mq_alloc_request() on a cpu associated with the
> >>>> HW queue, such that we know the cpu is online and stays online until we
> >>>> execute it? Or also extent to work_on_cpumask_safe() variant, so that we
> >>>> don't need to try all cpus in the mask (to see if online)?
> >>> But all cpus on this hctx->cpumask could become offline.
> >> If all hctx->cpumask are offline then we should not allocate a request and
> >> this is acceptable. Maybe I am missing your point.
> > As you saw, this API has the above problem too, but any one of CPUs
> > may become online later, maybe just during blk_mq_alloc_request_hctx(),
> > and it is easy to cause inconsistence.
> >
> > You didn't share your use case, but for nvme connection request, if it
> > is 1:1 mapping, if any one of CPU becomes offline, the controller
> > initialization could be failed, that isn't good from user viewpoint at
> > all.
>
> My use case is in SCSI EH domain. For my HBA controller of interest, to
> abort an erroneous IO we must send a controller proprietary abort
> command on same HW queue as original command. So we would need to
> allocate this abort request for a specific HW queue.

IMO, it is one bad hw/sw interface.

First such request has to be reserved, since all inflight IOs can be in error.

Second error handling needs to provide forward-progress, and it is supposed
to not require external dependency, otherwise easy to cause deadlock, but
here request from specific HW queue just depends on this queue's cpumask.

Also if it has to be reserved, it can be done as one device/driver private
command, so why bother blk-mq for this special use case?

>
> I mentioned before that if no hctx->cpumask is online then we don't need
> to allocate a request. That is because if no hctx->cpumask is online,
> this means that original erroneous IO must be completed due to nature of
> how blk-mq cpu hotplug handler works, i.e. drained, and then we don't
> actually need to abort it any longer, so ok to not get a request.

No, it is really not OK, if all cpus in hctx->cpumask are offline, you
can't allocate
request on the specified hw queue, then the erroneous IO can't be handled,
then cpu hotplug handler may hang for ever.

Thanks,
Ming

