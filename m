Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDAEC433F5
	for <linux-block@archiver.kernel.org>; Tue,  5 Apr 2022 05:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiDEFXr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiDEFXl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Apr 2022 01:23:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188AC10FCD
        for <linux-block@vger.kernel.org>; Mon,  4 Apr 2022 22:21:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id p17so9966759plo.9
        for <linux-block@vger.kernel.org>; Mon, 04 Apr 2022 22:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FyLi/S87mkDf4UMTLyda6whXeR0lbQvjV0wYG3X31JM=;
        b=fZxG5oT5yxLJO7pjAE+NtchsPofB+TT1oP71rmsSRgWTrA408BbtW8BnOCn+Aj+Y9K
         ZXhdidnOpi3tokHjaxLbezq1ILWbs3tX3T7pQ6RevcNDKxDnWn8FFQxIeNhZJN6hKwKM
         a2kwD9KJjZQ7J6lh2pFOqxDMX5WxoMRHkCCeH+wgJOgGPJ3vK6x52e13ayzitMoxazYf
         /vqxCQmPG+4s8uks2fE0ChWPmfITp3RC0uUveiPVMrhalI6HFVEGUn4cP0zWOF8voa7f
         U35bleLF0JMGOiONhY3YvtXsF9usjWNDr4xsROx3J/XzEM2BSgmc0oEIMcIVNqKWh0RR
         jAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FyLi/S87mkDf4UMTLyda6whXeR0lbQvjV0wYG3X31JM=;
        b=14SffEFQdRcMDnCQLZc7OkQvew8z4nAX7MszF02/VS+dkQCDzbij/j3cyqOPhIUmEQ
         mlR/7HZDrR8Qg3spci0l4asjBIBSaMqjdvrZMeR8s2QgCsd73/+DtignLQAHmy3bqWWy
         ymLYr58DgEE557wuCrjR9yO3WJh81TOEF22F+d66DlHJf8lgp/PG599g8LM9NqHjN3TU
         dWI4vDUIBdBN15Q7kerkq2/yL3iOr4U0LZgTsy7m3EdlpcFFGQu+kujMENZjrivf0rVf
         8h9blZV/QNEjsY6hbF4kZ0AnKffkV/LrKl1ggZyWHIo/XOtwDWEalx8VmmKQ6bwsZJYh
         /0Lg==
X-Gm-Message-State: AOAM532ed7cqWGfT2WKNpTll8A3yJHtcX8wOZ2DTSsLzslIuVRyvKKtv
        kK6TqS+gbHf4AeRb7z76L3s=
X-Google-Smtp-Source: ABdhPJzxOE1spc4UxeB617/JRSISmBdLsoskpJO9V7kvyyDdKalzfWBuFvGXprNkksaLStzkzlTcrA==
X-Received: by 2002:a17:902:db0e:b0:154:8682:c1db with SMTP id m14-20020a170902db0e00b001548682c1dbmr1792725plx.128.1649136081460;
        Mon, 04 Apr 2022 22:21:21 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id f4-20020a056a0022c400b004fb2292cd74sm13807594pfj.206.2022.04.04.22.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 22:21:20 -0700 (PDT)
Date:   Tue, 5 Apr 2022 14:21:15 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com, dongli.zhang@oracle.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v4 1/2] virtio-blk: support polling I/O
Message-ID: <YkvRy2LvsOP9OppN@localhost.localdomain>
References: <20220404092805.77643-1-suwan.kim027@gmail.com>
 <20220404092805.77643-2-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404092805.77643-2-suwan.kim027@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 04, 2022 at 06:28:04PM +0900, Suwan Kim wrote:
> This patch supports polling I/O via virtio-blk driver. Polling
> feature is enabled by module parameter "num_poll_queues" and it
> sets dedicated polling queues for virtio-blk. This patch improves
> the polling I/O throughput and latency.
> 
> The virtio-blk driver doesn't not have a poll function and a poll
> queue and it has been operating in interrupt driven method even if
> the polling function is called in the upper layer.
> 
> virtio-blk polling is implemented upon 'batched completion' of block
> layer. virtblk_poll() queues completed request to io_comp_batch->req_list
> and later, virtblk_complete_batch() calls unmap function and ends
> the requests in batch.
> 
> virtio-blk reads the number of poll queues from module parameter
> "num_poll_queues". If VM sets queue parameter as below,
> ("num-queues=N" [QEMU property], "num_poll_queues=M" [module parameter])
> It allocates N virtqueues to virtio_blk->vqs[N] and it uses [0..(N-M-1)]
> as default queues and [(N-M)..(N-1)] as poll queues. Unlike the default
> queues, the poll queues have no callback function.
> 
> Regarding HW-SW queue mapping, the default queue mapping uses the
> existing method that condsiders MSI irq vector. But the poll queue
> doesn't have an irq, so it uses the regular blk-mq cpu mapping.
> 
> For verifying the improvement, I did Fio polling I/O performance test
> with io_uring engine with the options below.
> (io_uring, hipri, randread, direct=1, bs=512, iodepth=64 numjobs=N)
> I set 4 vcpu and 4 virtio-blk queues - 2 default queues and 2 poll
> queues for VM.
> 
> As a result, IOPS and average latency improved about 10%.
> 
> Test result:
> 
> - Fio io_uring poll without virtio-blk poll support
> 	-- numjobs=1 : IOPS = 339K, avg latency = 188.33us
> 	-- numjobs=2 : IOPS = 367K, avg latency = 347.33us
> 	-- numjobs=4 : IOPS = 383K, avg latency = 682.06us
> 
> - Fio io_uring poll with virtio-blk poll support
> 	-- numjobs=1 : IOPS = 385K, avg latency = 165.94us
> 	-- numjobs=2 : IOPS = 408K, avg latency = 313.28us
> 	-- numjobs=4 : IOPS = 424K, avg latency = 613.05us
> 
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
>  drivers/block/virtio_blk.c | 112 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 108 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 8c415be86732..c2d955da0006 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -37,6 +37,10 @@ MODULE_PARM_DESC(num_request_queues,
>  		 "0 for no limit. "
>  		 "Values > nr_cpu_ids truncated to nr_cpu_ids.");
>  
> +static unsigned int num_poll_queues;
> +module_param(num_poll_queues, uint, 0644);
> +MODULE_PARM_DESC(num_poll_queues, "The number of dedicated virtqueues for polling I/O");
 
Sorry. I forgot to fix the parameter name.
I resended this path.

Regards,
Suwan Kim
