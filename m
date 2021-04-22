Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2460C433ED
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 17:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AAB7613B8
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 17:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbhDVRtf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 13:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDVRtf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 13:49:35 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6F4C06174A
        for <linux-block@vger.kernel.org>; Thu, 22 Apr 2021 10:48:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j14-20020a17090a694eb0290152d92c205dso1403870pjm.0
        for <linux-block@vger.kernel.org>; Thu, 22 Apr 2021 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VvbUFSEIQSRhOiiC3opsx0f7VTdAXH0Ya6f9Uf6c7Ss=;
        b=0/c39k6LIrRAphiROsQMJQJWHQy7N0r6TWb84qLGZniZcaJwZFV/7jVJ6336E3ozG4
         1gBfaHVKIZwno7XjL6wJ7EeQxix/8Kbo8fddoaob8cXY0rpPeLbei7h04am7nK7XNKl5
         RVPp7qVROlDcJzuIleZy7wiYi02ffLztfV7BPd2M+zNLwlPVrK3h5HBpY/B+w7kAaR4b
         GWLdlSQB41SXLikUE3PVYCf/ATPf1K236BD08gDKDiagtVO6IZ3qtLuuC7CN5OhYM4g3
         zd9PldFjy9SDRBzzIV3UweFUtRH6OG5eqAkYNiTegqDOSbOY1dIvuApvrlf/Aa3PGsTp
         2Avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VvbUFSEIQSRhOiiC3opsx0f7VTdAXH0Ya6f9Uf6c7Ss=;
        b=S0oZn/2PgGLUX66zWK6X/Gmvnf3aS/8rDylB9uFX/1pFkexI0aFkjZ2kOcB2ypf9cb
         kbf4C/SCkknVNwQic6jTKklu7xO802atpNF0gF5SbNfTnqadQE4e5Ds2INEwo43oZ1Fh
         xcizr8uaZvwBVxS0EF94WaF/F53AVU1kLlc0ENuVeElJ9CBpeMRI5mUGfBfsbaTxzpSG
         ZgTZOpIp4Z+XilMY+sNJB1nvMHJ3B8wZdDK3G55sLGjQT3XproWIew15irGcyCrBqo8g
         9On9IXZcFdnkdY6uQEmfMjzWyUUOxdVKUWhq75bWgNinhqRdEGgAdd6pRw7JxRNl8hAX
         v8rA==
X-Gm-Message-State: AOAM531GlUTkvfUk/3s5JO7CMCM9V+GnMsdrr54+mSkOL1KnmIci6oDb
        gZrpGCFmbuDOnkDs1u7MDDPUuw==
X-Google-Smtp-Source: ABdhPJyR7z/s5UlnSuzckh10Jttzvybhah5XrQevFbH++7BienzFkLWmNQCr7tO9lc585Sw8Gflh9A==
X-Received: by 2002:a17:90a:a895:: with SMTP id h21mr5322410pjq.13.1619113738732;
        Thu, 22 Apr 2021 10:48:58 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:54b2])
        by smtp.gmail.com with ESMTPSA id m20sm2373693pfk.133.2021.04.22.10.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 10:48:57 -0700 (PDT)
Date:   Thu, 22 Apr 2021 10:48:56 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Douglas Gilbert <dgilbert@interlog.com>
Subject: Re: [PATCH blktests] tests/block/031: Add a test for sharing a tag
 set across hardware queues
Message-ID: <YIG3CK5Qs/YoZaB6@relinquished.localdomain>
References: <20210328231210.3707-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328231210.3707-1-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 28, 2021 at 04:12:09PM -0700, Bart Van Assche wrote:
> Support for sharing a tag set across hardware queues has been added
> recently to the Linux kernel. See also the BLK_MQ_F_TAG_HCTX_SHARED flag,
> Linux kernel commit 32bc15afed04 ("blk-mq: Facilitate a shared sbitmap per
> tagset"; v5.10) and commit 0905053bdb5b ("null_blk: Support shared tag
> bitmap"; v5.10). Add a test that triggers the shared tag set code in the
> block layer core.
> 
> Cc: John Garry <john.garry@huawei.com>
> Cc: Don Brace<don.brace@microsemi.com>
> Cc: Douglas Gilbert <dgilbert@interlog.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  tests/block/031     | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tests/block/031.out |  1 +
>  2 files changed, 44 insertions(+)
>  create mode 100755 tests/block/031
>  create mode 100644 tests/block/031.out

Thanks, Bart, applied.
