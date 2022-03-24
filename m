Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1561C433EF
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 17:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352425AbiCXR6C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 13:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiCXR57 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 13:57:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF170B6D0F
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 10:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648144585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K1rRuvdeVE+p43mVKCo+9JbhVwz1CF9F7SMs1X4zTSk=;
        b=NBabdruepU6hlHQLhhvQQCbrLpXl30HUKIvkGJ8d4bxWc6IkP786mO2PWW7JT0JkH4AcgW
        rdgSgDltNWi0oY/4n4VttIY1/Gq5gEkLCrbvkCRpsWtH2HVYfeKthhNjomPY8F6TNIIcDB
        yhEK1zoCMk+6jBVFeuhG07/ewARtPYU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-VLvkIFA6O06yTKVIqQUvKQ-1; Thu, 24 Mar 2022 13:56:24 -0400
X-MC-Unique: VLvkIFA6O06yTKVIqQUvKQ-1
Received: by mail-wm1-f69.google.com with SMTP id q6-20020a1cf306000000b0038c5726365aso1852022wmq.3
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 10:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K1rRuvdeVE+p43mVKCo+9JbhVwz1CF9F7SMs1X4zTSk=;
        b=mO1EKFm9qIY/D7O47jKI8byvn/SR9eGwuNMB7cCWIduiG/B8D/kYnUWMo2ZZerBQie
         8g7S2Rj2J5GDGIz8f8y7Fab6atqUFBJxLe4j2QHHS7/yR3eG/BJrXZEa8iKZAKd8kELx
         wZ89CHO4kCWF0Zc/RhkkLpgkdl3JlyGw+Vr2CajrgPHs9hJ3PF9zBrYrOF46jN/2y4QH
         qwC92fRcbxEwDvAOXRWevSHCig5ozuN+P3+DKhZgrQKmR5c+e1fbCbmeYluHQ+/BMkrf
         zIa73P+hvtntQesnle6stastSWfHgYFXSwdDj0KGYoMVEuEKa7iQ4NDq9k9EBYlp2FZz
         WUYg==
X-Gm-Message-State: AOAM53239Go8DZdhrGub0xSTm5KdOUv2b5daVRQw6MNfmZL1yQHE4UAL
        h46moHuzkX31ILMnuvYNYr4859RQwl2TnOmAD636GDgpu+qtkJHxTkJ1SZ+tedk4AIvMiPMcWhg
        UHNNJPTtlhVOWJwJ8twOveMY=
X-Received: by 2002:a05:6000:10ce:b0:204:203:9c87 with SMTP id b14-20020a05600010ce00b0020402039c87mr5368420wrx.181.1648144583000;
        Thu, 24 Mar 2022 10:56:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiMTRzqgSTdtdRgb33oi/EZn8C/VD+y9bPjT79yWQxteeWRRsF3keydqYNyxNTNtpqmyRJvA==
X-Received: by 2002:a05:6000:10ce:b0:204:203:9c87 with SMTP id b14-20020a05600010ce00b0020402039c87mr5368399wrx.181.1648144582776;
        Thu, 24 Mar 2022 10:56:22 -0700 (PDT)
Received: from redhat.com ([2.55.151.118])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d53cc000000b00205a0ee9c74sm281412wrw.89.2022.03.24.10.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 10:56:22 -0700 (PDT)
Date:   Thu, 24 Mar 2022 13:56:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
        mgurtovoy@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/2] virtio-blk: support polling I/O
Message-ID: <20220324135556-mutt-send-email-mst@kernel.org>
References: <20220324140450.33148-1-suwan.kim027@gmail.com>
 <20220324140450.33148-2-suwan.kim027@gmail.com>
 <20220324103056-mutt-send-email-mst@kernel.org>
 <YjyEKuKhmhML6NN3@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjyEKuKhmhML6NN3@localhost.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 24, 2022 at 11:46:02PM +0900, Suwan Kim wrote:
