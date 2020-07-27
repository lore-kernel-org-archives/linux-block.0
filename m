Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE2FC433E0
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 06:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4742520714
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 06:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaTJbP1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgG0Gcj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:32:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50990 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726116AbgG0Gcj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 02:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595831557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aJtngrEk2ZTwLRW9iKTKZSGysZhtZ1fNHYksyTSX2tM=;
        b=EaTJbP1JTuKvD/fPTzHjHCU8yqEKIikwDyYYkdvpZiaeAoDQYBXsNH43NG4NCtAdEFkMWU
        nJXx3zYodn61hn1qsPsuCRW3EFY/taOJBHvMlzfsUyU4sd6n3hG/SQqIpQCJGaFqUsetVu
        o/TLZrVfA2ToHADhiV/FSqFEoUC24ao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-Z_xYT0RHOvWRtl-nTClzRg-1; Mon, 27 Jul 2020 02:32:33 -0400
X-MC-Unique: Z_xYT0RHOvWRtl-nTClzRg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B6C01DE0;
        Mon, 27 Jul 2020 06:32:32 +0000 (UTC)
Received: from T590 (ovpn-12-208.pek2.redhat.com [10.72.12.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5302F5C1D3;
        Mon, 27 Jul 2020 06:32:24 +0000 (UTC)
Date:   Mon, 27 Jul 2020 14:32:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chao Leng <lengchao@huawei.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
Message-ID: <20200727063220.GA1144698@T590>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me>
 <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <f9ed3baa-2a83-c483-6ba0-70a84d40f569@huawei.com>
 <20200727035033.GD1129253@T590>
 <79ab699e-3f50-26c0-3c85-1962ae4dedac@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79ab699e-3f50-26c0-3c85-1962ae4dedac@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 27, 2020 at 01:55:53PM +0800, Chao Leng wrote:
> 
> 
> On 2020/7/27 11:50, Ming Lei wrote:
> > On Mon, Jul 27, 2020 at 11:33:43AM +0800, Chao Leng wrote:
> > > 
> > > 
> > > On 2020/7/27 10:08, Ming Lei wrote:
> > > > > It is at the end and contains exactly what is needed to synchronize. Not
> > > > The sync is simply single global synchronize_rcu(), and why bother to add
> > > > extra >=40bytes for each hctx.
> > > > 
> > > > > sure what you mean by reuse hctx->srcu?
> > > > You already reuses hctx->srcu, but not see reason to add extra rcu_synchronize
> > > > to each hctx for just simulating one single synchronize_rcu().
> > > 
> > > To sync srcu together, the extra bytes must be needed, seperate blocking
> > > and non blocking queue to two hctx may be a not good choice.
> > > 
> > > There is two choice: the struct rcu_synchronize is added in hctx or in srcu.
> > > Though add rcu_synchronize in srcu has a  weakness: the extra bytes is
> > > not need if which do not need batch sync srcu, I still think it's better
> > > for the SRCU to provide the batch synchronization interface.
> > 
> > The 'struct rcu_synchronize' can be allocated from heap or even stack(
> > if no too many NSs), which is just one shot sync and the API is supposed
> > to be called in slow path. No need to allocate it as long lifetime variable.
> > Especially 'struct srcu_struct' has already been too fat.
> 
> Stack is not suitable, stack can not provide so many space for

Stack is fine if number of NS is small, for example, most of times,
there is just one NS.

> many name space. Heap maybe a choice, but need to add abnormal treat
> when alloc memory failed, Thus io pause time can not be ensured.
> So the extra space may must be needed for batch srcu sync.

In case of allocation failure, you can switch to synchronize_srcu() simply.

Thanks, 
Ming

