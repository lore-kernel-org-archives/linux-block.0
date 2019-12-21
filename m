Return-Path: <SRS0=rhTN=2L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C1EC3F68F
	for <linux-block@archiver.kernel.org>; Sat, 21 Dec 2019 14:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBA4222C2
	for <linux-block@archiver.kernel.org>; Sat, 21 Dec 2019 14:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="CZdIRwnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfLUO2H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Dec 2019 09:28:07 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35275 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfLUO2G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Dec 2019 09:28:06 -0500
Received: by mail-io1-f67.google.com with SMTP id v18so12272709iol.2
        for <linux-block@vger.kernel.org>; Sat, 21 Dec 2019 06:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Prd73x3m1oH2epmhiGL3DVbj6k1ituH6b/G8OUPXtR0=;
        b=CZdIRwnvAf8usj6GfyZc4kMlzNjW6Ln8nxKlXFcc/5q8nJCvtg+MkoS5x9+RyP9mr0
         UiEYlvsGcyFqTibPBI+qI+NTUDZe0j9dObsnkzsBi4hfmi45eTRrQsB2NRW33rDQuzql
         TxdxqGK+1NkTI6XaNgumky/VpPQLPnZjXXjzdVE/SAf5v9HRfLW/7ltUQYzUSR991I53
         P3OiuqU91y294hJqkoQnwbs7/4DXQV+pS0l0srOJIbBtQkMTnLZnqWPkZxEdKmiRt9vu
         qBTj3kfR1ttUVzHBNHKVpXZl+5hVo2ydTThCSzrPNrihWy+Jl7SMxfuHtxEU2NxmyoqD
         LL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Prd73x3m1oH2epmhiGL3DVbj6k1ituH6b/G8OUPXtR0=;
        b=SpVP8AEufPDx02AGXjnS2KsvooM+/y6mFGXxtjwFHg79Puy9n+lESKSyEj1EEUzsxr
         lW5XYKZZClrlb9ogDN7ICWDvVsy/vn7qCDLoFoA8++siPg0XNXte0CHN4M6keJ3HruUG
         Sykw1o8uFMOheJDMj/zovB7LrNuwhfKTUKEm7hnLDSDpE86stAjI9YLXXgJfQWkEqWbG
         ++amz+TmsBLDG5ekctu9i9wf3RW18XIgU+8NeX8//jafKlsorq7M1cCF3wRDO7RSPy3R
         UKctnrm1hE3sL6WLfFThQVxivwLSdwc4I3NjvLeK/9p8V1E7zFoaf7UfsFuyzdvvEuW5
         T5Aw==
X-Gm-Message-State: APjAAAVk82ZtM+bHI4Xk9KMrHtTu7wXt3wSoKdFyyzdD92I5JpxGpygP
        yPgTa+f1QPdTilut2ZS8CpEjVWm+dDRTZUbEQK/3
X-Google-Smtp-Source: APXvYqxCao/ASHWi/KROdKEZlBEBZwYnWwjdjl+mM9lQuL/kqN11QE/EHFHGWMmmndchgbHqo37EFHTtfekrGT1XWM8=
X-Received: by 2002:a5e:c314:: with SMTP id a20mr14285199iok.300.1576938485965;
 Sat, 21 Dec 2019 06:28:05 -0800 (PST)
MIME-Version: 1.0
References: <20191220155109.8959-1-jinpuwang@gmail.com> <20191220155109.8959-3-jinpuwang@gmail.com>
 <20191221101530.GC13335@unreal>
In-Reply-To: <20191221101530.GC13335@unreal>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Sat, 21 Dec 2019 15:27:55 +0100
Message-ID: <CAHg0HuxC9b+E9CRKuw4qDeEfz7=rwUceG+fFGfNHK5=H2aQMGw@mail.gmail.com>
Subject: Re: [PATCH v5 02/25] rtrs: public interface header to establish RDMA connections
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Leon,

On Sat, Dec 21, 2019 at 11:15 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> Perhaps it is normal practice to write half a company as authors,
> and I'm wrong in the following, but code authorship is determined by
> multiple tags in the commit messages.

Different developers contributed to the driver over the last several
years. Currently they are not working any more on this code. What tags
in the commit message do you think would be appropriate to give those
people credit for their work?

Best,
Danil
