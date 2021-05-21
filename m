Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A668CC433B4
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 00:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F48760200
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 00:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbhEUA6o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 20:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235619AbhEUA6o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 20:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621558642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4j3YTbkVra2sxk3H+IvvpEYAN6gcn4/ify46SABygs0=;
        b=EOSREfXzDZIWN80Tm4fXyH4nLAkihxNv5a/MBI5KmWvj/SlCsC/hz9IPTXSDc43xi4CKxt
        j1ZEWrwNjGdETfL54TK8yCLrQYqz+3vKFhUwCVsbLIOdRkThZgit6UtyIcglIrBIlh0Quv
        6VdHIQXiwxIVW8eY+yaM02Iz4kxxBn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-0SAx8IVbOgaS4wp2IlWFWA-1; Thu, 20 May 2021 20:57:20 -0400
X-MC-Unique: 0SAx8IVbOgaS4wp2IlWFWA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 321CB107ACF5;
        Fri, 21 May 2021 00:57:19 +0000 (UTC)
Received: from T590 (ovpn-12-75.pek2.redhat.com [10.72.12.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC3B5687F9;
        Fri, 21 May 2021 00:57:12 +0000 (UTC)
Date:   Fri, 21 May 2021 08:57:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Khazhy Kumykov <khazhy@google.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH 2/2] blk: Fix lock inversion between ioc lock and bfqd
 lock
Message-ID: <YKcFZMJiFnsktsBu@T590>
References: <20210520223353.11561-1-jack@suse.cz>
 <20210520223353.11561-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520223353.11561-3-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 21, 2021 at 12:33:53AM +0200, Jan Kara wrote:
> Lockdep complains about lock inversion between ioc->lock and bfqd->lock:
> 
> bfqd -> ioc:
>  put_io_context+0x33/0x90 -> ioc->lock grabbed
>  blk_mq_free_request+0x51/0x140
>  blk_put_request+0xe/0x10
>  blk_attempt_req_merge+0x1d/0x30
>  elv_attempt_insert_merge+0x56/0xa0
>  blk_mq_sched_try_insert_merge+0x4b/0x60
>  bfq_insert_requests+0x9e/0x18c0 -> bfqd->lock grabbed

We could move blk_put_request() into scheduler code, then the lock
inversion is avoided. So far only mq-deadline and bfq calls into
blk_mq_sched_try_insert_merge(), and this change should be small.


Thanks,
Ming

