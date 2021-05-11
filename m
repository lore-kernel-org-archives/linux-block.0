Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CBFC433B4
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 06:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC5A36161F
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 06:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhEKGiM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 02:38:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20009 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229807AbhEKGiM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 02:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620715025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gVZQQ02hjxn8wxspia6DDodFP4q+lDof803RoDv6ILg=;
        b=c6aAl2o5aN3AH4TD6lRKRSzmnadlXIv9yLnsaNxGTeWNIldo94Sm5QxlsLP4qKwrnjz0TH
        aFUQlu2tEDAEDDWweZdfidd8QQrZcuQ5lyv5Kl8BKZxxYWnr4fAze7mqEjOKd8Aw2RpkGY
        KH8h64Y5dDkOHAQXSuTImOgESe35aPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-jGCah6Q7NY6axtfv-t5orQ-1; Tue, 11 May 2021 02:37:01 -0400
X-MC-Unique: jGCah6Q7NY6axtfv-t5orQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5771D107ACE3;
        Tue, 11 May 2021 06:37:00 +0000 (UTC)
Received: from T590 (ovpn-12-205.pek2.redhat.com [10.72.12.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A3C517511;
        Tue, 11 May 2021 06:36:51 +0000 (UTC)
Date:   Tue, 11 May 2021 14:36:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V6 0/4] blk-mq: fix request UAF related with iterating
 over tagset requests
Message-ID: <YJol/7YGUxWbBdiK@T590>
References: <20210507144208.459139-1-ming.lei@redhat.com>
 <20210511050551.3m62ut7nfz2gvqgh@shindev.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511050551.3m62ut7nfz2gvqgh@shindev.dhcp.fujisawa.hgst.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Shinichiro,

Thanks for your test!

On Tue, May 11, 2021 at 05:05:52AM +0000, Shinichiro Kawasaki wrote:
> On May 07, 2021 / 22:42, Ming Lei wrote:
> > Hi Jens,
> > 
> > This patchset fixes the request UAF issue by one simple approach,
> > without clearing ->rqs[] in fast path, please consider it for 5.13.
> > 
> > 1) grab request's ref before calling ->fn in blk_mq_tagset_busy_iter,
> > and release it after calling ->fn, so ->fn won't be called for one
> > request if its queue is frozen, done in 2st patch
> > 
> > 2) clearing any stale request referred in ->rqs[] before freeing the
> > request pool, one per-tags spinlock is added for protecting
> > grabbing request ref vs. clearing ->rqs[tag], so UAF by refcount_inc_not_zero
> > in bt_tags_iter() is avoided, done in 3rd patch.
> 
> Ming, thank you for your effort to fix the UAF issue. I applied the V6 series to
> the kernel v5.13-rc1, and confirmed that the series avoids the UAF I had been
> observing with blktests block/005 and HDD behind HBA. This is good. However, I
> found that the series triggered block/029 hang. Let me share the kernel message
> below, which was printed at the hang. KASAN reported null-ptr-deref.
> 
> [ 2124.489023] run blktests block/029 at 2021-05-11 13:42:22
> [ 2124.561386] null_blk: module loaded
> [ 2125.201166] general protection fault, probably for non-canonical address 0xdffffc0000000012: 0000 [#1] SMP KASAN PTI
> [ 2125.212387] KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]

It is because this hw queue isn't mapped yet and new added hw queue is
mapped in blk_mq_map_swqueue(), and the following change can fix it, and
I will post V7 after careful test.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index fcd5ed79011f..691b555c26fa 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2652,6 +2652,10 @@ static void blk_mq_clear_flush_rq_mapping(struct blk_mq_tags *tags,
 	int i;
 	unsigned long flags;
 
+	/* return if hw queue isn't mapped */
+	if (!tags)
+		return;
+
 	WARN_ON_ONCE(refcount_read(&flush_rq->ref) != 0);
 
 	for (i = 0; i < queue_depth; i++)


Thanks,
Ming

