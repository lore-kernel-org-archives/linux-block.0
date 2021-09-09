Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DB4C433F5
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 14:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D94661132
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 14:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244347AbhIIOQm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbhIIOQk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Sep 2021 10:16:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1324DC06175F
        for <linux-block@vger.kernel.org>; Thu,  9 Sep 2021 05:34:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g21so2436954edw.4
        for <linux-block@vger.kernel.org>; Thu, 09 Sep 2021 05:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oX4Dj9ZXgOv8yaBPcUaPEk5dnnNEO7xIQcrdkFjSHKA=;
        b=E7uWS8yDE751Ij1pZzX4IMB9dvJ8U1MM4xw6zcVfKZ+vmEXQwWzK5ANY3O7DpaV969
         5zRN8Y35JaFlIJmo13bnSJICIDtbZiqChEzk3N5yyKzSFdMn4uxT/kkgRJPQeg7jHEVY
         GdQYjardLGHClo9/FL6L5+ufQJontEEcX/CPh3BwgEDcKrcIHSkK60b9h4xs0rGZjZ44
         026ldb7eMP5hqAuaYydZ5NJEHeREsSq1EIYb1GL4wmO0nNuloxVxoxFuAapM7lBYY2zn
         Gj4/HaP2E6vGv73PJjI4bzKtwfwSY5LyQy/tBbORi+jgZsWx1wDJxDiFylCOlPkE/RFy
         1mNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oX4Dj9ZXgOv8yaBPcUaPEk5dnnNEO7xIQcrdkFjSHKA=;
        b=2WGgrpX/LnpzWVfc7kZJAJbAcA/d/Bnn0PY+YkNbSoHIiJAr7nSObtEYLwvTIp0RGc
         XaaRACHF24iIGHOM3D6GhXqs3mXjkQPd4L7CAOjESpkoZFdqA2d1CaWMu/p1gs6grSYe
         TjWa3JNsVR86gDMMtJtV1sEewsM2b+pqzb1yU7zsZ6iu0YNGxCQMXhJfpSedcVai/1Aq
         0n0sB/P0GL91s7u/lWhIr5adyBFxc9jAJHeBXmqN2qapaEM9stONFdQp10hsGJ8vMX7m
         vceuoqDNkpbuTvmuVjXlCfAg2dX3B4/klUAUIcEBY7VaPVC7eXUiiTXiITis23bH7aLz
         040A==
X-Gm-Message-State: AOAM531liAa1k76cwYzAz0YEVlK0ZFKmFkB3sJ+RvMKyP5efc0xH6WHO
        UMJZ0s15D84RVJfxP8AP/WTso1mfGJj6IGjbhB1A
X-Google-Smtp-Source: ABdhPJz7R5rWq5PdHrd+/9R7VKFyY4khAyM8rWwNp9zT3ExKuPkyRb2KXZ0SObAbCNjw/gtpQznwZm9lJDmQ8UkOjRo=
X-Received: by 2002:a05:6402:4247:: with SMTP id g7mr2925993edb.287.1631190859581;
 Thu, 09 Sep 2021 05:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210907121425.91-1-xieyongji@bytedance.com> <YTmqJHd7YWAQ2lZ7@infradead.org>
In-Reply-To: <YTmqJHd7YWAQ2lZ7@infradead.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 9 Sep 2021 20:34:12 +0800
Message-ID: <CACycT3vHrN3tgeH91gdzr08DXd8KCXyAuxUb5k-HcwB7coi4iA@mail.gmail.com>
Subject: Re: [PATCH] nbd: clear wb_err in bd_inode on disconnect
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 9, 2021 at 2:31 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Sep 07, 2021 at 08:14:25PM +0800, Xie Yongji wrote:
> > When a nbd device encounters a writeback error, that error will
> > get propagated to the bd_inode's wb_err field. Then if this nbd
> > device's backend is disconnected and another is attached, we will
> > get back the previous writeback error on fsync, which is unexpected.
> > To fix it, let's clear out the wb_err on disconnect.
>
> I really do not like how internals of the implementation like into
> drivers here.  Can you add a block layer helper to clear any state
> instead? This should incude e.g. the size just cleared above and should
> also be used by the loop driver as well.

Sure, will do it.

Thanks,
Yongji
