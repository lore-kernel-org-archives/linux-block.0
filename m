Return-Path: <SRS0=DoUd=BU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1155DC433E0
	for <linux-block@archiver.kernel.org>; Mon, 10 Aug 2020 03:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8B8D2065D
	for <linux-block@archiver.kernel.org>; Mon, 10 Aug 2020 03:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nw0+ge5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgHJDQE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Aug 2020 23:16:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54235 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726335AbgHJDQE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Aug 2020 23:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597029362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P2t4h3xBtgQzBZLBUDif0YVJTDr/h+7SWzN2brxDiDs=;
        b=Nw0+ge5g+mbc8A+r/9j6fFjBr3u9wuLk8sWjKhCH3R0vx4rkTBvzUymS1PWIaJ5tzrdiS4
        QUZTAEPwiokomGgcIwd7vkiF5r9FLH1PwwDiixErYDvBl0Q/o6inxYd5lUx7SzulYX5NID
        HhHEVpoBSNJup8bPFDRRYiAHmJeM0FM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-V_6AE8prOUqI8ObSH2fxAg-1; Sun, 09 Aug 2020 23:16:00 -0400
X-MC-Unique: V_6AE8prOUqI8ObSH2fxAg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AA2380183C;
        Mon, 10 Aug 2020 03:15:59 +0000 (UTC)
Received: from T590 (ovpn-13-99.pek2.redhat.com [10.72.13.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D43048BA11;
        Mon, 10 Aug 2020 03:15:51 +0000 (UTC)
Date:   Mon, 10 Aug 2020 11:15:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chao Leng <lengchao@huawei.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH v2 0/3] reduce quiesce time for lots of name spaces
Message-ID: <20200810031547.GB2202641@T590>
References: <20200807090559.29582-1-lengchao@huawei.com>
 <20200807134932.GA2122627@T590>
 <61a78a78-73aa-1c67-1e8c-eae8f7c3a4e0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61a78a78-73aa-1c67-1e8c-eae8f7c3a4e0@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 10, 2020 at 10:17:04AM +0800, Chao Leng wrote:
> 
> 
> On 2020/8/7 21:49, Ming Lei wrote:
> > On Fri, Aug 07, 2020 at 05:05:59PM +0800, Chao Leng wrote:
> > > nvme_stop_queues quiesce queues for all name spaces, now quiesce one by
> > > one, if there is lots of name spaces, sync wait long time(more than 10s).
> > > Multipath can not fail over to retry quickly, cause io pause long time.
> > > This is not expected.
> > > To reduce quiesce time, we introduce async mechanism for sync SRCUs
> > > and quiesce queue.
> > > 
> > 
> > Frankly speaking, I prefer to replace SRCU with percpu_refcount:
> > 
> > - percpu_refcount has much less memory footprint than SRCU, so we can simply
> > move percpu_refcount into request_queue, instead of adding more bytes
> > into each hctx by this patch
> > 
> > - percpu_ref_get()/percpu_ref_put() isn't slower than srcu_read_lock()/srcu_read_unlock().
> > 
> > - with percpu_refcount, we can remove 'srcu_idx' from hctx_lock/hctx_unlock()
> IO pause long time if fail over, this is a serios problem. we need fix
> it as soon as possible. SRCU is just used for blocking queue,

The issue has been long time since SRCU is taken, not sure if it is
something urgent.

> non blocking queue need 0 bytes. So more bytes(just 24 bytes) is not
> waste.
> 
> About using per_cpu to replace SRCU, I suggest separate discussion.
> Can you show the patch? This will make it easier to discuss.

https://lore.kernel.org/linux-block/20200728134938.1505467-1-ming.lei@redhat.com/


Thanks,
Ming

