Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F75DC433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 13:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348840AbiCON40 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 09:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348843AbiCON4Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 09:56:25 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE21C53E35
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 06:55:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q13so16274615plk.12
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 06:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rreCok8vzicRcja1MAOk3ddejNqWt31gVRhHyT6/Blw=;
        b=aQB787zOWekDsctFsSzkP2fkrPg+ZIAHORN6CvluugP2i7JOtzn0q85k4XVySMPOKy
         q7f6aZuYMPImZj9TO4UtagI8wIT0jl+tSsfG4lrPssIvibrf9yvf6kzpeNzelG5HFVx7
         yW+aoyC9zTWHq/0gLYVfa6Tf6m8eUnjM0iCcJVWx61KkSNr0jIsxnjj5pTx22nkcdAwP
         X3nqBHVQVbzei6b7yW7ZWSR4sJxSyOcS87jdjUCeEdyVCzb+jfhSlYXJpoaOjpGp6vS9
         NdaBcCUDYnFUqFBJyZMB9NrJHYLcWl6ErpgvmYlnJ4rwFUUkfrAsm8+QwKmNyacrIJds
         7mhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rreCok8vzicRcja1MAOk3ddejNqWt31gVRhHyT6/Blw=;
        b=vAC+b3glaCOLBLvgmiysse3ev1SVvMtsKzSGKCs4skW2kXoGgj+OFd/M3IybxsA203
         qF9HrFmiixg8b058daqmmStSqeZ4FlOcgunqQYSw0G1mS4RTJDW9WEWhL2H71uI8S4GR
         ggMZxlb6EnHQij/kU9qM1YXeezvsD12kpYFEiWG1ot4FPt+jkCWZuy47yznv8bEw+RGN
         CUBgdaRTLkrsu7/LWX2QdmausFfA9CmpCw1ZqC19PxKcbvujxdbiF9+l8uVRGw1wflal
         TsMqLd0YYYLbhXwIl6hE1Xsd+8pTSvRCt2nHJBbjMe3w95frEVipNlClSwSLWGkBpTjP
         KyOg==
X-Gm-Message-State: AOAM532VX5/QpjesWr7PLQPDUTlbN9bsKi0fTR/AH5QP2wvgk1K6PNeG
        gfzjL3pDJoKE9n1gmrCoZQdJRl5hyFT9/A==
X-Google-Smtp-Source: ABdhPJxGbiCV592QjzyGD2tCSnqOdFu4gpCwZqbFi7QXWDHBFWCzbh0IrRGMTw8j6dzGQid76rjuaw==
X-Received: by 2002:a17:902:dac1:b0:151:952a:8821 with SMTP id q1-20020a170902dac100b00151952a8821mr27443359plx.11.1647352511151;
        Tue, 15 Mar 2022 06:55:11 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id y19-20020a056a00181300b004f7203ad991sm25520323pfa.210.2022.03.15.06.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 06:55:10 -0700 (PDT)
