Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33542 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752950AbdAZU0d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 15:26:33 -0500
Received: by mail-pg0-f44.google.com with SMTP id 204so75115896pge.0
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2017 12:26:33 -0800 (PST)
Date: Thu, 26 Jan 2017 11:59:04 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, bart.vanassche@sandisk.com,
        hch@lst.de, osandov@fb.com, paolo.valente@linaro.org, hare@suse.com
Subject: Re: [PATCH 1/5] blk-mq: improve scheduler queue sync/async running
Message-ID: <20170126195904.GA21449@vader.DHCP.thefacebook.com>
References: <1485460098-16608-1-git-send-email-axboe@fb.com>
 <1485460098-16608-2-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485460098-16608-2-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jan 26, 2017 at 12:48:14PM -0700, Jens Axboe wrote:
> We'll use the same criteria for whether we need to run the queue sync
> or async when we have a scheduler, as we do without one.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-mq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
