Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34088 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936121AbcIPUAy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Sep 2016 16:00:54 -0400
Received: by mail-pa0-f51.google.com with SMTP id wk8so28825564pab.1
        for <linux-block@vger.kernel.org>; Fri, 16 Sep 2016 13:00:53 -0700 (PDT)
Date: Fri, 16 Sep 2016 13:00:52 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: account higher order dispatch
Message-ID: <20160916200052.GA10270@vader.DHCP.thefacebook.com>
References: <80fca3d5-7c21-bce1-11db-2010a459a774@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <80fca3d5-7c21-bce1-11db-2010a459a774@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 15, 2016 at 03:16:49PM -0600, Jens Axboe wrote:
> We currently account a '0' dispatch, and anything above that still falls
> below the range set by BLK_MQ_MAX_DISPATCH_ORDER. If we dispatch more,
> we don't account it.
> 
> Change the last bucket to be inclusive of anything above the range we
> track, and have the sysfs file reflect that by including a '+' in the
> output:
> 
> $ cat /sys/block/nvme0n1/mq/0/dispatched
>        0	1006
>        1	20229
>        2	1
>        4	0
>        8	0
>       16	0
>       32+	0
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>

Reviewed-by: Omar Sandoval <osandov@fb.com>

-- 
Omar
