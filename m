Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF41C433FE
	for <linux-block@archiver.kernel.org>; Thu, 24 Nov 2022 02:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKXCCD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 21:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKXCCC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 21:02:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CFEE14C3
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 18:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669255272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K+6YaXUnN1x7cAfFvdtjM27pTc6pKQII6xscZlbhcqQ=;
        b=WDWH1mFgBnyLFKP+omjpeRpBPmWJHIKXnsMO4zjjYRDAdIz2cP2eaIJh6zj5ucx+FOVk0z
        hMEcmYIZXw1L02TD9wXzqG6nSQfofQT2v3IhIN1GfkfUiE5nrh72IFODXk4H5Sa5drVmrL
        NJ49d36pTYkffxka2nD7TGUyvhUFC00=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-wvqF2jy3MsKehVFld3njrw-1; Wed, 23 Nov 2022 21:01:08 -0500
X-MC-Unique: wvqF2jy3MsKehVFld3njrw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DFAC800186;
        Thu, 24 Nov 2022 02:01:08 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E128111E410;
        Thu, 24 Nov 2022 02:01:03 +0000 (UTC)
Date:   Thu, 24 Nov 2022 10:00:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Andreas Hindborg <andreas.hindborg@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] ublk_drv: don't forward io commands in reserve order
Message-ID: <Y37QWsTZj1gW5l6m@T590>
References: <20221121155645.396272-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121155645.396272-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 21, 2022 at 11:56:45PM +0800, Ming Lei wrote:
> Either ublk_can_use_task_work() is true or not, io commands are
> forwarded to ublk server in reverse order, since llist_add() is
> always to add one element to the head of the list.
> 
> Even though block layer doesn't guarantee request dispatch order,
> requests should be sent to hardware in the sequence order generated
> from io scheduler, which usually considers the request's LBA, and
> order is often important for HDD.
> 
> So forward io commands in the sequence made from io scheduler by
> aligning task work with current io_uring command's batch handling,
> and it has been observed that both can get similar performance data
> if IORING_SETUP_COOP_TASKRUN is set from ublk server.
> 
> Reported-by: Andreas Hindborg <andreas.hindborg@wdc.com>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Hello Jens,

Can you pick up this patch? 6.1 could be better, but it is fine
for 6.2.


Thanks,
Ming

