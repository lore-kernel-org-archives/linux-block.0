Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE38CC001E0
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 13:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjG0NFQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 09:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjG0NFP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 09:05:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD096271B
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 06:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690463071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1isnG7RPAlxC8PwmJlqmU0SjAont741KiLDHia5auZ4=;
        b=GPWnHwkA3g/+L7WbpebELaYMWewQgBY5g5nz9eAt/NfY4ob5Iqc53yCyDAmoy5nAvsYpx7
        mHxv09y/I4hOUY4+bLvsSw4MVKiwKvUvcBJfxxhoZnhTROSg5J363fu5GBfbxLIkG5J298
        XuX/KsU37dq6jxc1XeKXt/nFa1RkBXI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-_H5DAB6JMoK0H8sWDYuQUg-1; Thu, 27 Jul 2023 09:04:30 -0400
X-MC-Unique: _H5DAB6JMoK0H8sWDYuQUg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbb0fdd060so5603535e9.0
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 06:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690463069; x=1691067869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1isnG7RPAlxC8PwmJlqmU0SjAont741KiLDHia5auZ4=;
        b=YeAqWPjs22GvtQYbz4xdCdqh/hFt5Uo+dnLyFZ/dbGc36ERYCZI4bwR/PhMuPM136A
         ivroibZHGdpKHaWvholfVfvPmjHqD8IUjdZ8Hp9u9pab48zlyGqWDBZhklLE4ui2MZg4
         P8gD1/ap4Lfn627hNhgJm01YOR3zOYt8DDAFC9OoERAygDgwjUwuW7fubUBtB6+P06Tn
         Cxpeh7XEnMVTQIhZv873wFIfc2DL6sGJ79WYiMANHYHrr44pfPLF8iGZvfv9AosmOibh
         P2OmAYmXLYlEQfY6S3NPPMMsgFnCBAiWg4uL8v5Mn997jGZzIcJi3D/ey4irIHykkLOb
         lZ/w==
X-Gm-Message-State: ABy/qLbl8AGCMxhUsXT+uQYpblsMxubnYDvL2V4fIe2/8XtE6ILugw51
        DH1LSGg73NvojI6XE/7Oz1EhdRqPGl5JBn1Y764rx99fIezn+Num2P+HgMceV4YaVeykIFRh/AA
        yDQee0+IeMHHajfW5vUTaNh4=
X-Received: by 2002:a1c:6a14:0:b0:3f9:b9e7:2f8d with SMTP id f20-20020a1c6a14000000b003f9b9e72f8dmr1604563wmc.2.1690463069301;
        Thu, 27 Jul 2023 06:04:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlExhhLTXGyPzDCcONu4xFPiGqg/ySkyxPh1aZ5MRVvQvJCRCd6wdMGefrWL/XkLbCwkjZIO8A==
X-Received: by 2002:a1c:6a14:0:b0:3f9:b9e7:2f8d with SMTP id f20-20020a1c6a14000000b003f9b9e72f8dmr1604546wmc.2.1690463068966;
        Thu, 27 Jul 2023 06:04:28 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.170.163])
        by smtp.gmail.com with ESMTPSA id p12-20020a7bcc8c000000b003fc00702f65sm4542693wma.46.2023.07.27.06.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 06:04:28 -0700 (PDT)
Date:   Thu, 27 Jul 2023 15:04:25 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH V2 2/3] ublk: fail to recover device if queue setup is
 interrupted
Message-ID: <rxoyqxdfvykob6zyp5jjuplu5fwbxohnmvah5hh3clbjk3nlvn@d52wo6beumod>
References: <20230726144502.566785-1-ming.lei@redhat.com>
 <20230726144502.566785-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230726144502.566785-3-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 26, 2023 at 10:45:01PM +0800, Ming Lei wrote:
>In ublk_ctrl_end_recovery(), if wait_for_completion_interruptible() is
>interrupted by signal, queues aren't setup successfully yet, so we
>have to fail UBLK_CMD_END_USER_RECOVERY, otherwise kernel oops can be
>triggered.
>
>Fixes: c732a852b419 ("ublk_drv: add START_USER_RECOVERY and END_USER_RECOVERY support")
>Reported-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Ming Lei <ming.lei@redhat.com>
>---
> drivers/block/ublk_drv.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>index 7938221f4f7e..9fcba3834e8d 100644
>--- a/drivers/block/ublk_drv.c
>+++ b/drivers/block/ublk_drv.c
>@@ -2324,7 +2324,9 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
> 	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
> 			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
> 	/* wait until new ubq_daemon sending all FETCH_REQ */
>-	wait_for_completion_interruptible(&ub->completion);
>+	if (wait_for_completion_interruptible(&ub->completion))
>+		return -EINTR;
>+
> 	pr_devel("%s: All new ubq_daemons(nr: %d) are ready, dev id %d\n",
> 			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
>
>-- 
>2.40.1
>

