Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE663C433DB
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 23:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF25D2253D
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 23:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbhADXTu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbhADXTu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jan 2021 18:19:50 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5BCC061574
        for <linux-block@vger.kernel.org>; Mon,  4 Jan 2021 15:19:09 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id k8so26932102ilr.4
        for <linux-block@vger.kernel.org>; Mon, 04 Jan 2021 15:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PX8oIefqvj4m1fhpk9Yk9JUCrGXiZ2uLTZFm+izHPPY=;
        b=0rt7rPP+kKHC1piUsixUzA//djUz0Ithh88VD2BqrZD21S5ZvvNYxTKvWe7eWbxwG4
         F2fWxaYLPM5AcTR5BBH+bqNrqzbbTJJ0vakcjrH3hu0iaQ0DVz2SR1NTLIq3LvZPD0zk
         YJxYGyDYT3nqZ2vfeQ9Khbzr3ytKz0jN52BDJu2rTZaHSjANuv6DI18MyAzmYhQn6RFZ
         uBoIZLA4Cac1Q93CkOvjbGaJXNUOqbL39679ocg9FIUaF3lrQ1N6AvIGk2idRZKxBifR
         qviEwVkZxLHVyyM9RE8PKVkWCxdEj86tN8TJE6XwWs5zb0mkMQ1D7d0dwixNMvtRb5gS
         n5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PX8oIefqvj4m1fhpk9Yk9JUCrGXiZ2uLTZFm+izHPPY=;
        b=V8/kVcYBNYcfqPKC2qpPVV05n2BDToqJ2BUqbuLdzX24S+5r/Pidr0qvTFd60gWGn0
         iK0bfQrxYVHB4fQKW3AyksBXCt/yo+S5o6OYv2HsvcyLWjy21EslYvjKxjwVw6Si3JLH
         oUTxOYPhZm1oxPa6vtXGcZay2jzK1XgiKduNLjC3+KhzX6ZVIklzAQP4Tzv9EZt27jS5
         JfLB3OMLZnjxH88SnvaTjoeGxIU8+MWivXHKWHkAobKBBdeIgHa6LAWycIBWzJlq7joW
         /AMT6RBhVDTPFP0FXxEH5tdXQPA63MTmRq7i2qY0ZZxmJSuLZjlg2T8ooYEi1XMkE6WB
         whqQ==
X-Gm-Message-State: AOAM53039s4vv2gZoyxTnIoGvzPapubwSTAQFEJqEdf/QUKn0fresLXj
        DsW1hWye0PZlu2xMcGyH0ea4teqjq/OEMA==
X-Google-Smtp-Source: ABdhPJwBqdvld0GKkrUPUR1ElNVtH9R3UVxLEQyURWe2sbn/u9CTfRcc9RmOazFvzHaE2TgZVBzW1A==
X-Received: by 2002:a65:6450:: with SMTP id s16mr47468761pgv.71.1609800487145;
        Mon, 04 Jan 2021 14:48:07 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:a87e])
        by smtp.gmail.com with ESMTPSA id n28sm56139005pfq.61.2021.01.04.14.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 14:48:05 -0800 (PST)
Date:   Mon, 4 Jan 2021 14:48:04 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH V3 blktests 0/5] nvmeof-mp/srp/nvme-rdma misc fix and
 enhancement
Message-ID: <X/ObJB4Ixh8gplT7@relinquished.localdomain>
References: <20201126083532.27509-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126083532.27509-1-yi.zhang@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 26, 2020 at 04:35:27PM +0800, Yi Zhang wrote:
> Hi
> 
> This patch series addressed some failures when I run nvmeof-mp/srp
> test and also add suport to use siw for nvme-rdma/nvmeof-mp/srp  testing
> from cmdline, like this:
> 
> $ use_siw=1 nvme-trtype=rdma ./check nvme
> $ use_siw=1 ./check nvmeof-mp
> $ use_siw-1 ./check srp
> 
> V3:
> Use sed to output the scheduler from sysfs directly in patch 3
> 
> V2:
> Update the ib_srpt module path in patch 1, avoid to use ls
> Update the SKIP_REASON in patch 2
> Introduce get_scheduler_list, fix nvmeof-mp/012 and srp/012 in patch 3
> Typo fix in patch 4
> 
> Yi Zhang (5):
>   tests/srp/rc: update the ib_srpt module name
>   tests/nvmeof-mp/rc: run nvmeof-mp tests if we set multipath=N
>   nvmeof-mp/012, srp/012: fix the scheduler list
>   common/rc: _have_iproute2 fix for "ip -V" change
>   common/multipath-over-rdma: allow to set use_siw
> 
>  common/multipath-over-rdma | 13 ++++++++++++-
>  common/rc                  |  2 +-
>  tests/nvmeof-mp/012        | 10 ++++++----
>  tests/nvmeof-mp/rc         |  8 +++++---
>  tests/srp/012              | 10 ++++++----
>  tests/srp/rc               |  4 ++--
>  6 files changed, 32 insertions(+), 15 deletions(-)

Applied, thanks!
