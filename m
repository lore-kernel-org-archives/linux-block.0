Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE680C433F5
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 13:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbiERNU2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 09:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237693AbiERNU0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 09:20:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8C595A37
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 06:20:25 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q18so1723990pln.12
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 06:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Lg1D5Qm4BDqJMULWClrb7DX6ufaCCxR8vhVSmS6AT0=;
        b=ijSurQhTwYxB1uG0BKuAV2Dl/A8iCb9fd7gQvUnAlrIDGLmkARYozsQD5bcO8+XLXN
         Ohhbgfhz9XaHtYHeQ2J69BerCmjyL+WDLLiCbaiMR2EPiisHfp9UdOZMGFClDo6pstzX
         LMQgYNiqB9EVMwp4mx4+r6lGukw2xmxVIT42buRVlY740bdDO8TmeoMyAjUaoMlZFVPJ
         efv/g/z/zAi3wMxwvd5wdYoGkuJiUbo4iNtr0y/rSewIydV0Zw3IiipTFWiT1J5wZJK0
         M9mIlqyStp+Rb12iZeFDaS1a7oNkbH0cqYaS5bFcoj7u1hEgMKo7AjwuRs+Od7Crglz4
         OQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Lg1D5Qm4BDqJMULWClrb7DX6ufaCCxR8vhVSmS6AT0=;
        b=R7SJeVPzXj61W7lYFDXaiHEHvYfXi1E+YfwbvcncerTIFIzNZWWYXTqAqciziMku1r
         wyQyZH1eN7qlbbDufsBVw6CTd4TT0dAn9ptUq6YgY0iqswakSbUY4c+PRCnRvv2vWwlU
         c+zsLjeqERhlMXuImaAEqbqW45FWIcVQiuhN1B3xj8vMjqHeMvsF8DrOLGFYqWNFmefe
         CnxyEZa45FWjJD+3qLUzL373dcmm1L1jcb2ZleG89EqETNiWuzvJ4ouX76XHEeu+e9V7
         sXCcaD0RXAa7oveRqDc1t26zrCAFm1pCBoVeHDCxodOlBIgxPxVmVo5wCx24D3CWXZml
         nCkw==
X-Gm-Message-State: AOAM530scJiMP8vipGuyj4CScwLnL82B0gAOmNDoZPqmzo5tCFTHyCuS
        Q72nf6cmcAKEN8+ngr3CNn4=
X-Google-Smtp-Source: ABdhPJwgTd6Yx8Xqrny4el0jRVRI7/Qrx3ZIQCoWFnA2VSwDglIGqGOPruHKDexB1n0atOylsIpm4g==
X-Received: by 2002:a17:902:b418:b0:15f:713:c914 with SMTP id x24-20020a170902b41800b0015f0713c914mr27586311plr.171.1652880025351;
        Wed, 18 May 2022 06:20:25 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id v10-20020a62a50a000000b00518285976cdsm1653791pfm.9.2022.05.18.06.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 06:20:24 -0700 (PDT)
Date:   Wed, 18 May 2022 22:20:15 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, jasowang@redhat.com,
        stefanha@redhat.com, pbonzini@redhat.com, mgurtovoy@nvidia.com,
        dongli.zhang@oracle.com, hch@infradead.org, elliott@hpe.com
Subject: Re: [PATCH v6 0/2] virtio-blk: support polling I/O and
 mq_ops->queue_rqs()
Message-ID: <YoTyj26L2gViyKoX@localhost.localdomain>
References: <20220406153207.163134-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406153207.163134-1-suwan.kim027@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 07, 2022 at 12:32:05AM +0900, Suwan Kim wrote:
> This patch serise adds support for polling I/O and mq_ops->queue_rqs()
> to virtio-blk driver.
> 
> Changes
> 
> v5 -> v6
>     - patch1 : virtblk_poll
>         - Remove memset in init_vq()
>         - Fix space indent in init_vq()
>         - Replace if condition with positive check in virtblk_map_queues()
>                 if (i == HCTX_TYPE_POLL)
>                         blk_mq_map_queues(&set->map[i]);
>                 else
>                         blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);
>         - Add Reviewed-by tags
>     
>     - patch2 : virtio_queue_rqs
>         - Add Reviewed-by tags
> 
> v4 -> v5
>     - patch1 : virtblk_poll
>         - Replace "req_done" with "found" in virtblk_poll()
>         - Split for loop into two distinct for loop in init_vq()
>           that sets callback function for each default/poll queues
>         - Replace "if (i == HCTX_TYPE_DEFAULT)" with "i != HCTX_TYPE_POLL"
>           in virtblk_map_queues()
>         - Replace "virtblk_unmap_data(req, vbr);" with
>           "virtblk_unmap_data(req, blk_mq_rq_to_pdu(req);"
>           in virtblk_complete_batch()
>     
>     - patch2 : virtio_queue_rqs
>         - Instead of using vbr.sg_num field, use vbr->sg_table.nents.
>           So, remove sg_num field in struct virtblk_req
>         - Drop the unnecessary argument of virtblk_add_req() because it
>           doens't need "data_sg" and "have_data". It can be derived from "vbr"
>           argument.
>         - Add Reviewed-by tag from Stefan
> 
> v3 -> v4
>     - patch1 : virtblk_poll
>         - Add print the number of default/read/poll queues in init_vq()
>         - Add blk_mq_start_stopped_hw_queues() to virtblk_poll()
>               virtblk_poll()
>                   ...
>                   if (req_done)
>                                    blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
>                   ...
> 
>     - patch2 : virtio_queue_rqs
>         - Modify virtio_queue_rqs() to hold lock only once when it adds
>           requests to virtqueue just before virtqueue notify.
>           It will guarantee that virtio_queue_rqs() will not use
>           previous req again.
> 
> v2 -> v3
>         - Fix warning by kernel test robot
>           
>             static int virtblk_poll()
>                 ...
>                 if (!blk_mq_add_to_batch(req, iob, virtblk_result(vbr),
>                                                    -> vbr->status,
> 
> v1 -> v2
>         - To receive the number of poll queues from user,
>           use module parameter instead of QEMU uapi change.
> 
>         - Add the comment about virtblk_map_queues().
> 
>         - Add support for mq_ops->queue_rqs() to implement submit side
>           batch.
> 
> Suwan Kim (2):
>   virtio-blk: support polling I/O
>   virtio-blk: support mq_ops->queue_rqs()
> 
>  drivers/block/virtio_blk.c | 220 +++++++++++++++++++++++++++++++++----
>  1 file changed, 201 insertions(+), 19 deletions(-)
> 
> -- 
> 2.26.3

Hi Michael,

Can these patches be merged to your branch?

Regards,
Suwan Kim