Date:   Tue, 15 Mar 2022 22:55:04 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, mgurtovoy@nvidia.com
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <YjCauO0lb2mzQENJ@localhost.localdomain>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <Yi9c5bhdDrQ1pLDY@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi9c5bhdDrQ1pLDY@stefanha-x1.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 14, 2022 at 03:19:01PM +0000, Stefan Hajnoczi wrote:
> On Sat, Mar 12, 2022 at 12:28:32AM +0900, Suwan Kim wrote:
> > This patch supports polling I/O via virtio-blk driver. Polling
> > feature is enabled based on "VIRTIO_BLK_F_MQ" feature and the number
> > of polling queues can be set by QEMU virtio-blk-pci property
> > "num-poll-queues=N". This patch improves the polling I/O throughput
> > and latency.
> > 
> > The virtio-blk driver doesn't not have a poll function and a poll
> > queue and it has been operating in interrupt driven method even if
> > the polling function is called in the upper layer.
> > 
> > virtio-blk polling is implemented upon 'batched completion' of block
> > layer. virtblk_poll() queues completed request to io_comp_batch->req_list
> > and later, virtblk_complete_batch() calls unmap function and ends
> > the requests in batch.
> > 
> > virtio-blk reads the number of queues and poll queues from QEMU
> > virtio-blk-pci properties ("num-queues=N", "num-poll-queues=M").
> > It allocates N virtqueues to virtio_blk->vqs[N] and it uses [0..(N-M-1)]
> > as default queues and [(N-M)..(N-1)] as poll queues. Unlike the default
> > queues, the poll queues have no callback function.
> > 
> > Regarding HW-SW queue mapping, the default queue mapping uses the
> > existing method that condsiders MSI irq vector. But the poll queue
> > doesn't have an irq, so it uses the regular blk-mq cpu mapping.
> > 
> > To enable poll queues, "num-poll-queues=N" property of virtio-blk-pci
> > needs to be added to QEMU command line. For that, I temporarily
> > implemented the property on QEMU. Please refer to the git repository below.
> > 
> > 	git : https://github.com/asfaca/qemu.git #on master branch commit
> > 
> > For verifying the improvement, I did Fio polling I/O performance test
> > with io_uring engine with the options below.
> > (io_uring, hipri, randread, direct=1, bs=512, iodepth=64 numjobs=N)
> > I set 4 vcpu and 4 virtio-blk queues - 2 default queues and 2 poll
> > queues for VM.
> > (-device virtio-blk-pci,num-queues=4,num-poll-queues=2)
> > As a result, IOPS and average latency improved about 10%.
> > 
> > Test result:
> > 
> > - Fio io_uring poll without virtio-blk poll support
> > 	-- numjobs=1 : IOPS = 297K, avg latency = 214.59us
> > 	-- numjobs=2 : IOPS = 360K, avg latency = 363.88us
> > 	-- numjobs=4 : IOPS = 289K, avg latency = 885.42us
> > 
> > - Fio io_uring poll with virtio-blk poll support
> > 	-- numjobs=1 : IOPS = 332K, avg latency = 192.61us
> > 	-- numjobs=2 : IOPS = 371K, avg latency = 348.31us
> > 	-- numjobs=4 : IOPS = 321K, avg latency = 795.93us
> 
> Last year there was a patch series that switched regular queues into
> polling queues when HIPRI requests were in flight:
> https://lore.kernel.org/linux-block/20210520141305.355961-1-stefanha@redhat.com/T/
> 
> The advantage is that polling is possible without prior device
> configuration, making it easier for users.
> 
> However, the dynamic approach is a bit more complex and bugs can result
> in lost irqs (hung I/O). Christoph Hellwig asked for dedicated polling
> queues, which your patch series now delivers.
> 
> I think your patch series is worth merging once the comments others have
> already made have been addressed. I'll keep an eye out for the VIRTIO
> spec change to extend the virtio-blk configuration space, which needs to
> be accepted before the Linux can be merged.

Thanks for the feedback :)
There's a lot of history.. I will try to improve the patch.

It might take some time because it need more discussion about qemu
device property and I do this in my night time.

> > @@ -728,16 +749,82 @@ static const struct attribute_group *virtblk_attr_groups[] = {
> >  static int virtblk_map_queues(struct blk_mq_tag_set *set)
> >  {
> >  	struct virtio_blk *vblk = set->driver_data;
> > +	int i, qoff;
> > +
> > +	for (i = 0, qoff = 0; i < set->nr_maps; i++) {
> > +		struct blk_mq_queue_map *map = &set->map[i];
> > +
> > +		map->nr_queues = vblk->io_queues[i];
> > +		map->queue_offset = qoff;
> > +		qoff += map->nr_queues;
> > +
> > +		if (map->nr_queues == 0)
> > +			continue;
> > +
> > +		if (i == HCTX_TYPE_DEFAULT)
> > +			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);
> > +		else
> > +			blk_mq_map_queues(&set->map[i]);
> 
> A comment would be nice here to explain that regular queues have
> interrupts and hence CPU affinity is defined by the core virtio code,
> but polling queues have no interrupts so we let the block layer assign
> CPU affinity.

Okay. I will add the comment in v2.

Regards,
Suwan Kim
