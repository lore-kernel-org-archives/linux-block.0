Return-Path: <SRS0=iV0P=SO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3D4C10F13
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 02:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AD520818
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 02:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKViAC7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfDLCoI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 22:44:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39967 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfDLCoI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 22:44:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so9116401wmi.5;
        Thu, 11 Apr 2019 19:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/toW658Jx0EmzqsuUJtG3mE8bQ8AWHN5N7B4zV30izw=;
        b=dKViAC7/tzkMpAOTYvNWVyyeB/Jxw+97/bomJq+vOs1NTnZ8hdGuHOJt3SFgTUYdgT
         alUcT1Bsz7dgWgKVfWX0fSnji3heR1dg2qd5t33+nA97HQbPh32HZQCwpJj22ywPvUK2
         UV30+sHsaBSCHcy5QAdii3GaIDgZ/2ETvqcyB4RGITHfdunZooPtieZwm675D67y26Oo
         58Xqso/c02OH2x7QKK+Ctr0U+/uqLpsCgb3Km0hCEqJQyMdi5tv7ClGrWieCNiBBM7T9
         YB5qU9pfPKGWzLlfsVq5MGqJ5/yw2Xm4Ee9U/1CZP5mSgfMDAXGowPvY5Y3HYg4Npi8v
         EXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/toW658Jx0EmzqsuUJtG3mE8bQ8AWHN5N7B4zV30izw=;
        b=VNQvczHnQal8NpasqzJzI/LKTCJXciz+9FUtGn6qrR/VLMDCy5yJp4zd2WGhHM57f1
         +UIZS2P+9PZJKPCgAqijaoDIVUNHS8WnCBq2zvqYM7+o95s2n1YY3afiV2YUgwpSbojn
         SobIKK/28a4QoxDKN98uQrmqmP0cZ/e7BR03wj2AZlI1ArITjebroB+2mYieOBjNNURx
         GWG6pzDSff5FwFgqDr4eKdRG090d8wilK4OFqLJ4wW5azlgg1K4lATaGIXptORtCwjMs
         08pETngkVmOeHSTHrU+xO5sOI/GDr6V2kgesKS1BDpVOqqdyNbqbVoBSP+H7L5mbOT6t
         UQwA==
X-Gm-Message-State: APjAAAV6UzQY2qc8OoWItJFxYo95pQby3eajtjN06IfFi/wnSpK1tv5j
        5f3kd/SHLVHLCvi+kLkWadyAg0xNZ3i8rJrG2wZgZ1tz2jw=
X-Google-Smtp-Source: APXvYqwmncL72qsx5z5Gy52vQqUE9OiTEtrYRx8EXv9YHxmSWhJXT+roVK+WARPwFvBHTazaknZdiZ1ge/uMbqaw5Lo=
X-Received: by 2002:a7b:c00b:: with SMTP id c11mr8621230wmb.23.1555037046115;
 Thu, 11 Apr 2019 19:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190412020916.1160-1-yanaijie@huawei.com>
In-Reply-To: <20190412020916.1160-1-yanaijie@huawei.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 12 Apr 2019 10:43:54 +0800
Message-ID: <CACVXFVP4ZKrRH6r2dKhGU_DyNYXcdPU0YbOtjn9+0NkRpMpmuw@mail.gmail.com>
Subject: Re: [PATCH v2] block: fix the return errno for direct IO
To:     Jason Yan <yanaijie@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miaoxie@huawei.com, zhaohongjiang@huawei.com,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 12, 2019 at 9:53 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> If the last bio returned is not dio->bio, the status of the bio will
> not assigned to dio->bio if it is error. This will cause the whole IO
> status wrong.
>
>     ksoftirqd/21-117   [021] ..s.  4017.966090:   8,0    C   N 4883648 [0]
>           <idle>-0     [018] ..s.  4017.970888:   8,0    C  WS 4924800 + 1024 [0]
>           <idle>-0     [018] ..s.  4017.970909:   8,0    D  WS 4935424 + 1024 [<idle>]
>           <idle>-0     [018] ..s.  4017.970924:   8,0    D  WS 4936448 + 321 [<idle>]
>     ksoftirqd/21-117   [021] ..s.  4017.995033:   8,0    C   R 4883648 + 336 [65475]
>     ksoftirqd/21-117   [021] d.s.  4018.001988: myprobe1: (blkdev_bio_end_io+0x0/0x168) bi_status=7
>     ksoftirqd/21-117   [021] d.s.  4018.001992: myprobe: (aio_complete_rw+0x0/0x148) x0=0xffff802f2595ad80 res=0x12a000 res2=0x0
>
> We always have to assign bio->bi_status to dio->bio.bi_status because we
> will only check dio->bio.bi_status when we return the whole IO to
> the upper layer.
>
> Fixes: 542ff7bf18c6 ("block: new direct I/O implementation")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>
> v2: remove white space changes
>
>  fs/block_dev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 78d3257435c0..24615c76c1d0 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -307,10 +307,10 @@ static void blkdev_bio_end_io(struct bio *bio)
>         struct blkdev_dio *dio = bio->bi_private;
>         bool should_dirty = dio->should_dirty;
>
> -       if (dio->multi_bio && !atomic_dec_and_test(&dio->ref)) {
> -               if (bio->bi_status && !dio->bio.bi_status)
> -                       dio->bio.bi_status = bio->bi_status;
> -       } else {
> +       if (bio->bi_status && !dio->bio.bi_status)
> +               dio->bio.bi_status = bio->bi_status;
> +
> +       if (!dio->multi_bio || atomic_dec_and_test(&dio->ref)) {
>                 if (!dio->is_sync) {
>                         struct kiocb *iocb = dio->iocb;
>                         ssize_t ret;
> --
> 2.17.2
>

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


-- 
Ming Lei
