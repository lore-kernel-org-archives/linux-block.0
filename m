Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34680 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753022AbdAZUFZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 15:05:25 -0500
Received: by mail-pf0-f178.google.com with SMTP id e4so67310338pfg.1
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2017 12:05:25 -0800 (PST)
Date: Thu, 26 Jan 2017 12:04:57 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, bart.vanassche@sandisk.com,
        hch@lst.de, osandov@fb.com, paolo.valente@linaro.org, hare@suse.com
Subject: Re: [PATCH 2/5] blk-mq: fix potential race in queue restart and
 driver tag allocation
Message-ID: <20170126200457.GB21449@vader.DHCP.thefacebook.com>
References: <1485460098-16608-1-git-send-email-axboe@fb.com>
 <1485460098-16608-3-git-send-email-axboe@fb.com>
 <e70e18cb-56fc-ca03-8845-8b1a1dea6953@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e70e18cb-56fc-ca03-8845-8b1a1dea6953@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jan 26, 2017 at 12:52:15PM -0700, Jens Axboe wrote:
> I screwed this up when splitting up the patchset, that last break needs to
> be removed as well, of course. Updated below:
> 
> 
> From 9d68cf9232c06a793e305d10b6d655df4beae928 Mon Sep 17 00:00:00 2001
> From: Jens Axboe <axboe@fb.com>
> Date: Thu, 26 Jan 2017 12:50:36 -0700
> Subject: [PATCH 1/4] blk-mq: fix potential race in queue restart and driver
>  tag allocation
> 
> Once we mark the queue as needing a restart, re-check if we can
> get a driver tag. This fixes a theoretical issue where the needed
> IO completes _after_ blk_mq_get_driver_tag() fails, but before we
> manage to set the restart bit.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-mq.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
