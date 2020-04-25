Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54309C55186
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 09:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F381420706
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 09:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYsuM8TE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDYJwQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 05:52:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56375 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726022AbgDYJwQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 05:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587808334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xuUhk02c8y0W8z5ygTDRPncJIGJ5D07e4IrnZlLPk8I=;
        b=FYsuM8TE4qniy+H2/zIaQ1E05jmJB8n6+/wXOINNUO6kYqMiv0p4WREtqyBySfFjAdHgrj
        qJulAz0VtLe6RvThkE1lZF3f9oYDTFKzj/JwNjdJEkoG8x96y5ti7oJ96PfO03mpXaTAPr
        BV+z6sze4yICOqRIdKr5MTfC3piikbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-hFReAl5XPSilYvCN6RLIPA-1; Sat, 25 Apr 2020 05:52:10 -0400
X-MC-Unique: hFReAl5XPSilYvCN6RLIPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E28FC8015CB;
        Sat, 25 Apr 2020 09:52:08 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A1C15D70C;
        Sat, 25 Apr 2020 09:52:01 +0000 (UTC)
Date:   Sat, 25 Apr 2020 17:51:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V8 08/11] block: add blk_end_flush_machinery
Message-ID: <20200425095156.GB495669@T590>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-9-ming.lei@redhat.com>
 <20200424104136.GE28156@lst.de>
 <20200425034405.GG477579@T590>
 <20200425081125.GA5427@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425081125.GA5427@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 25, 2020 at 10:11:25AM +0200, Christoph Hellwig wrote:
> On Sat, Apr 25, 2020 at 11:44:05AM +0800, Ming Lei wrote:
> > > FYI, we don't really need the bdev to send a bio anymore, this could just
> > > do:
> > > 
> > > 	bio = bio_alloc(GFP_KERNEL, 0); // XXX: shouldn't this be GFP_NOIO??
> > 
> > Error handling.
> 
> bio_alloc does not fail for allocations that can sleep.
> 
> > 
> > > 	bio->bi_disk = rq->rq_disk;
> > > 	bio->bi_partno = 0;
> > > 	bio_associate_blkg(bio); // XXX: actually, shouldn't this come from rq?
> > > 	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
> > > 	error = submit_bio_wait(bio);
> > > 	bio_put(bio);
> > 
> > Yeah, that is another way, however I prefer to blkdev_issue_flush
> > because it takes less code and we do have the API of blkdev_issue_flush.
> 
> It is about the same amount of code, and as commented above I think the
> current code uses the wrong blkg assignment.

There can be lots of flush requests which reply on this single flush
emulation, then there can be more associated blkgs, so not sure we can
select a correct one. But this single flush emulation is only triggered
in very unlikey case, does it really matter to select one 'correct' blkcg
for this single flush request without DATA?

BTW, block/blk-flush.c does run aggressive flush merge by the built-in
per-hctx flush request and double queues, and blkcg can't account actual
flush request accurately.

Thanks, 
Ming

