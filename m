Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5DDC433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 15:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A40361019
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 15:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242031AbhIWPjX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 11:39:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54690 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241995AbhIWPjX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 11:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632411471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AOSJdORroeY+L8lMWoT/k2QmeHNRD0UxneSQj0X18oA=;
        b=SGKrJ72+QbZsCz2Wc4n0VFxztRC18W23zMWtMguGb39HpIuvz5HGcKUdCV3S8HhStgEZYg
        41it/F7g6noEjsPXtm6KfN0lK8nBfW3EuIdEc5BOVI59svTQRH4x2BpSxUiItGW5ltxRvU
        blViAp4dnPtzuECSNu3yBzeIv4pIxzc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-J73WndtAMrWCZNcion-_4w-1; Thu, 23 Sep 2021 11:37:49 -0400
X-MC-Unique: J73WndtAMrWCZNcion-_4w-1
Received: by mail-ed1-f72.google.com with SMTP id b7-20020a50e787000000b003d59cb1a923so7249247edn.5
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 08:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AOSJdORroeY+L8lMWoT/k2QmeHNRD0UxneSQj0X18oA=;
        b=0z5nnUdTut7SKy2HwdRr3+xB4lg/Xv7PMQCR5j1/5DUGjJjoBIl58cYP6bQwLgjk3X
         DgscHIVH8MQaJakrB+mhPQVBGz0wXUJnosiKT7ZUpfA/Wr3AgWpYDgn0dZFYfXTBcKH4
         gA15vmwVHBrRAs14F+QcjPWkbOi/kh6FTYbZllVAeEErpMKRvkFIVklHGEZKRdXZPIf+
         6Rh9FzAf+zw6zmbLBNKItXQhQjSjS0LAnWhorq8A7JnuFB/Guo44XpW960snUSprArb8
         loVZO4cUqRBrgCHRn4z0SfUdwTrNh5O+ZVI+6W8SpNDX/JICzx6yxTWt74lJ/k3ZY+9s
         nifw==
X-Gm-Message-State: AOAM533wAtfTFcQ0PLABMPh+6daCipJu4aEW2FaKlL5BG2sNQN8Qudq+
        fMqqJk/IKPn6g/6zA/3vrKuLHD4UofWdNOetr6FLS0/1Za+bSGeIYDQKsCjPB71LXx6aXCauCpI
        r58/g3YMTAcZ1k7Fx1DGrDyk=
X-Received: by 2002:a50:d84c:: with SMTP id v12mr6078249edj.201.1632411468257;
        Thu, 23 Sep 2021 08:37:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8DaBe4I+LkOVyQLu6cfQoWkqvgiBaOR5+1qn3bcBVQnRix8ZU/+hekqhUIynodgC4qCiRWw==
X-Received: by 2002:a50:d84c:: with SMTP id v12mr6078219edj.201.1632411468054;
        Thu, 23 Sep 2021 08:37:48 -0700 (PDT)
Received: from redhat.com ([2.55.11.56])
        by smtp.gmail.com with ESMTPSA id d3sm3738711edv.87.2021.09.23.08.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 08:37:47 -0700 (PDT)
Date:   Thu, 23 Sep 2021 11:37:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        israelr@nvidia.com, nitzanc@nvidia.com, oren@nvidia.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3 1/1] virtio-blk: avoid preallocating big SGL for data
Message-ID: <20210923113644-mutt-send-email-mst@kernel.org>
References: <20210901131434.31158-1-mgurtovoy@nvidia.com>
 <YTYvOetMHvocg9UZ@stefanha-x1.localdomain>
 <692f8e81-8585-1d39-e7a4-576ae01438a1@nvidia.com>
 <YUCUF7co94CRGkGU@stefanha-x1.localdomain>
 <56cf84e2-fec0-08e8-0a47-24bb1df71883@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56cf84e2-fec0-08e8-0a47-24bb1df71883@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

OK by me.
Acked-by: Michael S. Tsirkin <mst@redhat.com>

