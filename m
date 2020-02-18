Return-Path: <SRS0=AW5R=4G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC5BC34031
	for <linux-block@archiver.kernel.org>; Tue, 18 Feb 2020 03:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A00A215A4
	for <linux-block@archiver.kernel.org>; Tue, 18 Feb 2020 03:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPlXNCfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgBRDqP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Feb 2020 22:46:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57001 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726166AbgBRDqP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Feb 2020 22:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581997574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0hlTXaKliAAW3e6s/e3LvUgWbi2BfbLv5eWGC29PrKQ=;
        b=BPlXNCfPu8aZO/mjSzTDSKdMBZOPAdKQ8gt1Zj/oU4kBhHWHixytBhe7Mm6+gvQdhKA/S3
        BakKJZ3ZRziOqzPVEOYfVNfaOyhy1qZGlJY98zwCBQz40ldKYhD9liwW8MSI9PQHULzKis
        Ii3PE3EA9RhN/Gwz9NDPmnNf8ieweYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-qJyyi4HNN9ySWoA3fSGaEg-1; Mon, 17 Feb 2020 22:46:10 -0500
X-MC-Unique: qJyyi4HNN9ySWoA3fSGaEg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EFC41007271;
        Tue, 18 Feb 2020 03:46:09 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1F6D5DA60;
        Tue, 18 Feb 2020 03:46:01 +0000 (UTC)
Date:   Tue, 18 Feb 2020 11:45:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/5] blk-mq: Fix a recently introduced regression in
 blk_mq_realloc_hw_ctxs()
Message-ID: <20200218034556.GC30750@ming.t460p>
References: <20200217210839.28535-1-bvanassche@acm.org>
 <20200217210839.28535-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217210839.28535-4-bvanassche@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 17, 2020 at 01:08:37PM -0800, Bart Van Assche wrote:
> q->nr_hw_queues must only be updated once it is known that
> blk_mq_realloc_hw_ctxs() has succeeded. Otherwise it can happen that
> reallocation fails and that q->nr_hw_queues is larger than the number of
> allocated hardware queues. This patch fixes the following crash if
> increasing the number of hardware queues fails:
> 
> BUG: KASAN: null-ptr-deref in blk_mq_map_swqueue+0x775/0x810
> Write of size 8 at addr 0000000000000118 by task check/977
> 
> CPU: 3 PID: 977 Comm: check Not tainted 5.6.0-rc1-dbg+ #8
> Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> Call Trace:
>  dump_stack+0xa5/0xe6
>  __kasan_report.cold+0x65/0x99
>  kasan_report+0x16/0x20
>  check_memory_region+0x140/0x1b0
>  memset+0x28/0x40
>  blk_mq_map_swqueue+0x775/0x810
>  blk_mq_update_nr_hw_queues+0x468/0x710
>  nullb_device_submit_queues_store+0xf7/0x1a0 [null_blk]
>  configfs_write_file+0x1c4/0x250 [configfs]
>  __vfs_write+0x4c/0x90
>  vfs_write+0x145/0x2c0
>  ksys_write+0xd7/0x180
>  __x64_sys_write+0x47/0x50
>  do_syscall_64+0x6f/0x2f0
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jth@kernel.org>
> Cc: Keith Busch <kbusch@kernel.org>
> Fixes: ac0d6b926e74 ("block: Reduce the amount of memory required per request queue")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2b9f490f5a64..5408098b58f2 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2824,7 +2824,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  			memcpy(new_hctxs, hctxs, q->nr_hw_queues *
>  			       sizeof(*hctxs));
>  		q->queue_hw_ctx = new_hctxs;
> -		q->nr_hw_queues = set->nr_hw_queues;
>  		kfree(hctxs);
>  		hctxs = new_hctxs;
>  	}

Looks correct, since ->nr_hw_queues needs to be updated after hctxs are
initialized successfully:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


thanks,
Ming

