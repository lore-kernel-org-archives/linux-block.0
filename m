Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F29C433F5
	for <linux-block@archiver.kernel.org>; Mon, 21 Feb 2022 11:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356780AbiBULu2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:50:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356753AbiBULuY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Feb 2022 06:50:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A0E61EEED
        for <linux-block@vger.kernel.org>; Mon, 21 Feb 2022 03:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645444200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0wG221QCPx+Q7Gy4fg1L/dcv5+8A+ksizB/DtqLJOdc=;
        b=L+oq+NRfjWlqdjMt3A4GqblQxVStj/zchRxt46NGhBm/bSu9X2aOzocBcRfbhneaBeU4R4
        7Y89x5Zo2MTgclaRmHa25OF13m7mWiUhOYw+XRll4UQxm7nyYpT7kwBC+3AtdR6cdybASJ
        xoav7+HMmODwyRHQHUT+1POYVZTDxNc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-Ul73XiStMHOyWPIhuEGdnQ-1; Mon, 21 Feb 2022 06:49:59 -0500
X-MC-Unique: Ul73XiStMHOyWPIhuEGdnQ-1
Received: by mail-lj1-f197.google.com with SMTP id e17-20020a2ea551000000b002464772387fso111970ljn.1
        for <linux-block@vger.kernel.org>; Mon, 21 Feb 2022 03:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0wG221QCPx+Q7Gy4fg1L/dcv5+8A+ksizB/DtqLJOdc=;
        b=csca+DYnaNrf692xmSPuZho8hD0/1RqG2L61q2ZePjoPJ9xo0+PMzMGTnVxPrpBy1z
         KBLv8DlfGBClkYSDnbGeiFA6aCWsvDsdgdwZZS/aabW9Q1NWAePAypFB30tbot7gCnAh
         eSp3ge2pw3Jr6uRvIDAfq3nk6a8bNIX89B5diVwK4C+xUVDC6bRU7TOfu+AVSKhpDyAY
         BaFDEltMERaG4FUgOBarjsLkPrrgYocqmObQonU6Yps/vDHgGu9gvNQoDqdOxwaQDRUN
         85nVRwHQOwQILTxJah7EznuA/aBrblpVCJlCx69ywkU+mP6lAQABbWQ6erLvodkJmpdy
         Mg7A==
X-Gm-Message-State: AOAM531DTWRl7PvSwZm5Eh+gWldsz3ko4u9ODmxPTSB3aMecySyXqF+b
        XQ4bV7CdAGo/WsHEICXIePbj2Rd/YlaPPL1GpV16H9NRWPH8SVXMxjRHZ+uhww941mFlFZP5b0l
        UE9n4qdqI4IVkflQyjJhHDuPOrHJj9GKrb2o5AtA=
X-Received: by 2002:a2e:7c16:0:b0:246:377b:f802 with SMTP id x22-20020a2e7c16000000b00246377bf802mr5965127ljc.155.1645444197263;
        Mon, 21 Feb 2022 03:49:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmmC5oMBlfqAp9wDl1bQBZqXug/sy5mFp+bVc/ugLlb6ngJeeFostTV5S9nbV6RdG1H2dweVUqafoP39gKGtk=
X-Received: by 2002:a2e:7c16:0:b0:246:377b:f802 with SMTP id
 x22-20020a2e7c16000000b00246377bf802mr5965116ljc.155.1645444197067; Mon, 21
 Feb 2022 03:49:57 -0800 (PST)
MIME-Version: 1.0
References: <20220211090136.44471-1-sgarzare@redhat.com>
In-Reply-To: <20220211090136.44471-1-sgarzare@redhat.com>
From:   Stefano Garzarella <sgarzare@redhat.com>
Date:   Mon, 21 Feb 2022 12:49:45 +0100
Message-ID: <CAGxU2F6+m4pa7gzqvFL1OGLCc8sFDjRwhXZruFi41PQMs-XRew@mail.gmail.com>
Subject: Re: [PATCH] block: clear iocb->private in blkdev_bio_end_io_async()
To:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Gentle ping :-)


On Fri, Feb 11, 2022 at 10:01 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> iocb_bio_iopoll() expects iocb->private to be cleared before
> releasing the bio.
>
> We already do this in blkdev_bio_end_io(), but we forgot in the
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
>         struct kiocb *iocb = dio->iocb;
>         ssize_t ret;
>
> +       WRITE_ONCE(iocb->private, NULL);
> +
>         if (likely(!bio->bi_status)) {
>                 ret = dio->size;
>                 iocb->ki_pos += ret;
> --
> 2.34.1
>

