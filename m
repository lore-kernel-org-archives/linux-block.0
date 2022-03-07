Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8267EC433F5
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 07:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbiCGHqO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 02:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiCGHqO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 02:46:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE21E5F8C1
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 23:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646639119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YpLSikh8rZ2S+uRGKSu0dpMeWVj9lMOLwqxV935zAGA=;
        b=N5EmBN1Zy52SqC6K16esRpQZ8xRjmsZiE4t9dWMZ412C8ANGKbYEuKJuuy1OKLaBfL6CWE
        t4OUWZy7xf12H2tYIM3caR2jN/ERCKjD0+pIfb//RcGJmwRyOkfugs9zEIpoY7oyhA5Sq2
        xPrBDeJ0c6zQ6gotyI4RC2NYn5NN3fQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-RfKBXaxBPaeSlMaB8PMGjA-1; Mon, 07 Mar 2022 02:45:14 -0500
X-MC-Unique: RfKBXaxBPaeSlMaB8PMGjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 390A91091DA1;
        Mon,  7 Mar 2022 07:45:13 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D5335E7D3;
        Mon,  7 Mar 2022 07:44:55 +0000 (UTC)
Date:   Mon, 7 Mar 2022 15:44:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH V3 6/6] blk-mq: manage hctx map via xarray
Message-ID: <YiW386JNAAi1IZE+@T590>
References: <20220307064401.30056-1-ming.lei@redhat.com>
 <20220307064401.30056-7-ming.lei@redhat.com>
 <20220307071317.GC32227@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307071317.GC32227@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 07, 2022 at 08:13:17AM +0100, Christoph Hellwig wrote:
> On Mon, Mar 07, 2022 at 02:44:01PM +0800, Ming Lei wrote:
> > Firstly code becomes more clean by switching to xarray from plain array.
> > 
> > Secondly use-after-free on q->queue_hw_ctx can be fixed because
> 
> Not a native speaker, but shouldn't this read First and Second?

OK, will fix it in next version.

> 
> >  	mutex_lock(&q->sysfs_lock);
> >  	for (i = 0; i < set->nr_hw_queues; i++) {
> >  		int old_node;
> >  		int node = blk_mq_get_hctx_node(set, i);
> > -		struct blk_mq_hw_ctx *old_hctx = hctxs[i];
> > +		struct blk_mq_hw_ctx *old_hctx = xa_load(&q->hctx_table, i);
> 
> This should cand can xa_for_each_range.

It may not work here since xa_for_each_range() breaks if NULL entry is
found. Even two loops can't work too because we need old numa node
for reallocation.

> 
> >  	for (; j < end; j++) {
> > -		struct blk_mq_hw_ctx *hctx = hctxs[j];
> > +		struct blk_mq_hw_ctx *hctx = xa_load(&q->hctx_table, j);
> >  
> > -		if (hctx) {
> > +		if (hctx)
> >  			blk_mq_exit_hctx(q, set, hctx, j);
> > -			hctxs[j] = NULL;
> > -		}

This one can be converted directly.


Thanks,
Ming

