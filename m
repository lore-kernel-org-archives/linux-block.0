Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A9CC001DC
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 13:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjGZNbf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 09:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjGZNbY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 09:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6F2AC
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690378240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UgwLLEQSbCzFw8KrqsOC4qZI9xtNYzUN8bp/N08jGqY=;
        b=L5pnIgNNll6LHOXM4Nzc73XG+0OvmrpiTny0+HBjOvUVVn30LxmDxo1aRfCQwBFpZ4TMLd
        zOoXjY6Louwan6kugCOvbRdd8kW5DWcITCEqfjrVK5bgNFGUZGTXffSKkFC18xZOFvNgXB
        yX6JLdFAKT38qMukbwiRPBjxaGRJc1g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-rWDvMVAGN_aQ3WMFT6Dz9Q-1; Wed, 26 Jul 2023 09:30:39 -0400
X-MC-Unique: rWDvMVAGN_aQ3WMFT6Dz9Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99bcf6ae8e1so11753566b.0
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 06:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690378238; x=1690983038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgwLLEQSbCzFw8KrqsOC4qZI9xtNYzUN8bp/N08jGqY=;
        b=KjblubLvmAyHrJmXYM62NuW2bbqx7j3YtQIPUuJLCm4UpanQEg0lzkNh4wQ9xy4eBi
         xk8jV2tRbuQWekVr5V92UEAf6pJQ8wTGGXAzvbAAYq/HHajVGzN/jxD+vMHqvFx+tabH
         rlywYyWgLW+eN2X3TQx32NLVR1BjAGgJBAJ3sQB4CtsFtoEvHTAw0BH/BsbX635MK4YK
         PzrYjPsi97Ugx+4hYjlttobW94gQdAH2kflXlK5nqP+XNcFxnacmwPjIrIziKJQf6Pox
         6aP/DzCe6NF3O6LgWOT3PXmPczNBuIRKGaCB+pr2Nxpl2g0UqtKRisLHGOhdRWiA0QeR
         m1oQ==
X-Gm-Message-State: ABy/qLYdv0dbR7xWUtuLHKHXJozOeX/VmdOHUxDTq8Tn2GIE6nJLHdxh
        G1ctcN1DeNWDXy6FpPq7Lk9ONf2h9D/leW1E/M/DQZFq96QR4/D+5j3Nq9SnGDKcTMEnh89Qx78
        eOsCShab27DIAMhtfkZ58X4LrAPybYRo=
X-Received: by 2002:a17:906:5183:b0:993:ea6b:edf6 with SMTP id y3-20020a170906518300b00993ea6bedf6mr1858127ejk.0.1690378237763;
        Wed, 26 Jul 2023 06:30:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFQ2xBuFYn8p9lOQMqqsEOoaD8oLAwEGcuw+WDIta+LXGC/VxHCUNIsED3dtbzniASM8OauMA==
X-Received: by 2002:a17:906:5183:b0:993:ea6b:edf6 with SMTP id y3-20020a170906518300b00993ea6bedf6mr1858111ejk.0.1690378237408;
        Wed, 26 Jul 2023 06:30:37 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.111.137])
        by smtp.gmail.com with ESMTPSA id v15-20020a17090606cf00b00985bdb7dd5fsm9494089ejb.201.2023.07.26.06.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:30:36 -0700 (PDT)
Date:   Wed, 26 Jul 2023 15:30:34 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH] ublk: fail to start device if queue setup is interrupted
Message-ID: <vgp5ck6lubjvfqwfjcsabsbjdq7qfkl3ashospz3ybrcq6fmwd@fq3r3vixsp5u>
References: <20230726113901.546569-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230726113901.546569-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 26, 2023 at 07:39:01PM +0800, Ming Lei wrote:
>In ublk_ctrl_start_dev(), if wait_for_completion_interruptible() is
>interrupted by signal, queues aren't setup successfully yet, so we
>have to fail UBLK_CMD_START_DEV, otherwise kernel oops can be triggered.
>
>Reported by German when working for supporting ublk on qemu-storage-deamon
>which requires single thread ublk daemon.
>
>Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
>Reported-by: German Maglione <gmaglione@redhat.com>
>Signed-off-by: Ming Lei <ming.lei@redhat.com>
>---
> drivers/block/ublk_drv.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>index 1c823750c95a..7938221f4f7e 100644
>--- a/drivers/block/ublk_drv.c
>+++ b/drivers/block/ublk_drv.c
>@@ -1847,7 +1847,8 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
> 	if (ublksrv_pid <= 0)
> 		return -EINVAL;
>
>-	wait_for_completion_interruptible(&ub->completion);
>+	if (wait_for_completion_interruptible(&ub->completion) != 0)
>+		return -EINTR;

Should we do somenthig similar also in ublk_ctrl_end_recovery()?

Maybe also in ublk_ctrl_del_dev() we can return -EINTR.

Thanks,
Stefano

