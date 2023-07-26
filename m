Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDD0C0015E
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 14:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjGZOR2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbjGZORQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 10:17:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBE530E3
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 07:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690380888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JJpjmI2aabdN7NzGlCLKIz/7VjweKRXZFBLGEVXAnFI=;
        b=aZVd1zqBaYzV3qUMrk19h2vUMhbgBhmqfrogT86QsHMLpuEd9mARysRvPY84TOEr9538VW
        KQKsVXsk7PRefuL9yLiVzMHCPr9vOyVFv60NjYv/N+s7mkX/6KdDOOswaEiVU94lw+JtQe
        TMbd+3ASkeGayZlo3EzsgPl4BCtpk8Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-xhuM-kSzOuunx1sNhj7J-Q-1; Wed, 26 Jul 2023 10:14:45 -0400
X-MC-Unique: xhuM-kSzOuunx1sNhj7J-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94793185A794;
        Wed, 26 Jul 2023 14:14:43 +0000 (UTC)
Received: from ovpn-8-25.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9618E1121330;
        Wed, 26 Jul 2023 14:14:40 +0000 (UTC)
Date:   Wed, 26 Jul 2023 22:14:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH] ublk: fail to start device if queue setup is interrupted
Message-ID: <ZMEqStPNpCHEnAgU@ovpn-8-25.pek2.redhat.com>
References: <20230726113901.546569-1-ming.lei@redhat.com>
 <vgp5ck6lubjvfqwfjcsabsbjdq7qfkl3ashospz3ybrcq6fmwd@fq3r3vixsp5u>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vgp5ck6lubjvfqwfjcsabsbjdq7qfkl3ashospz3ybrcq6fmwd@fq3r3vixsp5u>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 26, 2023 at 03:30:34PM +0200, Stefano Garzarella wrote:
> On Wed, Jul 26, 2023 at 07:39:01PM +0800, Ming Lei wrote:
> > In ublk_ctrl_start_dev(), if wait_for_completion_interruptible() is
> > interrupted by signal, queues aren't setup successfully yet, so we
> > have to fail UBLK_CMD_START_DEV, otherwise kernel oops can be triggered.
> > 
> > Reported by German when working for supporting ublk on qemu-storage-deamon
> > which requires single thread ublk daemon.
> > 
> > Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
> > Reported-by: German Maglione <gmaglione@redhat.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> > drivers/block/ublk_drv.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 1c823750c95a..7938221f4f7e 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1847,7 +1847,8 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
> > 	if (ublksrv_pid <= 0)
> > 		return -EINVAL;
> > 
> > -	wait_for_completion_interruptible(&ub->completion);
> > +	if (wait_for_completion_interruptible(&ub->completion) != 0)
> > +		return -EINTR;
> 
> Should we do somenthig similar also in ublk_ctrl_end_recovery()?

Good catch, ublk_ctrl_end_recovery() do need similar handling, otherwise
similar kernel oops may be triggered too.

> 
> Maybe also in ublk_ctrl_del_dev() we can return -EINTR.
 
It doesn't matter for ublk_ctrl_del_dev() given it just waits for
existed users, but still good to return -EINTR to user.


Thanks,
Ming

