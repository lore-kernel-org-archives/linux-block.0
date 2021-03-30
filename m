Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF54C433DB
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 02:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC14F61989
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 02:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhC3CE2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Mar 2021 22:04:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230374AbhC3CEX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 22:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617069862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gngwkyZ/3M/2XkpH6d2ukHiMd39dV8LGK6CsTjibunk=;
        b=dkvYh8G5NQBW09NoEVtdqzmYr/oucNkX+4TFGsuIk3TIdJFL7cs2g35A1Iw6ZFhjA4ejEe
        fDnXCGWL4INual5J1sbidhWkepGW30Y/2DY3gRK6KvRnD72eDdyJGE8gkLvXd5tNR56Ipw
        ydUCvLlOPco68JPJ4t1qgE7/Vh/ok3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-kPTxH9BXMj-4hnSWZf7KCQ-1; Mon, 29 Mar 2021 22:04:17 -0400
X-MC-Unique: kPTxH9BXMj-4hnSWZf7KCQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 429C883DB64;
        Tue, 30 Mar 2021 02:04:16 +0000 (UTC)
Received: from T590 (ovpn-12-129.pek2.redhat.com [10.72.12.129])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 69DA16E707;
        Tue, 30 Mar 2021 02:04:09 +0000 (UTC)
Date:   Tue, 30 Mar 2021 10:04:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] blktrace: fix trace buffer leak and limit trace
 buffer size
Message-ID: <YGKHFbQ6vfdVroZ7@T590>
References: <20210323081440.81343-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323081440.81343-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 23, 2021 at 04:14:38PM +0800, Ming Lei wrote:
> blktrace may pass big trace buffer size via '-b', meantime the system
> may have lots of CPU cores, so too much memory can be allocated for
> blktrace.
> 
> The 1st patch shutdown bltrace in blkdev_close() in case of task
> exiting, for avoiding trace buffer leak.
> 
> The 2nd patch limits max trace buffer size for avoiding potential
> OOM.
> 
> 
> Ming Lei (2):
>   block: shutdown blktrace in case of fatal signal pending
>   blktrace: limit allowed total trace buffer size
> 
>  fs/block_dev.c          |  6 ++++++
>  kernel/trace/blktrace.c | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)

Hello Guys,

Ping...

BTW, this is another OOM risk in blktrace userspace which is caused by
mlock(16 * buffer_size) * nr_cpus, so I think we need to avoid memory
leak caused by OOM.


Thanks,
Ming

