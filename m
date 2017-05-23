Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36330 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935930AbdEWOOu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2017 10:14:50 -0400
Received: by mail-qk0-f175.google.com with SMTP id u75so130857871qka.3
        for <linux-block@vger.kernel.org>; Tue, 23 May 2017 07:14:49 -0700 (PDT)
Date: Tue, 23 May 2017 10:14:46 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Josef Bacik <jbacik@fb.com>, nbd-general@lists.sourceforge.net,
        linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nbd: don't leak nbd_config
Message-ID: <20170523141445.GA1568@destiny>
References: <1495535911-29036-1-git-send-email-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495535911-29036-1-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 23, 2017 at 12:38:31PM +0200, Ilya Dryomov wrote:
> nbd_config is allocated in nbd_alloc_config(), but never freed.
> 
> Fixes: 5ea8d10802ec ("nbd: separate out the config information")
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  drivers/block/nbd.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Oops, thanks Ilya

Reviewed-by: Josef Bacik <jbacik@fb.com>

Josef
