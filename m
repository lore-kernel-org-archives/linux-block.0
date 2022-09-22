Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0096C54EE9
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 14:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiIVOpc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiIVOp3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 10:45:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0736D4DD2
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 07:45:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y3so21616898ejc.1
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 07:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sq8i3fpvXaZYN4UgYgJ7OM62oxl8F9QEUI+JF3VX4sg=;
        b=Yg1P9z3y8jOfz7amVyNbTCY++L5ivvOHQSMiD9c2xqHFlJEdktnmDtLtrYN4Pnnpcm
         aQsKPDqgE21iVDmvQlk137U+7bjzOUTM3iWNqT+4o62RvfgX+oYdhihdVnfOgd39hAFh
         4/aJ5njKB9alkqXyoFn7uSIr03s6mPpC+Shm2hXq4RwtIXJ8JS4Nr2VqT83/PTjtBSO4
         lNzmk7vUZTApEd1Mzhbsf2/4QJcxrfB7ceGbxRWIJsZEY1i6YpudnOwBiqj9aykSmWmI
         sBc0J9apqU2OqMFdI7x/KZhpreAHVs8t4KR3UndCfcjH8rrQBvRYf/0o/y24a/rEdAOm
         Q83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sq8i3fpvXaZYN4UgYgJ7OM62oxl8F9QEUI+JF3VX4sg=;
        b=MM7kpUzIzGiBXCGxfNN89W/+ZRb5cMnqnJQyoCcVmberqBpiS76q8KCG+pVtIi/5f4
         PPdXmKbdrJlsU2mOzr0y0NoJZQMUK8drk6u9S36y8KGqBdSUzHyz+BafAAApiBkufYmj
         qLICtU7KiBmPS1saN0K0fGHh+fIgKlEXkhYu/B3JJChjBWdCYa3Z/HDbulXlgI7k00vJ
         oaeQvHFyN3kVRKA/fKerUscVS3kE1Aov4illKm9KmQWf0nu/dGqysFDt3PmuEKcxqZEk
         NMgHOOvDqsabLcTC5ERVgqbePI/gyNuIPrmffBWP4LS7n0mQd6kRdMNUH6Vjj7EE3nY/
         IlTg==
X-Gm-Message-State: ACrzQf2ujA+BkMbmdGyks7E1yEYo5l/wLCYQRfMuJ6oIJPn7pOg954uf
        tqWeWPLqfa0Utg4xtLxJgVRSJZnbXmVKWzXv5V4aAYDDJDk=
X-Google-Smtp-Source: AMsMyM5G7jaBJOtl6Tv69YAChZGpz/zqoC0yzQH0WxJg70+IsNHMGyfk7YEsyAgIHQXMaVNOEo3LN5EAXCUYNJXdMAA=
X-Received: by 2002:a17:906:847b:b0:773:db0f:d533 with SMTP id
 hx27-20020a170906847b00b00773db0fd533mr3228807ejc.0.1663857926990; Thu, 22
 Sep 2022 07:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220830150153.12627-1-suwan.kim027@gmail.com> <20220831124441.ai5xratdpemiqmyv@quentin>
In-Reply-To: <20220831124441.ai5xratdpemiqmyv@quentin>
From:   Suwan Kim <suwan.kim027@gmail.com>
Date:   Thu, 22 Sep 2022 23:45:15 +0900
Message-ID: <CAFNWusaxT38RyQBFZu6jN_kaL3p3hTQ0oXPQZkZdEJ3VjUMVWg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()
To:     mst@redhat.com
Cc:     Pankaj Raghav <pankydev8@gmail.com>, jasowang@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com, acourbot@chromium.org,
        hch@infradead.org, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Michael,

Can this patch be merged to the next rc?
We received two bug reports about this issue and need to fix it.

Regards,
Suwan Kim


On Wed, Aug 31, 2022 at 9:44 PM Pankaj Raghav <pankydev8@gmail.com> wrote:
>
> On Wed, Aug 31, 2022 at 12:01:53AM +0900, Suwan Kim wrote:
> > If a request fails at virtio_queue_rqs(), it is inserted to requeue_list
> > and passed to virtio_queue_rq(). Then blk_mq_start_request() can be called
> > again at virtio_queue_rq() and trigger WARN_ON_ONCE like below trace because
> > request state was already set to MQ_RQ_IN_FLIGHT in virtio_queue_rqs()
> > despite the failure.
> >
> > To avoid calling blk_mq_start_request() twice, This patch moves the
> > execution of blk_mq_start_request() to the end of virtblk_prep_rq().
> > And instead of requeuing failed request to plug list in the error path of
> > virtblk_add_req_batch(), it uses blk_mq_requeue_request() to change failed
> > request state to MQ_RQ_IDLE. Then virtblk can safely handle the request
> > on the next trial.
> >
> > Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
> > Reported-by: Alexandre Courbot <acourbot@chromium.org>
> > Tested-by: Alexandre Courbot <acourbot@chromium.org>
> > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > ---
> Looks good.
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
