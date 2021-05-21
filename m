Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47A5C433ED
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 13:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8995E613EB
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 13:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbhEUNVD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 09:21:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44238 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234115AbhEUNUw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 09:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621603168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DV6QcLVJxYsPugY+TrwCJz6OMYma9ft7iTrSKMC4vO8=;
        b=OYzmvqPJoxwCuUSIh07PNeUvDYEC5PfxSWCR8pBvbb8O8TTHEFrPNo9RI8+BjRRNvHD5Bd
        gKJC7ci3GIAdBukrWVsp7MY2MIA6B4i+VCORiabVG/Fvwa7oTffhEtQEtfdVUdlnJXKyf+
        Y/g2OjGOQ818ivCF2u83RZJEJ43bhCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-4StWroG9OTqoPdffEzrQjQ-1; Fri, 21 May 2021 09:19:27 -0400
X-MC-Unique: 4StWroG9OTqoPdffEzrQjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2600A40C4;
        Fri, 21 May 2021 13:19:25 +0000 (UTC)
Received: from T590 (ovpn-12-67.pek2.redhat.com [10.72.12.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD4E06087C;
        Fri, 21 May 2021 13:19:07 +0000 (UTC)
Date:   Fri, 21 May 2021 21:18:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: Do not pull requests from the scheduler when we
 cannot dispatch them
Message-ID: <YKezParMURhgPiLH@T590>
References: <20210520112528.16250-1-jack@suse.cz>
 <YKcM/TWxSAQv7KHg@T590>
 <20210521112016.GH18952@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521112016.GH18952@quack2.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 21, 2021 at 01:20:16PM +0200, Jan Kara wrote:
> On Fri 21-05-21 09:29:33, Ming Lei wrote:
> > On Thu, May 20, 2021 at 01:25:28PM +0200, Jan Kara wrote:
> > > Provided the device driver does not implement dispatch budget accounting
> > > (which only SCSI does) the loop in __blk_mq_do_dispatch_sched() pulls
> > > requests from the IO scheduler as long as it is willing to give out any.
> > > That defeats scheduling heuristics inside the scheduler by creating
> > > false impression that the device can take more IO when it in fact
> > > cannot.
> > 
> > So hctx->dispatch_busy isn't set as true in this case?
> 
> No. blk_mq_update_dispatch_busy() has:
> 
>         if (hctx->queue->elevator)
>                 return;

ooops, the above check should have been killed in commit 6e6fcbc27e77
("blk-mq: support batching dispatch in case of io"), :-(


Thanks,
Ming

