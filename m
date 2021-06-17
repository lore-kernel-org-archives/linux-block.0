Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D709EC2B9F4
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 23:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8941613B4
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 23:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhFQXF4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 19:05:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232858AbhFQXFz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 19:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623971027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OhGqlyXvaaFw2B5uHoKSC4OTwAR38tQvd3nojT+L3Tc=;
        b=FTL7RKadd0/pBfsUfLmTXZLAq54v74KH7yqI1bu0hxc/abIsWDzIS+ysgZVaKDSgYJWrho
        Y/Ud+XoaH5ZkgR7DEmbjvXJPiNfcvXSMmRMzr/b6In9CQ2N6l4hYFBM3tKFoKqauWKGEUg
        DfOxbFOlrXerp+B/YRSoTfxXJV8xONg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-_vdYYZ5cPdu6VIzrIhdnnA-1; Thu, 17 Jun 2021 19:03:43 -0400
X-MC-Unique: _vdYYZ5cPdu6VIzrIhdnnA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F0B7801ADF;
        Thu, 17 Jun 2021 23:03:42 +0000 (UTC)
Received: from T590 (ovpn-12-22.pek2.redhat.com [10.72.12.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7F716062C;
        Thu, 17 Jun 2021 23:03:35 +0000 (UTC)
Date:   Fri, 18 Jun 2021 07:03:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Kristian Klausen <kristian@klausen.dk>
Cc:     linux-block@vger.kernel.org, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] loop: Fix missing discard support when using
 LOOP_CONFIGURE
Message-ID: <YMvUw3E51fvezQN/@T590>
References: <20210617221158.7045-1-kristian@klausen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617221158.7045-1-kristian@klausen.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 18, 2021 at 12:11:57AM +0200, Kristian Klausen wrote:

Commit log?

> Cc: <stable@vger.kernel.org> # 5.8.x-
> Fixes: 3448914e8cc5 ("loop: Add LOOP_CONFIGURE ioctl")
> Signed-off-by: Kristian Klausen <kristian@klausen.dk>
> ---
> Tested like so (without the patch):
> losetup 2.37<= uses LOOP_CONFIGURE instead of LOOP_SET_STATUS64[1]
> 
> # fallocate -l100M disk.img
> # rmmod loop
> # losetup --version
> losetup from util-linux 2.36.2
> # losetup --find --show disk.img
> /dev/loop0
> # grep '' /sys/devices/virtual/block/loop0/queue/*discard*
> /sys/devices/virtual/block/loop0/queue/discard_granularity:4096
> /sys/devices/virtual/block/loop0/queue/discard_max_bytes:4294966784
> /sys/devices/virtual/block/loop0/queue/discard_max_hw_bytes:4294966784
> /sys/devices/virtual/block/loop0/queue/discard_zeroes_data:0
> /sys/devices/virtual/block/loop0/queue/max_discard_segments:1
> # losetup -d /dev/loop0
> # [update util-linux]
> # losetup --version
> losetup from util-linux 2.37
> # rmmod loop
> # losetup --find --show disk.img
> /dev/loop0
> # grep '' /sys/devices/virtual/block/loop0/queue/*discard*
> /sys/devices/virtual/block/loop0/queue/discard_granularity:0
> /sys/devices/virtual/block/loop0/queue/discard_max_bytes:0
> /sys/devices/virtual/block/loop0/queue/discard_max_hw_bytes:0
> /sys/devices/virtual/block/loop0/queue/discard_zeroes_data:0
> /sys/devices/virtual/block/loop0/queue/max_discard_segments:1
> 
> 
> With the patch applied:
> 
> # losetup --version
> losetup from util-linux 2.37
> # rmmod loop
> # losetup --find --show disk.img
> /dev/loop0
> # grep '' /sys/devices/virtual/block/loop0/queue/*discard*
> /sys/devices/virtual/block/loop0/queue/discard_granularity:4096
> /sys/devices/virtual/block/loop0/queue/discard_max_bytes:4294966784
> /sys/devices/virtual/block/loop0/queue/discard_max_hw_bytes:4294966784
> /sys/devices/virtual/block/loop0/queue/discard_zeroes_data:0
> /sys/devices/virtual/block/loop0/queue/max_discard_segments:1
> 
> [1] https://github.com/karelzak/util-linux/pull/1152
> 
>  drivers/block/loop.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 76e12f3482a9..ec957f6d8a49 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1168,6 +1168,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  	if (partscan)
>  		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
>  
> +	loop_config_discard(lo);
> +

It could be better to move loop_config_discard() around
loop_update_rotational/loop_update_dio(), then we setup everything
before updating loop as Lo_bound.

Otherwise, this patch looks fine.


Thanks,
Ming

