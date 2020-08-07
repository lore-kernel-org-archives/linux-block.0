Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC52C433E0
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 13:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E4B12224D
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 13:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTE8TKGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgHGNtu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:49:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726282AbgHGNtt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Aug 2020 09:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596808188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AxKhj+gkO/EgGki1oR3mHYFMo4D2Y/mcsgmgyosbzNM=;
        b=hTE8TKGfJ3cCjl7RH3X0ZiWAzGpsrlq42kPTRMBy88REisEvvSpI6NO4hGsR6Z48cT4G+d
        N7UprgvYPHe2xp7LFJ7nBs80yC1dzXhTKy8KnUM81iMNiolppdb1ZJM61Z5J88MPCs7AWN
        4N6grEIR8m68Xd3wRfAXN45Sj9oN0/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-uNIENScWM26AP91v3UsCoQ-1; Fri, 07 Aug 2020 09:49:46 -0400
X-MC-Unique: uNIENScWM26AP91v3UsCoQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8301379EEC;
        Fri,  7 Aug 2020 13:49:44 +0000 (UTC)
Received: from T590 (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 707876FEDC;
        Fri,  7 Aug 2020 13:49:37 +0000 (UTC)
Date:   Fri, 7 Aug 2020 21:49:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chao Leng <lengchao@huawei.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH v2 0/3] reduce quiesce time for lots of name spaces
Message-ID: <20200807134932.GA2122627@T590>
References: <20200807090559.29582-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807090559.29582-1-lengchao@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 07, 2020 at 05:05:59PM +0800, Chao Leng wrote:
> nvme_stop_queues quiesce queues for all name spaces, now quiesce one by
> one, if there is lots of name spaces, sync wait long time(more than 10s).
> Multipath can not fail over to retry quickly, cause io pause long time.
> This is not expected.
> To reduce quiesce time, we introduce async mechanism for sync SRCUs
> and quiesce queue.
> 

Frankly speaking, I prefer to replace SRCU with percpu_refcount:

- percpu_refcount has much less memory footprint than SRCU, so we can simply
move percpu_refcount into request_queue, instead of adding more bytes
into each hctx by this patch

- percpu_ref_get()/percpu_ref_put() isn't slower than srcu_read_lock()/srcu_read_unlock().

- with percpu_refcount, we can remove 'srcu_idx' from hctx_lock/hctx_unlock()

Thanks,
Ming

