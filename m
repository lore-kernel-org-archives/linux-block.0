Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8824FC83002
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 01:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58553206D9
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 01:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1CvNqYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgD1BKg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 21:10:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57667 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726233AbgD1BKg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 21:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588036235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lakza7Mu2g9x2rU8Ax4iFe6mUdEXOZQS631bq7FPROk=;
        b=a1CvNqYxaHIFvbAStQ/YCN4gqCf0QdJvPpIkcyMrykoPc6Y1IKAUo/kcg6PVrFia+nFDZG
        MYaN3aNTwHoUzoYxV6Q58Bg4YpQPbqfzTWg+QoWu4gDHOGNkmhUMmgjjs5gVK9/2vigTxy
        L/Pgste2CA1FEYyEP2UoLBuLa5lt8As=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-oLJzwAzZNpC0pM00MasEZA-1; Mon, 27 Apr 2020 21:10:31 -0400
X-MC-Unique: oLJzwAzZNpC0pM00MasEZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68BCD8015CE;
        Tue, 28 Apr 2020 01:10:29 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DC155D9DD;
        Tue, 28 Apr 2020 01:10:20 +0000 (UTC)
Date:   Tue, 28 Apr 2020 09:10:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        peterz@infradead.org, paulmck@kernel.org
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200428011014.GA603273@T590>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-8-ming.lei@redhat.com>
 <20200424103851.GD28156@lst.de>
 <20200425031723.GC477579@T590>
 <20200425083224.GA5634@lst.de>
 <20200425093437.GA495669@T590>
 <20200425095351.GC495669@T590>
 <20200425154832.GA16004@lst.de>
 <20200426020621.GA511475@T590>
 <20200427153601.GA7802@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200427153601.GA7802@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 27, 2020 at 05:36:01PM +0200, Christoph Hellwig wrote:
> On Sun, Apr 26, 2020 at 10:06:21AM +0800, Ming Lei wrote:
> > On Sat, Apr 25, 2020 at 05:48:32PM +0200, Christoph Hellwig wrote:
> > > FYI, here is what I think we should be doing (but the memory model
> > > experts please correct me):
> > >=20
> > >  - just drop the direct_issue flag and check for the CPU, which is
> > >    cheap enough
> >=20
> > That isn't correct because the CPU for running async queue may not be
> > same with rq->mq_ctx->cpu since hctx->cpumask may include several CPU=
s
> > and we run queue in RR style and it is really a normal case.
>=20
> But in that case the memory barrier really doesn't matter anywa=E1=BA=8F=
.

It might be true, however we can save the cost with zero cost, why
not do it? Also with document benefit.


Thanks,
Ming

