Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB046C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 13:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD486128E
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 13:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhJTN6w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 09:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhJTN6v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 09:58:51 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50584C061746
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 06:56:37 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id a16so2112739qvm.2
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SOhTeqssi38uRwcp6bVWgkiT3zeBEjmbv5sIUX3YlqU=;
        b=hoUyPC59lX3NJhAvLcW+xrOuF/F3LgSCM2KPXyjTOAbnllVZLjCw+iYBU2Np+xrhtP
         LrM9cOJ7WfDmqHWcOOhTEGmqtJ2TtNxMQL5oiuyNhkNaefBRPJha8jntBeiQeTEGMuFH
         4gtRwUy7ER5zFEWcz1qbLuM12NcErMCteETSTR8YPfrv0Zc7rfQQbkyViiuP81s+bZm0
         Hy0fI2IekAaZo2aCZC/SKQH6vwUwmyl0LHXNgz6CxODahnEcSvAqlr+uf4rMfxyTnx39
         CZAo9OmetYEiLnWRyWPCDqbh54dg39dj9mNZ8kOcmXBwIzEHoVDmsWTQvFDkr43/nj7D
         x1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SOhTeqssi38uRwcp6bVWgkiT3zeBEjmbv5sIUX3YlqU=;
        b=Je3bWn1+Rv20OktlK07I5k8geohNT647Xtrkie9BwR3uiwr7VsaEpoVUJgwLVL0oQ2
         Hc56Xkxw269N8x+BXQwEzKaRVyst9bhXD4EhPKNjXTeMxoOhfpTkaEzrDLuLrTCyoFIG
         zkb32+F0OAxZ66OSTzvY6DMJXHNeHYeqliVMY6YaiMHv0bpR26g79dHXuCCiORq4aZSj
         cPEgBcjGUFjYap8dZWnK1xHqn5Sul7mTjFLBWBhc9VfXZf+jhIVVcOBp1wGRw5x0y8+l
         Vz2zCrgB40xlX8y5tvIRBwMR1up/mYImWiYIWhdIjYqIFnJf1TiGrcTaTyNIGYTkvo3a
         R9nQ==
X-Gm-Message-State: AOAM533LXh3udgO3p2/lIVX9aC8s3+oaWexXdwOm5z2Y81G1/qtAxN8r
        xGjcUgeSQs/mPHVNX6iSTMlD637hRqUhdA==
X-Google-Smtp-Source: ABdhPJxYhvejPIL1k6+jDvOj701OJVq1RlboIHsw8i0VCcEri6yz2aLYS3hFQP14xY7XetaBBzM2ZQ==
X-Received: by 2002:a05:6214:e41:: with SMTP id o1mr6391933qvc.0.1634738196355;
        Wed, 20 Oct 2021 06:56:36 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i67sm1007555qkd.90.2021.10.20.06.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:56:36 -0700 (PDT)
Date:   Wed, 20 Oct 2021 09:56:35 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Ye Bin <yebin10@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] nbd: Fix use-after-free in pid_show
Message-ID: <YXAgEyCjtQYkZA4A@localhost.localdomain>
References: <20211020073959.2679255-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020073959.2679255-1-yebin10@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 20, 2021 at 03:39:59PM +0800, Ye Bin wrote:
> I got issue as follows:
> [  263.886511] BUG: KASAN: use-after-free in pid_show+0x11f/0x13f
> [  263.888359] Read of size 4 at addr ffff8880bf0648c0 by task cat/746
> [  263.890479] CPU: 0 PID: 746 Comm: cat Not tainted 4.19.90-dirty #140
> [  263.893162] Call Trace:
> [  263.893509]  dump_stack+0x108/0x15f
> [  263.893999]  print_address_description+0xa5/0x372
> [  263.894641]  kasan_report.cold+0x236/0x2a8
> [  263.895696]  __asan_report_load4_noabort+0x25/0x30
> [  263.896365]  pid_show+0x11f/0x13f
> [  263.897422]  dev_attr_show+0x48/0x90
> [  263.898361]  sysfs_kf_seq_show+0x24d/0x4b0
> [  263.899479]  kernfs_seq_show+0x14e/0x1b0
> [  263.900029]  seq_read+0x43f/0x1150
> [  263.900499]  kernfs_fop_read+0xc7/0x5a0
> [  263.903764]  vfs_read+0x113/0x350
> [  263.904231]  ksys_read+0x103/0x270
> [  263.905230]  __x64_sys_read+0x77/0xc0
> [  263.906284]  do_syscall_64+0x106/0x360
> [  263.906797]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Reproduce this issue as follows:
> 1. nbd-server 8000 /tmp/disk
> 2. nbd-client localhost 8000 /dev/nbd1
> 3. cat /sys/block/nbd1/pid
> Then trigger use-after-free in pid_show.
> 
> Reason is after do step '2', nbd-client progress is already exit. So
> it's task_struct already freed.
> To solve this issue, revert part of 6521d39a64b3's modify and remove
> useless 'recv_task' member of nbd_device.
> 
> Fixes: 6521d39a64b3 ("nbd: Remove variable 'pid'")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
