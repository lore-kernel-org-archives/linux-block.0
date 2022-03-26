Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4EAC433EF
	for <linux-block@archiver.kernel.org>; Sat, 26 Mar 2022 12:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiCZMCf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Mar 2022 08:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiCZMCf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Mar 2022 08:02:35 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9025326AFF
        for <linux-block@vger.kernel.org>; Sat, 26 Mar 2022 05:00:58 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id l129so16232pga.3
        for <linux-block@vger.kernel.org>; Sat, 26 Mar 2022 05:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zhpzHaewQiFA7zyinksagIouSrpHytz8zX+SwMrxXA0=;
        b=BjOHNqMW8tr1vyRnduG/FJYKr0WUjjhsS+3FDHanx1rCc7dSVIAJGY1b/l2Uw0v5xK
         Qc3+iDP+bSOLRtXr77SQJMzE1sXwom4e+efkO5uusadZEXzSWwaUZbHB80lr4jAg3liu
         uxyXd88o7hE9nxl8TqUCvhhGe1RF7CWl6YdK8Ori4peBVVxy1f4LVbL0G5N5YuiFTX+r
         b+U3/HQDCChqZhsRPpmVguI4pepL5aZUG2C0hc6Fp4mxkJgovAlK2OQ0SEXz5aKO+W0b
         /8QNpbI0f8ioJtXgaEOYzvaRs7RqEDVnlGTcwWQ/RRKLOthooM4eobg1rgclYWGfdirI
         iMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zhpzHaewQiFA7zyinksagIouSrpHytz8zX+SwMrxXA0=;
        b=uzVT9MJs6cEazvJARrJzIt8Hfbcl5j1prYMNMvfgcWt4UUTNPq7DGKElQIfkFlX4sm
         uWFhcEwelnwlgmWE28HgvE5sjYTFQT32nnFQj14eHKOBgMBb+vvITrkm8o1rQ17ltuij
         tAN3qr7Dqi75WmY+504elFSt46irbegpH1JqQJOOqiEdEe84r1c5AGILrAJf6BxweJ43
         CLeZUTIarv3mK+gfewYt2flH1br9PxOLdUXSv0P6zaV9DhM2WrJupmY9vfUxGEuorhwb
         glujWGKrgv6AyvNiG9bdAapUkMVl1D4+iawF0CZ2f662fhjE0q2VhszLyZE2lhDGyl/P
         yIhw==
X-Gm-Message-State: AOAM530C/Erw1V59WlEZh2d2tantpDdwiYcOK0Z/zmFU/Bf6zay2EcwY
        uKtWgBCgvO6qxdz8XQPfEfo=
X-Google-Smtp-Source: ABdhPJyIQK3QWEjDfNixvk999ZO5keQTyNoa+LCHUl+gYfJdtGkWE9yV4QCwA3+i+HabIF6ZlDLeLw==
X-Received: by 2002:a63:2049:0:b0:381:31b6:a317 with SMTP id r9-20020a632049000000b0038131b6a317mr3200637pgm.356.1648296058041;
        Sat, 26 Mar 2022 05:00:58 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id b16-20020a056a00115000b004f6ff260c9esm9373956pfm.207.2022.03.26.05.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 05:00:57 -0700 (PDT)
Date:   Sat, 26 Mar 2022 21:00:51 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
        mgurtovoy@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/2] virtio-blk: support polling I/O
Message-ID: <Yj8Ac/DIG9AWA12q@localhost.localdomain>
References: <20220324140450.33148-1-suwan.kim027@gmail.com>
 <20220324140450.33148-2-suwan.kim027@gmail.com>
 <20220324103056-mutt-send-email-mst@kernel.org>
 <YjyEKuKhmhML6NN3@localhost.localdomain>
 <20220324135556-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324135556-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 24, 2022 at 01:56:18PM -0400, Michael S. Tsirkin wrote:
