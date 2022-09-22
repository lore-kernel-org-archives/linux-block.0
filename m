Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA2DC6FA8B
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 07:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiIVHmH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 03:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIVHmG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 03:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31423D33F0
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 00:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663832522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aX5SHZZrlLzIuA6zspzZp9bdt2bB6GCyAFRXm2vXPG4=;
        b=hT828UJg+9FiWRSidMNdfyeifg01wAb4wS6GWigYjBP9SaO5M5BjQGa+W+CAsiS2ve0VrX
        e+pBDBPKlOTpQymhga6+BkJYe7DeogIuHtAwkWCv78gxpUBER8OiGkwhbYYZ+1xAw9bzLG
        i2e75PISwN5H4OOA4TbqBa3MQlO2Mlw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-ggugo2h2M-q7MtGVahmSTQ-1; Thu, 22 Sep 2022 03:41:58 -0400
X-MC-Unique: ggugo2h2M-q7MtGVahmSTQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB6A5800B30;
        Thu, 22 Sep 2022 07:41:57 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 327B8C15BB9;
        Thu, 22 Sep 2022 07:41:52 +0000 (UTC)
Date:   Thu, 22 Sep 2022 15:41:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        homas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] blk-mq: avoid to hang in the cpuhp offline handler
Message-ID: <YywRu/g7ML0Dq/Gq@T590>
References: <20220920021724.1841850-1-ming.lei@redhat.com>
 <20220922062517.GB27946@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922062517.GB27946@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 22, 2022 at 08:25:17AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 20, 2022 at 10:17:24AM +0800, Ming Lei wrote:
> > For avoiding to trigger io timeout when one hctx becomes inactive, we
> > drain IOs when all CPUs of one hctx are offline. However, driver's
> > timeout handler may require cpus_read_lock, such as nvme-pci,
> > pci_alloc_irq_vectors_affinity() is called in nvme-pci reset context,
> > and irq_build_affinity_masks() needs cpus_read_lock().
> > 
> > Meantime when blk-mq's cpuhp offline handler is called, cpus_write_lock
> > is held, so deadlock is caused.
> > 
> > Fixes the issue by breaking the wait loop if enough long time elapses,
> > and these in-flight not drained IO still can be handled by timeout
> > handler.
> 
> I'm not sure that this actually is a good idea on its own, and it kinda
> defeats the cpu hotplug processing.
> 
> So if I understand your log above correctly the problem is that
> we have commands that would time out, and we exacalate to a
> controller reset that is racing with the CPU unplug.

Yes. 

blk_mq_hctx_notify_offline() is waiting for inflight requests, then
cpu_write_lock() is held since it is cpuhp code path.

Meantime nvme reset grabs dev->shutdown_lock, then calls
pci_alloc_irq_vectors_affinity()->irq_build_affinity_masks() which
is waiting for cpu_read_lock().

Meantime nvme_dev_disable() can't move on for handling any io timeout
because dev->shutdown_lock is held by nvme reset. Then in-flight IO
can't be drained by blk_mq_hctx_notify_offline()

One real IO deadlock between cpuhp and nvme_reset.


thanks,
Ming

