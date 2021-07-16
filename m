Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5633C636C8
	for <linux-block@archiver.kernel.org>; Fri, 16 Jul 2021 02:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B96DC613E3
	for <linux-block@archiver.kernel.org>; Fri, 16 Jul 2021 02:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhGPCUR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 22:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28433 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231700AbhGPCUQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 22:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626401842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xH/TRM8foZTWUQLSjAJ2X8KgsgHS1xKxBQmH3zlF46Q=;
        b=RoDQj7tVjYRarzIDh7H1dNkeGl4xi0Vg/BQ4HdfbYgz65odgBd1o6CYcB6P8gOSHfbufml
        TF5U3NSmx4xzyKt+MiGESEpx5T9uY1LRYCPgNmiyjnNgu+alBDQbAQDfn/5u8Bh+CC8Wka
        xY5V72MmVA9eKRTdt2MloGJ/Cn+7OHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-ltgwyPi5MGmZffKxO3yu6g-1; Thu, 15 Jul 2021 22:17:19 -0400
X-MC-Unique: ltgwyPi5MGmZffKxO3yu6g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AD4B824F8B;
        Fri, 16 Jul 2021 02:17:17 +0000 (UTC)
Received: from T590 (ovpn-13-153.pek2.redhat.com [10.72.13.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E1415C1BB;
        Fri, 16 Jul 2021 02:17:08 +0000 (UTC)
Date:   Fri, 16 Jul 2021 10:17:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed
 if any irq is managed
Message-ID: <YPDsICZLRxIlsUrG@T590>
References: <20210715120844.636968-1-ming.lei@redhat.com>
 <20210715120844.636968-2-ming.lei@redhat.com>
 <YPAs12ZfqQomASZC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPAs12ZfqQomASZC@kroah.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 15, 2021 at 02:40:55PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 15, 2021 at 08:08:42PM +0800, Ming Lei wrote:
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -569,6 +569,7 @@ struct device {
> >  #ifdef CONFIG_DMA_OPS_BYPASS
> >  	bool			dma_ops_bypass : 1;
> >  #endif
> > +	bool			irq_affinity_managed : 1;
> >  };
> 
> No documentation for this new field?

OK, will fix it in next version.


Thanks,
Ming