> On Thu, Mar 24, 2022 at 10:32:02AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Mar 24, 2022 at 11:04:49PM +0900, Suwan Kim wrote:
> > > This patch supports polling I/O via virtio-blk driver. Polling
> > > feature is enabled by module parameter "num_poll_queues" and it
> > > sets dedicated polling queues for virtio-blk. This patch improves
> > > the polling I/O throughput and latency.
> > > 
> > > The virtio-blk driver doesn't not have a poll function and a poll
> > > queue and it has been operating in interrupt driven method even if
> > > the polling function is called in the upper layer.
> > > 
> > > virtio-blk polling is implemented upon 'batched completion' of block
> > > layer. virtblk_poll() queues completed request to io_comp_batch->req_list
> > > and later, virtblk_complete_batch() calls unmap function and ends
> > > the requests in batch.
> > > 
> > > virtio-blk reads the number of poll queues from module parameter
> > > "num_poll_queues". If VM sets queue parameter as below,
> > > ("num-queues=N" [QEMU property], "num_poll_queues=M" [module parameter])
> > > It allocates N virtqueues to virtio_blk->vqs[N] and it uses [0..(N-M-1)]
> > > as default queues and [(N-M)..(N-1)] as poll queues. Unlike the default
> > > queues, the poll queues have no callback function.
> > > 
> > > Regarding HW-SW queue mapping, the default queue mapping uses the
> > > existing method that condsiders MSI irq vector. But the poll queue
> > > doesn't have an irq, so it uses the regular blk-mq cpu mapping.
> > > 
> > > For verifying the improvement, I did Fio polling I/O performance test
> > > with io_uring engine with the options below.
> > > (io_uring, hipri, randread, direct=1, bs=512, iodepth=64 numjobs=N)
> > > I set 4 vcpu and 4 virtio-blk queues - 2 default queues and 2 poll
> > > queues for VM.
> > > 
> > > As a result, IOPS and average latency improved about 10%.
> > > 
> > > Test result:
> > > 
> > > - Fio io_uring poll without virtio-blk poll support
> > > 	-- numjobs=1 : IOPS = 339K, avg latency = 188.33us
> > > 	-- numjobs=2 : IOPS = 367K, avg latency = 347.33us
> > > 	-- numjobs=4 : IOPS = 383K, avg latency = 682.06us
> > > 
> > > - Fio io_uring poll with virtio-blk poll support
> > > 	-- numjobs=1 : IOPS = 380K, avg latency = 167.87us
> > > 	-- numjobs=2 : IOPS = 409K, avg latency = 312.6us
> > > 	-- numjobs=4 : IOPS = 413K, avg latency = 619.72us
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > > ---
> > >  drivers/block/virtio_blk.c | 101 +++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 97 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 8c415be86732..3d16f8b753e7 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -37,6 +37,10 @@ MODULE_PARM_DESC(num_request_queues,
> > >  		 "0 for no limit. "
> > >  		 "Values > nr_cpu_ids truncated to nr_cpu_ids.");
> > >  
> > > +static unsigned int num_poll_queues;
> > > +module_param(num_poll_queues, uint, 0644);
> > > +MODULE_PARM_DESC(num_poll_queues, "The number of dedicated virtqueues for polling I/O");
> > > +
> > >  static int major;
> > >  static DEFINE_IDA(vd_index_ida);
> > >
> > 
> > Is there some way to make it work reasonably without need to set
> > module parameters? I don't see any other devices with a num_poll_queues
> > parameter - how do they handle this?
> 
> Hi Michael,
> 
> NVMe driver uses module parameter.
> 
> Please refer to this.
> -----
> drivers/nvme/host/pci.c
> 
> static unsigned int poll_queues;
> module_param_cb(poll_queues, &io_queue_count_ops, &poll_queues, 0644);
> MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
> -----
> 
> Regards,
> Suwan Kim

OK then. Let's maybe be consistent wrt parameter naming?

-- 
MST

