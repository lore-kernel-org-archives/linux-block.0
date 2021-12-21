Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BB5C433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 03:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhLUDjg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Dec 2021 22:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhLUDjf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Dec 2021 22:39:35 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5B3C06173E
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 19:39:35 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o20so46394919eds.10
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 19:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HhnT9iNZb45m+Yl6mmQXF6P5epcMOvtSvPcLxLPj1Hk=;
        b=OTtRQUfhK6ogaf3OkEckf0AdFVHviCmA+iuNxTtJWMhIu2fWrZTI9qwtfjDf28mLHY
         gcYrWGWoXgnOhvwnvbtxuoInQmGgEIwOp45lwB8uiSGMIbrVExVtwfxeT0VYuv3C1Szf
         q8QKzfD9ewNC6xax+cp6ToRES9Se77yLt/m9Jmanl4ulaYqhnjDyNhGKlPcAv5WE41sR
         8bF0soaUCI0CoLbQBSYbzLe8reUJtmRc+pEKcdztC44tc7hmAanE0yO7hcqKVhjSH8aI
         79PhW1m4DK+9jvmEPA3mIUZ5QF/yTGpni2YHVkDM9F/X3G/rNWjgQTavKJtoa1hygxvP
         USPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhnT9iNZb45m+Yl6mmQXF6P5epcMOvtSvPcLxLPj1Hk=;
        b=xR84GptEWjNx2Bpi80lAoCZnkFkl4MiVhjePsZL3shqRY8gXYsNiQoop0lCBAOHcK8
         WT2R4vvJY0VW4gDKl50Af8Jry6qGXeWthzPMcF9IoIp/8hfFAr9sL8ZTLZifk36ZaqwS
         JacoqbvgP9k8Flg0uyeNGSY6FMsCU3smQGdBJIAS+C43JOFvdL4gC9tDdgI/uFN6YdGD
         7XrTv1v+xKveu4XsRZOWRd4rZpIZXnwYToJQmuatmrIuJQ7EkjBZohPZVMDT1FyrzgPs
         bSgWc0rmGmniulNX7Nn8J4C1+g8L8KkkXkVFVnx0LvO2sEqzAAZXsC+fxrAU6D+IavaM
         9y3w==
X-Gm-Message-State: AOAM5320y6MvK58Nj7hPBSrw+JTa1G2sSHiIJfHWbUvp+EURr8U3HWB3
        ACCQqtBKw7+fRBXIxniYL1w5e7YHLNJ08Xd1r1OnJiMtqg==
X-Google-Smtp-Source: ABdhPJwAGTC0km/cbwkFPRUxwBn/XhPvg5GSgJxcHMqmSVAPC3iT1QyAHbSC+PLi61u4PtVo0FVoBVQzBNBelmY5xNA=
X-Received: by 2002:a17:907:2da6:: with SMTP id gt38mr1076078ejc.536.1640057973687;
 Mon, 20 Dec 2021 19:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20211220122241.150-1-xieyongji@bytedance.com> <a4ba2441-83eb-dde2-09ae-7c5f42ff6ad3@acm.org>
In-Reply-To: <a4ba2441-83eb-dde2-09ae-7c5f42ff6ad3@acm.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 21 Dec 2021 11:39:22 +0800
Message-ID: <CACycT3t-UzaLOFSTmYyKniHYPK8jH9SevgB+1xrnCTc_4JKXQw@mail.gmail.com>
Subject: Re: [PATCH] nbd: Don't use workqueue to handle recv work
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 21, 2021 at 1:10 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/20/21 04:22, Xie Yongji wrote:
> > The rescuer thread might take over the works queued on
> > the workqueue when the worker thread creation timed out.
> > If this happens, we have no chance to create multiple
> > recv threads which causes I/O hung on this nbd device.
> >
> > To fix it, this tries to create kthreads directly to
> > handle the recv work instead of using workqueue.
>
> Why a kthread instead of only removing the WQ_MEM_RECLAIM flag from the

I think we can not simply remove the WQ_MEM_RECLAIM flag because the
recv work is in the memory reclaim path.

> alloc_workqueue() call? This should have been explained in the patch
> description. Additionally, a Fixes: tag is missing.
>

OK, will do it in v2.

Thanks,
Yongji
