Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009F7C433FE
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 11:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbiCWLXM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Mar 2022 07:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243865AbiCWLW4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Mar 2022 07:22:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7233678FC2
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 04:21:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r13so2158998ejd.5
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 04:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q428jPB3LI7YHZ1TPk4eUv6mjfb7Ccik6IuwbzunlN8=;
        b=qk78RGmu57m+WoTO9wCDpvaz8ymit5RglIS5kWuFOL3VPbzAb56W2jFcujjmoJ/UGs
         3EMPCUm15+UV7uYDmswOYIvQIRmiOmXioXyrRkhAZgoLMXbJ+zsL9cKQLdgUtLWFtVkT
         Z3S+uVKDof7qiuUWrur20pLRxaVjPJzXAaT9Emz+jj9qoCBPt4uM9eUeb0J27HVnDGdm
         aPrDDx/gd+JHrEaI5SEKc48yhCncdM2nrlC5X/9w4AU/s8nHQ0fGcvwlLyX0/6ayhbNl
         T6vs+W+6SaJZP90z0JVLIAefcdVL2wcfO6TlH6LbtjOol8X4VugVItB/ReHWiQtK6JrY
         hVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q428jPB3LI7YHZ1TPk4eUv6mjfb7Ccik6IuwbzunlN8=;
        b=yOukTQ59egPJmaojw/ZZASxSPcOdWlmEZDWLXo/t0+TrbMNbdDyhR5jXa/IEN1XGhz
         hFU0FDvK4w8mZ+rrLMdQErT9/CM8r2/GzNaA+8CR+BJSSdCGFIR1hWqw+L5zvWrDBS18
         YCq4gvRX31r565WiLl2uWVwIIQjw729/APmBBdPTS1XH01X6k1/anNoSr/ZIxebNS7eJ
         Dh6nsBW/ujb/XRQdutEqRkNUhacrKDW4XtWVtfab+aDeUegjMQIDxt07fWMkJzU9utV6
         tXkaKOxx/3DTVxp8Y20uNytOBbSlFSo5g8EUqoFQaL9+MwyMPmxfkCMfdrLeXNEnV4+N
         TlsA==
X-Gm-Message-State: AOAM531FuPjsxI1sKdHItdYJ3qoH9jdwQ4296ETaOOKaqp/gZnxw8i9P
        B5Z0Wh4TbGIcrL9nbdJ5xi2XuXHDBgFBWU1/u91s/x8WTw==
X-Google-Smtp-Source: ABdhPJyeZxP1pcZPz6bj3JhcI1N6gvpSUjdNdladDO5oGiHAiqqYZoRaKWuZ9Ngs5Pq/FT2Q6BrtFvuDlEhpUxtD9Gs=
X-Received: by 2002:a17:907:6e09:b0:6e0:6bd1:ab5a with SMTP id
 sd9-20020a1709076e0900b006e06bd1ab5amr1173845ejc.622.1648034484978; Wed, 23
 Mar 2022 04:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211227091241.103-1-xieyongji@bytedance.com> <YjotekJZcSvwoZhp@localhost.localdomain>
In-Reply-To: <YjotekJZcSvwoZhp@localhost.localdomain>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 23 Mar 2022 19:21:25 +0800
Message-ID: <CACycT3vz4hYTFpHo0Jphs-xE-k--y63+vedTFAaDRWhpi4_5rg@mail.gmail.com>
Subject: Re: [PATCH v2] nbd: Don't use workqueue to handle recv work
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 23, 2022 at 4:11 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Mon, Dec 27, 2021 at 05:12:41PM +0800, Xie Yongji wrote:
> > The rescuer thread might take over the works queued on
> > the workqueue when the worker thread creation timed out.
> > If this happens, we have no chance to create multiple
> > recv threads which causes I/O hung on this nbd device.
> >
> > To fix it, we can not simply remove the WQ_MEM_RECLAIM
> > flag since the recv work is in the memory reclaim path.
> > So this patch tries to create kthreads directly to
> > handle the recv work instead of using workqueue.
> >
>
> I still don't understand why we can't drop WQ_MEM_RECLAIM.  IIRC your argument
> is that we need it because a reconnect could happen under memory pressure and we
> need to be able to queue work for that.  However your code makes it so we're
> just doing a kthread_create(), which isn't coming out of some emergency pool, so
> it's just as likely to fail as a !WQ_MEM_RECLAIM workqueue.  Thanks,
>

I think the key point is the context in which the work thread is
created. It's the context of the nbd process if using kthread_create()
to create a workthread (might do some allocation). Then we can benefit
from the PR_SET_IO_FLUSHER flag, so memory reclaim would never hit the
page cache on the nbd device. But using queue_work() to create a
workthread, the actual thread creation happens in the context of the
work thread rather than the nbd process, so we can't rely on the
PR_SET_IO_FLUSHER flag to avoid deadlock.

Thanks,
Yongji
