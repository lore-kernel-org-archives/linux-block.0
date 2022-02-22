Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21002C433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 01:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbiBVBnu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Feb 2022 20:43:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238510AbiBVBnq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Feb 2022 20:43:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50FD0255A1
        for <linux-block@vger.kernel.org>; Mon, 21 Feb 2022 17:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645494201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NzjAem9tlu54IyZrw9QsYOzEU0mhjZkov0DubyCaMYo=;
        b=XhkWGceDBZ6g+XGmrUtMoqMrty9vZWKshQHh41rkbqjP3T3e0J8ClkHjawJcSVsy4hVMcY
        s1jGT5dDZayKbjtDNSQIdNg5XU4Fy0Pt3TzbM0HlaJendzfmDO2ERybvNpyNWnM7KNEbZl
        l+avdRdoW29oSo5yMqUpPRKs11sjx5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-_8Yt6BTYOHqmhKsiuDG6VQ-1; Mon, 21 Feb 2022 20:43:18 -0500
X-MC-Unique: _8Yt6BTYOHqmhKsiuDG6VQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCA498017FE;
        Tue, 22 Feb 2022 01:43:16 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D7E735DF21;
        Tue, 22 Feb 2022 01:43:09 +0000 (UTC)
Date:   Tue, 22 Feb 2022 09:43:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: clear iocb->private in blkdev_bio_end_io_async()
Message-ID: <YhQ/qM6S34TwVCSq@T590>
References: <20220211090136.44471-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211090136.44471-1-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 11, 2022 at 10:01:36AM +0100, Stefano Garzarella wrote:
> iocb_bio_iopoll() expects iocb->private to be cleared before
> releasing the bio.
> 
> We already do this in blkdev_bio_end_io(), but we forgot in the

But also iomap_dio_bio_end_io().

> recently added blkdev_bio_end_io_async().
> 
> Fixes: 54a88eb838d3 ("block: add single bio async direct IO helper")
> Cc: asml.silence@gmail.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> I haven't seen a failure, I was just reading the code to understand iopoll,
> so IIUC we should clean iocb->private in blkdev_bio_end_io_async().
> 
> Thanks,
> Stefano
> ---
>  block/fops.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 4f59e0f5bf30..a18e7fbd97b8 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -289,6 +289,8 @@ static void blkdev_bio_end_io_async(struct bio *bio)
>  	struct kiocb *iocb = dio->iocb;
>  	ssize_t ret;
>  
> +	WRITE_ONCE(iocb->private, NULL);

It might cause race in case of concurrent polling on same queue without
clearing iocb->private, so looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

