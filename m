Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F85C388F9
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 01:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2707024680
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 01:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z046nrG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgKQBFN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Nov 2020 20:05:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726321AbgKQBFL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 20:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605575110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pn3SKcdf5rZI/KQgtlY7ogUA1X+FwiJoMFCzMnTlgf0=;
        b=Z046nrG+VkZmzERCJbt6B8KxsPe7qD0cRr//qLAhbpHy5PR0Tdv8ipo1v11ZGWKmz+zOdv
        Zp0HLtJO3STZVFOZgNnIyZRN0rv3vvOR7Z8MVM8u7XaVco+/+3kXepZoOEefURhgdzmIxZ
        Fe4Q4mV1z9KDdGp1uMaf7Vfo34nwbIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-WQGDqBW8Nfm1as1OpFAbTA-1; Mon, 16 Nov 2020 20:05:06 -0500
X-MC-Unique: WQGDqBW8Nfm1as1OpFAbTA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FD32CE670;
        Tue, 17 Nov 2020 01:05:04 +0000 (UTC)
Received: from T590 (ovpn-12-215.pek2.redhat.com [10.72.12.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 20CAC5D9D2;
        Tue, 17 Nov 2020 01:04:52 +0000 (UTC)
Date:   Tue, 17 Nov 2020 09:04:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Qian Cai <cai@redhat.com>, John Garry <john.garry@huawei.com>,
        linux-nvme@lists.infradead.org,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-block@vger.kernel.org,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/3] blk-mq: add new API of blk_mq_hctx_set_fq_lock_class
Message-ID: <20201117010448.GA56247@T590>
References: <20201112075526.947079-1-ming.lei@redhat.com>
 <20201112075526.947079-2-ming.lei@redhat.com>
 <20201116172658.GJ22007@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116172658.GJ22007@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 16, 2020 at 06:26:58PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 12, 2020 at 03:55:24PM +0800, Ming Lei wrote:
> > flush_end_io() may be called recursively from some driver, such as
> > nvme-loop, so lockdep may complain 'possible recursive locking'.
> > Commit b3c6a5997541("block: Fix a lockdep complaint triggered by
> > request queue flushing") tried to address this issue by assigning
> > dynamically allocated per-flush-queue lock class. This solution
> > adds synchronize_rcu() for each hctx's release handler, and causes
> > horrible SCSI MQ probe delay(more than half an hour on megaraid sas).
> > 
> > Add new API of blk_mq_hctx_set_fq_lock_class() for these drivers, so
> > we just need to use driver specific lock class for avoiding the
> > lockdep warning of 'possible recursive locking'.
> 
> I'd turn this into an inline function to avoid the (although very
> minimal) cost when LOCKDEP is not enabled.

blk_mq_hctx_set_fq_lock_class() is just one-shot thing, do you really
care the cost?


thanks,
Ming

