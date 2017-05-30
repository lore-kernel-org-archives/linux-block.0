Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35663 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbdE3NAY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2017 09:00:24 -0400
Received: by mail-yw0-f173.google.com with SMTP id l74so39421815ywe.2
        for <linux-block@vger.kernel.org>; Tue, 30 May 2017 06:00:24 -0700 (PDT)
Date: Tue, 30 May 2017 13:00:22 +0000
From: Josef Bacik <josef@toxicpanda.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Josef Bacik <jbacik@fb.com>, nbd-general@lists.sourceforge.net,
        linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH v2 2/2] nbd: don't leak nbd_config
Message-ID: <20170530130021.GB14918@li70-116.members.linode.com>
References: <1495554595-30945-1-git-send-email-idryomov@gmail.com>
 <1495554595-30945-2-git-send-email-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495554595-30945-2-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 23, 2017 at 05:49:55PM +0200, Ilya Dryomov wrote:
> nbd_config is allocated in nbd_alloc_config(), but never freed.
> 
> Fixes: 5ea8d10802ec ("nbd: separate out the config information")
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Reviewed-by: Josef Bacik <jbacik@fb.com>

Thanks,

Josef
