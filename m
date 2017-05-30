Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:36542 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdE3M74 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2017 08:59:56 -0400
Received: by mail-yb0-f193.google.com with SMTP id r66so2248287yba.3
        for <linux-block@vger.kernel.org>; Tue, 30 May 2017 05:59:56 -0700 (PDT)
Date: Tue, 30 May 2017 12:59:54 +0000
From: Josef Bacik <josef@toxicpanda.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Josef Bacik <jbacik@fb.com>, nbd-general@lists.sourceforge.net,
        linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH v2 1/2] nbd: nbd_reset() call in nbd_dev_add() is
 redundant
Message-ID: <20170530125932.GA14918@li70-116.members.linode.com>
References: <1495554595-30945-1-git-send-email-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495554595-30945-1-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 23, 2017 at 05:49:54PM +0200, Ilya Dryomov wrote:
> There is nothing to clear -- nbd_device has just been allocated.
> Fold nbd_reset() into its other caller, nbd_config_put().
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Reviewed-by: Josef Bacik <jbacik@fb.com>

Thanks,

Josef
