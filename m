Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51D4C433EF
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 14:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbiCXOrm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 10:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348500AbiCXOrl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 10:47:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1FCAA02A
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 07:46:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e5so4909580pls.4
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 07:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WISKDUteM5NcAOm1Q8SPPpsBI0zUWDomUyUHIXbTjJE=;
        b=GILWGvN/EjRWdY+Y0SN7oCw8g23m0sHKSHghLFT2fYac3k6OsXmJugTMK0QuILZGjS
         3PzbIRHZegVqXjLf3D1dJSx4KFNMt0eiqpoJN2m0ypLI0EJjMyVf+y74fzw+F8gk01jr
         dJRxPAYyk+fgrHIlv2gYdskDKobEaKKce+/V5NKJ8IebionxAMwe6C0Js/Q+SWx0d2bG
         tE+RN6mb8WYVGyCPqGTiFfdyICydBxhCbzjUfLL10deUPlux3oY6u5WwmMcsPnmtWOJa
         UCDbIItsBcHP7CvVxEfbQ0ykZvFZghnfvOXSLND9VY0WRlwlei8fHJYl0wRuJL6uXl7q
         Lg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WISKDUteM5NcAOm1Q8SPPpsBI0zUWDomUyUHIXbTjJE=;
        b=GZPG+vj7WS2Xys7AAw47CSDquuChO4IkNVu4fUbmsSrPwOSnraszjxD6FK/TDLxxqt
         Ya+SYsfMNgZwwvF7QgbbOGSgWHRSnGxQqWCP/UAb6TE506HWRhPhhopVuSP083h4pZTq
         Hm19/VqHGHB2jy0p9S8TANffvJqZ+WSRGsRKy3YDg7PjlfHW9y4M6hvgwXgozwHHBRjR
         BlINz10QUqRueySLWM9NRCUoGKI8+6mVb1LvrXvlB3zQgb3wPDliF8JOmG5ORNKWjZUf
         wHC6BSow9gzf6iqF14LCfYjYyKH4KlltjYe8ohPeJUVG3QQOaS2SvpUG/rP3YFewvRO2
         mlhw==
X-Gm-Message-State: AOAM53353w9y+IWQ76NOBMgAReqOx8rdaaBOwE7esO+CguqMhxpbyXMZ
        TQGf0MZxW6fVlX1OOGwpKzM=
X-Google-Smtp-Source: ABdhPJx4AmitG5S3OXAp8ZnRhZsx/mdg2jp4kTRu0Uf32son+v7C+FVhTDQBq2qQnE2B7X0p97NElw==
X-Received: by 2002:a17:902:ce8c:b0:154:af35:381e with SMTP id f12-20020a170902ce8c00b00154af35381emr6353303plg.144.1648133169322;
        Thu, 24 Mar 2022 07:46:09 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id p10-20020a637f4a000000b00373a2760775sm2874348pgn.2.2022.03.24.07.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 07:46:08 -0700 (PDT)
Date:   Thu, 24 Mar 2022 23:46:02 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
        mgurtovoy@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/2] virtio-blk: support polling I/O
Message-ID: <YjyEKuKhmhML6NN3@localhost.localdomain>
References: <20220324140450.33148-1-suwan.kim027@gmail.com>
 <20220324140450.33148-2-suwan.kim027@gmail.com>
 <20220324103056-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324103056-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 24, 2022 at 10:32:02AM -0400, Michael S. Tsirkin wrote:
> On Thu, Mar 24, 2022 at 11:04:49PM +0900, Suwan Kim wrote:
> > This patch supports polling I/O via virtio-blk driver. Polling
> > feature is enabled by module parameter "num_poll_queues" and it
> > sets dedicated polling queues for virtio-blk. This patch improves
> > the polling I/O throughput and latency.
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
> > virtio-blk reads the number of poll queues from module parameter
> > "num_poll_queues". If VM sets queue parameter as below,
> > ("num-queues=N" [QEMU property], "num_poll_queues=M" [module parameter])
> > It allocates N virtqueues to virtio_blk->vqs[N] and it uses [0..(N-M-1)]
> > as default queues and [(N-M)..(N-1)] as poll queues. Unlike the default
> > queues, the poll queues have no callback function.
> > 
> > Regarding HW-SW queue mapping, the default queue mapping uses the
> > existing method that condsiders MSI irq vector. But the poll queue
> > doesn't have an irq, so it uses the regular blk-mq cpu mapping.
> > 
> > For verifying the improvement, I did Fio polling I/O performance test
> > with io_uring engine with the options below.
> > (io_uring, hipri, randread, direct=1, bs=512, iodepth=64 numjobs=N)
> > I set 4 vcpu and 4 virtio-blk queues - 2 default queues and 2 poll
> > queues for VM.
> > 
> > As a result, IOPS and average latency improved about 10%.
> > 
> > Test result:
> > 
> > - Fio io_uring poll without virtio-blk poll support
> > 	-- numjobs=1 : IOPS = 339K, avg latency = 188.33us
> > 	-- numjobs=2 : IOPS = 367K, avg latency = 347.33us
> > 	-- numjobs=4 : IOPS = 383K, avg latency = 682.06us
> > 
> > - Fio io_uring poll with virtio-blk poll support
> > 	-- numjobs=1 : IOPS = 380K, avg latency = 167.87us
> > 	-- numjobs=2 : IOPS = 409K, avg latency = 312.6us
> > 	-- numjobs=4 : IOPS = 413K, avg latency = 619.72us
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > ---
> >  drivers/block/virtio_blk.c | 101 +++++++++++++++++++++++++++++++++++--
> >  1 file changed, 97 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 8c415be86732..3d16f8b753e7 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -37,6 +37,10 @@ MODULE_PARM_DESC(num_request_queues,
> >  		 "0 for no limit. "
> >  		 "Values > nr_cpu_ids truncated to nr_cpu_ids.");
> >  
> > +static unsigned int num_poll_queues;
> > +module_param(num_poll_queues, uint, 0644);
> > +MODULE_PARM_DESC(num_poll_queues, "The number of dedicated virtqueues for polling I/O");
> > +
> >  static int major;
> >  static DEFINE_IDA(vd_index_ida);
> >
> 
> Is there some way to make it work reasonably without need to set
> module parameters? I don't see any other devices with a num_poll_queues
> parameter - how do they handle this?

Hi Michael,

NVMe driver uses module parameter.

Please refer to this.
-----
drivers/nvme/host/pci.c

static unsigned int poll_queues;
module_param_cb(poll_queues, &io_queue_count_ops, &poll_queues, 0644);
MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
-----

Regards,
Suwan Kim