I will queue it for the next kernel.
Thanks!


On Thu, Sep 23, 2021 at 04:40:56PM +0300, Max Gurtovoy wrote:
> Hi MST/Jens,
> 
> Do we need more review here or are we ok with the code and the test matrix ?
> 
> If we're ok, we need to decide if this goes through virtio PR or block PR.
> 
> Cheers,
> 
> -Max.
> 
> On 9/14/2021 3:22 PM, Stefan Hajnoczi wrote:
> > On Mon, Sep 13, 2021 at 05:50:21PM +0300, Max Gurtovoy wrote:
> > > On 9/6/2021 6:09 PM, Stefan Hajnoczi wrote:
> > > > On Wed, Sep 01, 2021 at 04:14:34PM +0300, Max Gurtovoy wrote:
> > > > > No need to pre-allocate a big buffer for the IO SGL anymore. If a device
> > > > > has lots of deep queues, preallocation for the sg list can consume
> > > > > substantial amounts of memory. For HW virtio-blk device, nr_hw_queues
> > > > > can be 64 or 128 and each queue's depth might be 128. This means the
> > > > > resulting preallocation for the data SGLs is big.
> > > > > 
> > > > > Switch to runtime allocation for SGL for lists longer than 2 entries.
> > > > > This is the approach used by NVMe drivers so it should be reasonable for
> > > > > virtio block as well. Runtime SGL allocation has always been the case
> > > > > for the legacy I/O path so this is nothing new.
> > > > > 
> > > > > The preallocated small SGL depends on SG_CHAIN so if the ARCH doesn't
> > > > > support SG_CHAIN, use only runtime allocation for the SGL.
> > > > > 
> > > > > Re-organize the setup of the IO request to fit the new sg chain
> > > > > mechanism.
> > > > > 
> > > > > No performance degradation was seen (fio libaio engine with 16 jobs and
> > > > > 128 iodepth):
> > > > > 
> > > > > IO size      IOPs Rand Read (before/after)         IOPs Rand Write (before/after)
> > > > > --------     ---------------------------------    ----------------------------------
> > > > > 512B          318K/316K                                    329K/325K
> > > > > 
> > > > > 4KB           323K/321K                                    353K/349K
> > > > > 
> > > > > 16KB          199K/208K                                    250K/275K
> > > > > 
> > > > > 128KB         36K/36.1K                                    39.2K/41.7K
> > > > I ran fio randread benchmarks with 4k, 16k, 64k, and 128k at iodepth 1,
> > > > 8, and 64 on two vCPUs. The results look fine, there is no significant
> > > > regression.
> > > > 
> > > > iodepth=1 and iodepth=64 are very consistent. For some reason the
> > > > iodepth=8 has significant variance but I don't think it's the fault of
> > > > this patch.
> > > > 
> > > > Fio results and the Jupyter notebook export are available here (check
> > > > out benchmark.html to see the graphs):
> > > > 
> > > > https://gitlab.com/stefanha/virt-playbooks/-/tree/virtio-blk-sgl-allocation-benchmark/notebook
> > > > 
> > > > Guest:
> > > > - Fedora 34
> > > > - Linux v5.14
> > > > - 2 vCPUs (pinned), 4 GB RAM (single host NUMA node)
> > > > - 1 IOThread (pinned)
> > > > - virtio-blk aio=native,cache=none,format=raw
> > > > - QEMU 6.1.0
> > > > 
> > > > Host:
> > > > - RHEL 8.3
> > > > - Linux 4.18.0-240.22.1.el8_3.x86_64
> > > > - Intel(R) Xeon(R) Silver 4214 CPU @ 2.20GHz
> > > > - Intel Optane DC P4800X
> > > > 
> > > > Stefan
> > > Thanks, Stefan.
> > > 
> > > Would you like me to add some of the results in my commit msg ? or Tested-By
> > > sign ?
> > Thanks, there's no need to change the commit description.
> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Tested-by: Stefan Hajnoczi <stefanha@redhat.com>

