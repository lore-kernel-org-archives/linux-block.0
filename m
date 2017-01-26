Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35072 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753232AbdAZUOP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 15:14:15 -0500
Received: by mail-pf0-f181.google.com with SMTP id f144so67559071pfa.2
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2017 12:13:33 -0800 (PST)
Date: Thu, 26 Jan 2017 12:06:05 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, bart.vanassche@sandisk.com,
        hch@lst.de, osandov@fb.com, paolo.valente@linaro.org, hare@suse.com
Subject: Re: [PATCH 3/5] blk-mq: release driver tag on a requeue event
Message-ID: <20170126200605.GC21449@vader.DHCP.thefacebook.com>
References: <1485460098-16608-1-git-send-email-axboe@fb.com>
 <1485460098-16608-4-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485460098-16608-4-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jan 26, 2017 at 12:48:16PM -0700, Jens Axboe wrote:
> We don't want to hold on to this resource when we have a scheduler
> attached.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-mq.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
