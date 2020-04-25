Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED86AC2BA19
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 03:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B6720704
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 03:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnzNh+rp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDYDwa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 23:52:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55656 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbgDYDwa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 23:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587786749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RRZzmfGWY3IbOcLID5LNJacprwVbSJHH9WKavsVb3EQ=;
        b=gnzNh+rpE9LF5REGCE0Yd86KDh74xXLobCzi8Jbnbz45+/I7mHmPJm4MsmzJ0ORvyZ9hGm
        WImQiUKp7ZK2tZ4e2JcxF6ShSHZy/IWBLOWBWdDnNdUfHU3t0uwOKIq1HIDsnzRTEMYoSt
        2A3b6KM5dwO/7hb1fGBctFsu97yFzjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-zun3pFc1N6qmxTUP9WoVwg-1; Fri, 24 Apr 2020 23:52:27 -0400
X-MC-Unique: zun3pFc1N6qmxTUP9WoVwg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEA6A1005510;
        Sat, 25 Apr 2020 03:52:25 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 384A81001B2C;
        Sat, 25 Apr 2020 03:52:17 +0000 (UTC)
Date:   Sat, 25 Apr 2020 11:52:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V8 10/11] blk-mq: re-submit IO in case that hctx is
 inactive
Message-ID: <20200425035212.GJ477579@T590>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-11-ming.lei@redhat.com>
 <20200424104458.GA28721@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424104458.GA28721@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 24, 2020 at 12:44:58PM +0200, Christoph Hellwig wrote:
> > +	/* avoid allocation failure by clearing NOWAIT */
> > +	nrq = blk_get_request(rq->q, rq->cmd_flags & ~REQ_NOWAIT, flags);
> > +	if (!nrq)
> > +		return;
> > +
> > +	blk_rq_copy_request(nrq, rq);
> > +
> > +	nrq->timeout = rq->timeout;
> 
> Shouldn't the timeout also go into blk_rq_copy_request?

I'd suggest to not do it because dm-rq clones request between
two different queues, and different queue may have different default
timeout value. And I guess that is why dm-rq code doesn't do that.


Thanks, 
Ming

