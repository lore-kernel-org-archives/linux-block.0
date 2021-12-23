Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9F0C433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Dec 2021 04:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346300AbhLWEQx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Dec 2021 23:16:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44496 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346298AbhLWEQx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Dec 2021 23:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640233012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M1kb2xksO64QR4JzZGzN9PWxULK+wEk9dWQhoqyfnuk=;
        b=eTRfowBli0/WlxCykfLLVzgnGqxqF1UMX1g54rMi2VTAwJFj3jn59LVcxqS6NGAm9ATEW/
        due+Gkr323MTjMwSTu8panaOqwrCeirJk3c9RWndni8AjzUye0lGPYadtXkKh06z9uUGWA
        qUjXL3S6SxgJki9JRndAt9xTOAeTWmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-bYQA0oLZOza-0VHTcPm6qA-1; Wed, 22 Dec 2021 23:16:51 -0500
X-MC-Unique: bYQA0oLZOza-0VHTcPm6qA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10795100C610;
        Thu, 23 Dec 2021 04:16:50 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D2FC1017E27;
        Thu, 23 Dec 2021 04:16:27 +0000 (UTC)
Date:   Thu, 23 Dec 2021 12:16:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 0/3] blk-mq/dm-rq: support BLK_MQ_F_BLOCKING for dm-rq
Message-ID: <YcP4FMG9an5ReIiV@T590>
References: <20211221141459.1368176-1-ming.lei@redhat.com>
 <YcH/E4JNag0QYYAa@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcH/E4JNag0QYYAa@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 21, 2021 at 08:21:39AM -0800, Christoph Hellwig wrote:
> On Tue, Dec 21, 2021 at 10:14:56PM +0800, Ming Lei wrote:
> > Hello,
> > 
> > dm-rq may be built on blk-mq device which marks BLK_MQ_F_BLOCKING, so
> > dm_mq_queue_rq() may become to sleep current context.
> > 
> > Fixes the issue by allowing dm-rq to set BLK_MQ_F_BLOCKING in case that
> > any underlying queue is marked as BLK_MQ_F_BLOCKING.
> > 
> > DM request queue is allocated before allocating tagset, this way is a
> > bit special, so we need to pre-allocate srcu payload, then use the queue
> > flag of QUEUE_FLAG_BLOCKING for locking dispatch.
> 
> What is the benefit over just forcing bio-based dm-mpath for these
> devices?

At least IO scheduler can't be used for bio based dm-mpath, also there should
be other drawbacks for bio based mpath and request mpath is often the default
option, maybe Mike has more input about bio vs request dm-mpath.



Thanks,
Ming

