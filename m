Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35548 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753226AbdDDRJz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 13:09:55 -0400
Received: by mail-qk0-f175.google.com with SMTP id g195so75382721qke.2
        for <linux-block@vger.kernel.org>; Tue, 04 Apr 2017 10:09:54 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH 0/5] blk-mq: scheduler and hw queue initialization
 fixes/enhancements
From: Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <cover.1491254827.git.osandov@fb.com>
Date: Tue, 4 Apr 2017 13:09:50 -0400
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com
Message-Id: <78AB53B3-941B-4108-8474-80D88581C0F7@toxicpanda.com>
References: <cover.1491254827.git.osandov@fb.com>
To: Omar Sandoval <osandov@osandov.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On Apr 3, 2017, at 5:42 PM, Omar Sandoval <osandov@osandov.com> wrote:
> 
> From: Omar Sandoval <osandov@fb.com>
> 
> Hi, Jens,
> 
> This series has some fixes and enhancements for blk-mq:
> 
> - Patch 1 is a cleanup in preparation for the rest of the series
> - Patch 2 is a fix necessary for patch 4 when scheduling is enabled,
>  making sure we bring up new hardware queues with scheduler tags
> - Patch 3 makes error handling in elevator_switch() more robust, making
>  us fall back to none like you recommended last time
> - Patch 4 is the remap fix from last week
> - Patch 5 is an extension of patch 2 for multiqueue schedulers that
>  allocate per-hctx data. Nothing in-tree needs it, but Kyber will.
> 
> Let me know if you'd prefer deferring this to 4.12 or want to apply 1-4
> for 4.11. These are based on block/for-next, so the latter might require
> a respin.

Tested with nbd, didn't crash, you can add

Tested-by: Josef Bacik <jbacik@fb.com>

Thanks,

Josef
