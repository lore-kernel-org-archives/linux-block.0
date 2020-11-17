Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA99C388F9
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 01:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D619324686
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 01:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkdMg2lZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgKQBQc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Nov 2020 20:16:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726321AbgKQBQc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 20:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605575790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IoYgDWclBnbbhqYLwxSr01tKpJ4yFcNBRPli8o4TS94=;
        b=PkdMg2lZC7XUF+FmCiMrkyQQ8HizcngHflA+U7BNr4Z0Lnfh/59ESfRg4EOfJXu7G5vHq5
        R5gaz2oRNT1XOe1qTA7iSk33xhiy/Au+IO9vGjCjXf/1AmXcAEyxHmT1g1PuLrD1YZKno7
        AH+nwWz8trgCaEkvGA93dz6Q05LvL4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-F1S4P_9QP7i0ydQVu59sZQ-1; Mon, 16 Nov 2020 20:16:27 -0500
X-MC-Unique: F1S4P_9QP7i0ydQVu59sZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39ECE107AFC8;
        Tue, 17 Nov 2020 01:16:25 +0000 (UTC)
Received: from T590 (ovpn-12-215.pek2.redhat.com [10.72.12.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C0B95D707;
        Tue, 17 Nov 2020 01:16:13 +0000 (UTC)
Date:   Tue, 17 Nov 2020 09:16:10 +0800
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
Message-ID: <20201117011610.GB56247@T590>
References: <20201112075526.947079-1-ming.lei@redhat.com>
 <20201112075526.947079-2-ming.lei@redhat.com>
 <20201116172658.GJ22007@lst.de>
 <20201117010448.GA56247@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117010448.GA56247@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 17, 2020 at 09:05:04AM +0800, Ming Lei wrote:
> On Mon, Nov 16, 2020 at 06:26:58PM +0100, Christoph Hellwig wrote:
> > On Thu, Nov 12, 2020 at 03:55:24PM +0800, Ming Lei wrote:
> > > flush_end_io() may be called recursively from some driver, such as
> > > nvme-loop, so lockdep may complain 'possible recursive locking'.
> > > Commit b3c6a5997541("block: Fix a lockdep complaint triggered by
> > > request queue flushing") tried to address this issue by assigning
> > > dynamically allocated per-flush-queue lock class. This solution
> > > adds synchronize_rcu() for each hctx's release handler, and causes
> > > horrible SCSI MQ probe delay(more than half an hour on megaraid sas).
> > > 
> > > Add new API of blk_mq_hctx_set_fq_lock_class() for these drivers, so
> > > we just need to use driver specific lock class for avoiding the
> > > lockdep warning of 'possible recursive locking'.
> > 
> > I'd turn this into an inline function to avoid the (although very
> > minimal) cost when LOCKDEP is not enabled.
> 
> blk_mq_hctx_set_fq_lock_class() is just one-shot thing, do you really
> care the cost?

Forget to mention, 'blk_flush_queue' is one private structure inside block
layer, so we can't define as inline.

thanks,
Ming

