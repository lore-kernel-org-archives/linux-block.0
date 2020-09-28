Return-Path: <SRS0=cicp=DF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E54C2D0A8
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 12:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000FE21D95
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 12:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Wdbs+kQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgI1MvY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Sep 2020 08:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgI1MvV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Sep 2020 08:51:21 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBB2C0613CE
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2020 05:51:21 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m34so790593pgl.9
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2020 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QctrJGO1I1Zuq9UjMR9T/NENbwiqNJx5W8ogBL7RQ5k=;
        b=Wdbs+kQhoDgB+n99eSez3KyAycIljc9Qj/GQ39BXZvD9xGiS9EynalYs0Q4br8vS12
         drU4r1qnw04T/+k4hDdBJ6lu/ugHFPvQ59DawL4UGbaCznu28po0/vwp23JsmL6ajkU1
         7+dL2mIBh/kofHf4TWgUnp63wdbkh2lK8w+K5UXkgLGA0XEBvGo9II52ooO2Bf6XPsfJ
         L5iQws00GWLHkVNkL6qkJJZLkS3USdMpipUqDZZTbxkKZQshtpRw9B8cD/yIr0LSj3Lk
         ONA23uHk80zPrU9hYVszOHe/Veleq9MpkYzzePz31Ywp24nsCK2jp3XDUBKlHeRYs2PY
         821w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QctrJGO1I1Zuq9UjMR9T/NENbwiqNJx5W8ogBL7RQ5k=;
        b=RCXOXIaPHpYkDeR1pey+lt8ZT5n7n7XH4+/vLaLowKMLfvsGTEqXuWl7vNMrAHsKpK
         BLE2kTush7cURYemlDBOW3RN1VjN4Kvl+P3193ERSIxWOyVsWMnsxseEa3ZfgbdQ9/dG
         57fI1tpOXV56Qi9ybWtrmEKcoj9Y4VPp/bAwhrIOMHOOdE+cSP/+zdjbueqIs2KeF8Vi
         bSb5Qygno+2yVOUc93uyOdEh1cKPt63yaI9h1nT6B5L32mH3tO79EF4KV7d8g51C4pcc
         rh3Iv8iufuYDiyMvdfK58oOxDPe96YTUJw/nw6ydFZaNxUJzVzW2oPnIYJJmJA1msZis
         BT/Q==
X-Gm-Message-State: AOAM531BvbxBXIbviEYhXeAxkblRnbt7+d+LJMWvhLBwT0tVnthL2CGl
        Mk/mq2Exxiwc+TaJWN2zpRbS7kb14W+4wur9KCaZQzZwMMNUeQ==
X-Google-Smtp-Source: ABdhPJz9AK/9Nb+6ZHbA6CAHV8fQ++VqMz+5ImOS6aqC3CdqZZQF7dyj+J1OJFyYnyhqbh7E1B/9cyjzPInPq4h19mk=
X-Received: by 2002:a63:c112:: with SMTP id w18mr1007690pgf.31.1601297481123;
 Mon, 28 Sep 2020 05:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200923114419.71218-1-songmuchun@bytedance.com>
In-Reply-To: <20200923114419.71218-1-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 28 Sep 2020 20:50:44 +0800
Message-ID: <CAMZfGtUFacR9GFfmySEN6EfdxVi7ZKdwTs17HrJmOL9A38J8sg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] io_uring: Fix async workqueue is not canceled on
 some corner case
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Yinyin Zhu <zhuyinyin@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping guys. This is worth fixing.

On Wed, Sep 23, 2020 at 7:44 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> We should make sure that async workqueue is canceled on exit, but on
> some corner case, we found that the async workqueue is not canceled
> on exit in the linux-5.4. So we started an in-depth investigation.
> Fortunately, we finally found the problem. The commit:
>
>   1c4404efcf2c ("io_uring: make sure async workqueue is canceled on exit")
>
> did not completely solve this problem. This patch series to solve this
> problem completely. And there's no upstream variant of this commit, so
> this patch series is just fix the linux-5.4.y stable branch.
>
> changelog in v2:
>   1. Fix missing save the current thread files
>   2. Fix double list add in io_queue_async_work()
>
> Muchun Song (4):
>   io_uring: Fix missing smp_mb() in io_cancel_async_work()
>   io_uring: Fix remove irrelevant req from the task_list
>   io_uring: Fix missing save the current thread files
>   io_uring: Fix double list add in io_queue_async_work()
>
> Yinyin Zhu (1):
>   io_uring: Fix resource leaking when kill the process
>
>  fs/io_uring.c | 59 +++++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 39 insertions(+), 20 deletions(-)
>
> --
> 2.11.0
>


-- 
Yours,
Muchun