> On Thu, Mar 24, 2022 at 11:46:02PM +0900, Suwan Kim wrote:
> > On Thu, Mar 24, 2022 at 10:32:02AM -0400, Michael S. Tsirkin wrote:
> > > On Thu, Mar 24, 2022 at 11:04:49PM +0900, Suwan Kim wrote:
> > > > This patch supports polling I/O via virtio-blk driver. Polling
> > > > feature is enabled by module parameter "num_poll_queues" and it
> > > > sets dedicated polling queues for virtio-blk. This patch improves
> > > > the polling I/O throughput and latency.
> > > > 
> > > > The virtio-blk driver doesn't not have a poll function and a poll
> > > > queue and it has been operating in interrupt driven method even if
> > > > the polling function is called in the upper layer.
> > > > 
> > > > virtio-blk polling is implemented upon 'batched completion' of block
> > > > layer. virtblk_poll() queues completed request to io_comp_batch->req_list
> > > > and later, virtblk_complete_batch() calls unmap function and ends
> > > > the requests in batch.
> > > > 
> > > > virtio-blk reads the number of poll queues from module parameter
> > > > "num_poll_queues". If VM sets queue parameter as below,
> > > > ("num-queues=N" [QEMU property], "num_poll_queues=M" [module parameter])
> > > > It allocates N virtqueues to virtio_blk->vqs[N] and it uses [0..(N-M-1)]
> > > > as default queues and [(N-M)..(N-1)] as poll queues. Unlike the default
> > > > queues, the poll queues have no callback function.
> > > > 
> > > > Regarding HW-SW queue mapping, the default queue mapping uses the
> > > > existing method that condsiders MSI irq vector. But the poll queue
> > > > doesn't have an irq, so it uses the regular blk-mq cpu mapping.
> > > > 
> > > > For verifying the improvement, I did Fio polling I/O performance test
> > > > with io_uring engine with the options below.
> > > > (io_uring, hipri, randread, direct=1, bs=512, iodepth=64 numjobs=N)
> > > > I set 4 vcpu and 4 virtio-blk queues - 2 default queues and 2 poll
> > > > queues for VM.
> > > > 
> > > > As a result, IOPS and average latency improved about 10%.
> > > > 
> > > > Test result:
> > > > 
> > > > - Fio io_uring poll without virtio-blk poll support
> > > > 	-- numjobs=1 : IOPS = 339K, avg latency = 188.33us
> > > > 	-- numjobs=2 : IOPS = 367K, avg latency = 347.33us
> > > > 	-- numjobs=4 : IOPS = 383K, avg latency = 682.06us
> > > > 
> > > > - Fio io_uring poll with virtio-blk poll support
> > > > 	-- numjobs=1 : IOPS = 380K, avg latency = 167.87us
> > > > 	-- numjobs=2 : IOPS = 409K, avg latency = 312.6us
> > > > 	-- numjobs=4 : IOPS = 413K, avg latency = 619.72us
> > > > 
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > > > ---
> > > >  drivers/block/virtio_blk.c | 101 +++++++++++++++++++++++++++++++++++--
> > > >  1 file changed, 97 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index 8c415be86732..3d16f8b753e7 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -37,6 +37,10 @@ MODULE_PARM_DESC(num_request_queues,
> > > >  		 "0 for no limit. "
> > > >  		 "Values > nr_cpu_ids truncated to nr_cpu_ids.");
> > > >  
> > > > +static unsigned int num_poll_queues;
> > > > +module_param(num_poll_queues, uint, 0644);
> > > > +MODULE_PARM_DESC(num_poll_queues, "The number of dedicated virtqueues for polling I/O");
> > > > +
> > > >  static int major;
> > > >  static DEFINE_IDA(vd_index_ida);
> > > >
> > > 
> > > Is there some way to make it work reasonably without need to set
> > > module parameters? I don't see any other devices with a num_poll_queues
> > > parameter - how do they handle this?
> > 
> > Hi Michael,
> > 
> > NVMe driver uses module parameter.
> > 
> > Please refer to this.
> > -----
> > drivers/nvme/host/pci.c
> > 
> > static unsigned int poll_queues;
> > module_param_cb(poll_queues, &io_queue_count_ops, &poll_queues, 0644);
> > MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
> > -----
> > 
> > Regards,
> > Suwan Kim
> 
> OK then. Let's maybe be consistent wrt parameter naming?
 
Ok. Consistent naming scheme seems to be better for code readability.
I will rename it to 'poll_queues' in next version.

Regards,
Suwan Kim
