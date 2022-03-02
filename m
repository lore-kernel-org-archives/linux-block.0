Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D85C433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 09:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiCBJyq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 04:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240708AbiCBJyp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 04:54:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1E702AEA
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 01:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646214842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NRAwHsFYbzokxyspT2XqhWwTlHRyIZhRaKklKCaXknE=;
        b=PVVn5+/sikIs514SEx0lSYFVIiBycu/ngFe5O8ULThb6Js9af15idXof3pE4lzoU2/QBQN
        EYdEfh6XeYhGQjRls2DlzEzJRjo5e6FWjbqct+qR/ywsEXPAe1Uy7ln8z/lYTQffYPyO0m
        w6rPivI32DatB5x5n6n4ZdrKhznBiJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-aX_j-uKiPXWLv1b5PPoaeA-1; Wed, 02 Mar 2022 04:53:58 -0500
X-MC-Unique: aX_j-uKiPXWLv1b5PPoaeA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4851824FA7;
        Wed,  2 Mar 2022 09:53:57 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E66422E1A;
        Wed,  2 Mar 2022 09:53:49 +0000 (UTC)
Date:   Wed, 2 Mar 2022 17:53:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 6/6] blk-mq: manage hctx map via xarray
Message-ID: <Yh8+qA4p6EWGFbtG@T590>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
 <20220228090430.1064267-7-ming.lei@redhat.com>
 <Yh4hjS0S3vXfLWlH@infradead.org>
 <Yh7RDCaqiqMmKj1s@T590>
 <Yh8pwiR5DWC9ELDD@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh8pwiR5DWC9ELDD@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 02, 2022 at 12:24:34AM -0800, Christoph Hellwig wrote:
> On Wed, Mar 02, 2022 at 10:06:04AM +0800, Ming Lei wrote:
> > I did considered xa_for_each(), but it requires rcu read lock.
> 
> No, I doesn't.  It just takes a RCU lock internally.

OK.

> 
> > Also queue_for_each_hw_ctx() is supposed to not run in fast path,
> > meantime xa_load() is lightweight enough too, so repeated xa_load()
> > is fine here.
> 
> I'd rather have the clarity of the proper iterators.
 
Another point is that 'unsigned long *' is passed to xa_find() as index.
However, almost all users of queue_for_each_hw_ctx() defines hctx index
as 'unsigned int'.

If we switch to xa_for_each(), the type of hctx index needs to be changed
to 'unsigned long' for every queue_for_each_hw_ctx(). But xa_load()
needn't such change.

Also from user viewpoint, looks 'unsigned long' change for hctx index is
still a bit confusing, IMO.


Thanks,
Ming

