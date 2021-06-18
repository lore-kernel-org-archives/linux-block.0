Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8059AC49361
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 14:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C8A610A3
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 14:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbhFROwu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbhFROwq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 10:52:46 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ABEC06175F
        for <linux-block@vger.kernel.org>; Fri, 18 Jun 2021 07:50:37 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id q10so10801921oij.5
        for <linux-block@vger.kernel.org>; Fri, 18 Jun 2021 07:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eNgK3ZJjTQmX4QuRyoqHtpDVpH+vzH+Vz2crquaXwXs=;
        b=LVE4lJRsmOz10qAwI3KcmhRgiY14JzpkgnDn0bQQfg/dLCsNpzBZcrRomzVYf2QqSp
         onGnULVdpkyt1FtCl5i4T2hlGEl0XFkdyW7+pFZNfZbBrqy7WKW/LCPUH9RnEoirw9uq
         HDFjB5R7HN+MMKmI0fquL4yKS2wgm9IBbFKDxofoDFvFpxCQ2dxfUVa/rVH7q40+O01y
         8FeCdwRTtA6Gjl7rD2kjNOsJ1E+VDCHrUXa9sHWTLT1jFI1OHvf7I5UTSTlYOcW7f/R3
         znVCV7lNrvWoNix74jG7BbX67huCO1+BcJhS/LniXEOr2rx6L8Cmz7hSvPsYojyk/1ZZ
         sEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eNgK3ZJjTQmX4QuRyoqHtpDVpH+vzH+Vz2crquaXwXs=;
        b=DM8BC6k4WYi5XUgIffYiQ+GM4SriOLB5EOlkesnEZyqsOtAC10KJ4lgsfMudOvxp6Q
         E5RTCRyzjIoDFSo+1HV4PAxgSHMrMzCMxv6OgTpOcIwtrADKpo2wC8ekzrLIv86FK9t8
         UkIJJL9iQHfcZyCoJqYS7+YMJOuWNUnPXkHZ3lbtWR1cxlqHWbakO5r+G/Y4lIS1D1jy
         ehMLcNLOleb60QjMxsEZpoC5VMUa8I4KVzWN7gBg8fZj339KR515TSAfPy3vGZgTwcCk
         X0f+mqMHN75Dtd/efHIWTEZXdL2gdCUEhNPO2s9m51P/sbMMeK4To08Kepg6zWIIKCSM
         JcMA==
X-Gm-Message-State: AOAM532/KXmWUVdvmDXDbe82vZ4ZCoDMEevNvuiEvuGC7wrBc3J2lM1E
        ewJE8ZGN1mm4UDL7IegfGp4zdQ==
X-Google-Smtp-Source: ABdhPJzo9R0nSd05w5OJFyK1R6y8yc8J2XvkydL6vXbIwMGewdVLCQMaao+VTvhcxvDsKnv/XBVZfw==
X-Received: by 2002:a05:6808:2091:: with SMTP id s17mr13987014oiw.168.1624027836584;
        Fri, 18 Jun 2021 07:50:36 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id m66sm1829800oia.28.2021.06.18.07.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 07:50:36 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: fix use-after-free in blk_mq_exit_sched
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        syzbot+77ba3d171a25c56756ea@syzkaller.appspotmail.com,
        John Garry <john.garry@huawei.com>
References: <20210609063046.122843-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c1b819bb-0117-577b-2edc-2abffbb9a659@kernel.dk>
Date:   Fri, 18 Jun 2021 08:50:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210609063046.122843-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 12:30 AM, Ming Lei wrote:
> tagset can't be used after blk_cleanup_queue() is returned because
> freeing tagset usually follows blk_clenup_queue(). Commit d97e594c5166
> ("blk-mq: Use request queue-wide tags for tagset-wide sbitmap") adds
> check on q->tag_set->flags in blk_mq_exit_sched(), and causes
> use-after-free.
> 
> Fixes it by using hctx->flags.

Applied, thanks.

-- 
Jens Axboe

