Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE6FC433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 14:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 288FD60FC0
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 14:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbhI0OeS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 10:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40556 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234909AbhI0OeQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 10:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632753158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RDiXGM7KM67kZstwJFIhcJQ97P5qdvgAwhAEiTRorTg=;
        b=HUJ3FnH2fdc7iTZb972/38VsXAuxxAejB6ccJl/ak4FSHaKz4tE8KEAX/LHDYD7LPihvD8
        EqhIuARULb1BCV4l+V36icd4JZvWRye1ChuR9anTrrvoyacr+n7oqXp3DBRNGr5D9vO7LO
        srcPUY9edsEFW+T2zrKQthj+RWCqGj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-rsH5-72jP0WynmuMYSwomg-1; Mon, 27 Sep 2021 10:32:36 -0400
X-MC-Unique: rsH5-72jP0WynmuMYSwomg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 164D2835DE2;
        Mon, 27 Sep 2021 14:32:35 +0000 (UTC)
Received: from T590 (ovpn-8-37.pek2.redhat.com [10.72.8.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 80D5C10023AE;
        Mon, 27 Sep 2021 14:32:31 +0000 (UTC)
Date:   Mon, 27 Sep 2021 22:32:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/4] block: drain file system I/O on del_gendisk
Message-ID: <YVHV+q5Mwj/mUjU7@T590>
References: <20210922172222.2453343-1-hch@lst.de>
 <20210922172222.2453343-4-hch@lst.de>
 <YUvZi2a0KjxEkiHo@T590>
 <20210923052705.GA5314@lst.de>
 <YUwhPy1J8lzHQF77@T590>
 <20210927120441.GA25223@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927120441.GA25223@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 27, 2021 at 02:04:41PM +0200, Christoph Hellwig wrote:
> On Thu, Sep 23, 2021 at 02:39:59PM +0800, Ming Lei wrote:
> > > > After blk_mq_unfreeze_queue() returns, blk_try_enter_queue() will return
> > > > true, so new FS I/O from opened bdev still won't be blocked, right?
> > > 
> > > It won't be blocked by blk_mq_unfreeze_queue, but because the capacity
> > > is set to 0 it still won't make it to the driver.
> > 
> > One bio could be made & checked before set_capacity(0), then is
> > submitted after blk_mq_unfreeze_queue() returns.
> > 
> > blk_mq_freeze_queue_wait() doesn't always imply RCU grace period, for
> > example, the .q_usage_counter may have been in atomic mode before
> > calling blk_queue_start_drain() & blk_mq_freeze_queue_wait().
> 
> True, but this isn't really a new issue as we never had proper quiesce
> behavior.  I have a bunch of ideas of how to make this actually solid,
> but none of them looks like 5.15 material.

It is new issue since edb0872f44ec ("block: move the bdi from the
request_queue to the gendisk").

Previously bdi has longer lifetime than request queue, but now it becomes
not, then either queue_to_disk() or queue->disk may cause panic.


Thanks,
Ming

