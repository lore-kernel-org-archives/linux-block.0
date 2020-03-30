Return-Path: <SRS0=FzxQ=5P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FDEC2D0E7
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 01:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A09F20748
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 01:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3jWR2bT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgC3BAp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Mar 2020 21:00:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22928 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727815AbgC3BAo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Mar 2020 21:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585530043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/C+48h0ffEUHH3oF9o5G29hLSACeot3EfusEOYHKZmU=;
        b=S3jWR2bTxpYQOwksIfqoEjBvG3ZvjYdiyILBYtrjkjCheC9+6sxVeXqwHa2uE6ATE2mQBG
        p5Bg//4sGwWbuA6jlHnuXfxCTYfIMeNeYT5PDTRZZ1rnDUgkBc5/Rep4/mo8zixpWPOTt0
        DYRSR5OyAA6ljbD+mHgdd0RgJO8GVxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-UK2ptt_yPRejILgn1C9Y9A-1; Sun, 29 Mar 2020 21:00:39 -0400
X-MC-Unique: UK2ptt_yPRejILgn1C9Y9A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2E3C800D5B;
        Mon, 30 Mar 2020 01:00:37 +0000 (UTC)
Received: from ming.t460p (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3D8F97AF7;
        Mon, 30 Mar 2020 01:00:29 +0000 (UTC)
Date:   Mon, 30 Mar 2020 09:00:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] loop: Add LOOP_SET_FD_WITH_OFFSET ioctl.
Message-ID: <20200330010024.GA23640@ming.t460p>
References: <20200329140459.18155-1-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329140459.18155-1-maco@android.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 29, 2020 at 04:04:59PM +0200, Martijn Coenen wrote:
> Configuring a loop device for a filesystem that is located at an offset
> currently requires calling LOOP_SET_FD and LOOP_SET_STATUS(64)
> consecutively. This has some downsides.
> 
> The most important downside is that it can be slow. Here's setting
> up ~70 regular loop devices on an x86 Android device:
> 
> vsoc_x86:/system/apex # time for i in `seq 30 100`;
> do losetup -r /dev/block/loop$i com.android.adbd.apex; done
>     0m01.85s real     0m00.01s user     0m00.01s system
> 
> Here's configuring ~70 devices in the same way, but with an offset:
> 
> vsoc_x86:/system/apex # time for i in `seq 30 100`;
> do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done
>     0m03.40s real     0m00.02s user     0m00.03s system
> 
> This is almost twice as slow; the main reason for this slowness is that
> LOOP_SET_STATUS(64) calls blk_mq_freeze_queue() to freeze the associated
> queue; this requires waiting for RCU synchronization, which I've
> measured can take about 15-20ms on this device on average.
> 
> A more minor downside of having to do two ioctls is that on devices with
> max_part > 0, the kernel will initiate a partition scan, which is
> needless work if the image is at an offset.
> 
> This change introduces a new ioctl to combine setting the backing file
> together with the offset, which avoids the above problems. Adding more
> parameters could be a consideration, but offset appears to be the only
> commonly used parameter that is required for accessing the device
> safely.

The new ioctl LOOP_SET_FD_WITH_OFFSET looks not generic enough, could
you consider to add one ioctl LOOP_SET_FD_AND_STATUS to cover both
SET_FD and SET_STATUS so that using two ioctl() to setup loop can become
deprecated finally?


Thanks,
Ming

