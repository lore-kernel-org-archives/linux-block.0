Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FD3C6FA82
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 09:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiIVJNn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 05:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiIVJNn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 05:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB7EB6D0D
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 02:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663838021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fTXfM16EyzMdd6KzU6GPZWnMgRNiiiQnBhMGGC3fAHc=;
        b=d6dJ2JGSneFDqokLlX8TJ/FwGE2xaeHgilf+63Sc4fpAScSEmlLPENS6jSr1T2oHrH52Kb
        kjXFO0VyjXlq9dDtUsg5Jro9E0dcVbwZ/IugDCDWw4ptsAHM9A6XJ+KP+pxtyo3Mhs659G
        +2MlRkHlrmerP8dzWiwpNeFg4rS6He4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-wXTBLHQ7Ma-Z0JJWH5XcQQ-1; Thu, 22 Sep 2022 05:13:40 -0400
X-MC-Unique: wXTBLHQ7Ma-Z0JJWH5XcQQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3AF7800186;
        Thu, 22 Sep 2022 09:13:39 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E8EA492B0F;
        Thu, 22 Sep 2022 09:13:34 +0000 (UTC)
Date:   Thu, 22 Sep 2022 17:13:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>, ming.lei@redhat.com
Subject: Re: [PATCH] blk-mq: avoid to hang in the cpuhp offline handler
Message-ID: <YywnOO42kvr8CotB@T590>
References: <20220920021724.1841850-1-ming.lei@redhat.com>
 <19568225-56a1-f545-b8de-a219b7f843b7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19568225-56a1-f545-b8de-a219b7f843b7@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 22, 2022 at 09:47:09AM +0100, John Garry wrote:
> On 20/09/2022 03:17, Ming Lei wrote:
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
> I don't think that that this is a good idea - that is because often drivers
> cannot safely handle scenario of timeout of an IO which has actually
> completed. NVMe timeout handler may poll for completion, but SCSI does not.
> 
> Indeed, if we were going to allow the timeout handler handle these in-flight
> IO then there is no point in having this hotplug handler in the first place.

That is true from the beginning, and we did know the point, I remember that
Hannes asked this question in LSF/MM, and there are many drivers which don't
implement timeout handler.

For this issue, it looks more like one nvme specific since nvme timeout handler
can't move on during nvme reset. Let's see if it can be fixed by nvme
driver.

BTW nvme error handling is really fragile, not only this one, such as, any timeout
during reset will cause device removed.


Thanks.
Ming

