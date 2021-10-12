Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9EEC433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 15:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2EA260C4A
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 15:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbhJLPQM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:16:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229633AbhJLPQL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 11:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634051649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2xvN2vLxgg7nr/3sm0rZxnDgmYjVBd3T2S4YxkSk3YY=;
        b=UH8xot7bRgz3vSt+nKIup9VGpl81ONdftqc2hb96QR9f1+YhSzBzOT8M9tOnJf5RLAnxfC
        TZkE9evLAkdKFYESP1eK0X9mMvExydslrX5tBYsgoHhHCIc3PGnosRCGIt+Yt5AoMV68hC
        V0KsHXJmug6X56D0Sp1DxaGYnwypTiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-i9Dvu8TpNbmzFE8yTvmj4A-1; Tue, 12 Oct 2021 11:14:08 -0400
X-MC-Unique: i9Dvu8TpNbmzFE8yTvmj4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9719B112A0A0;
        Tue, 12 Oct 2021 15:14:06 +0000 (UTC)
Received: from T590 (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AC0F196FA;
        Tue, 12 Oct 2021 15:14:01 +0000 (UTC)
Date:   Tue, 12 Oct 2021 23:13:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 6/6] blk-mq: support concurrent queue quiesce/unquiesce
Message-ID: <YWWmNMNKEUtBI1EH@T590>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
 <20211009034713.1489183-7-ming.lei@redhat.com>
 <20211012103010.GA29640@lst.de>
 <YWWki6An1sOpx3rV@T590>
 <20211012150827.GB20571@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012150827.GB20571@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 12, 2021 at 05:08:27PM +0200, Christoph Hellwig wrote:
> On Tue, Oct 12, 2021 at 11:06:51PM +0800, Ming Lei wrote:
> > > We can get rid of the QUEUE_FLAG_QUIESCED flag now and just look
> > > at ->quiesce_depth directly.
> > 
> > I'd rather not to do that given we need to check QUEUE_FLAG_QUIESCED in fast
> > path.
> 
> Checking an integer vs checking a bit is easier actually faster or at
> least the same speed depending on the architecture / micro architecture.

->queue_flag is always hot, but quiesce_depth can't be and shouldn't be
since it is used very less.


-- 
Ming

