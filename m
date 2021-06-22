Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CF2C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 03:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 517D461245
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 03:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFVDzu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 23:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230175AbhFVDzt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 23:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624334013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TTOoBzy5Pc6BKE55zDBFRGlAIB24VURtdt6nY/E4PYA=;
        b=UXyuDtxtBUgmlA8k0xnoOe/iNsIptANhCH3TfRq/XBbasl8LoeIZHZ3qGA0juCU4DzAiwH
        osY4MgTdKxjHij33oyEOJ/tcFWEKLoeCJOQ0HldB0DN4l+b8o7crC6CKTAckX7KwGSD4uw
        2nhGDdx/7hlERtJI1LzgjBNJ8uu8yCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-O8DVwVW5NyykPTdd-wr0ow-1; Mon, 21 Jun 2021 23:53:32 -0400
X-MC-Unique: O8DVwVW5NyykPTdd-wr0ow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE62619057A2;
        Tue, 22 Jun 2021 03:53:30 +0000 (UTC)
Received: from T590 (ovpn-13-127.pek2.redhat.com [10.72.13.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 201885C1C2;
        Tue, 22 Jun 2021 03:53:23 +0000 (UTC)
Date:   Tue, 22 Jun 2021 11:53:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        Wang Shanker <shankerwangmiao@gmail.com>
Subject: Re: [PATCH 0/2] block: discard merge fix & improvement
Message-ID: <YNFer5pHg3safxCZ@T590>
References: <20210609004556.46928-1-ming.lei@redhat.com>
 <YMfRax3F8NQL4E9V@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMfRax3F8NQL4E9V@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 15, 2021 at 06:00:11AM +0800, Ming Lei wrote:
> On Wed, Jun 09, 2021 at 08:45:54AM +0800, Ming Lei wrote:
> > Hello Guys,
> > 
> > The 1st patch fixes request merge for single-range discard request.
> > 
> > The 2nd one improves request merge for multi-range discard request,
> > so that any continuous bios can be merged to one range.
> > 
> > 
> > Ming Lei (2):
> >   block: fix discard request merge
> >   block: support bio merge for multi-range discard
> > 
> >  block/blk-merge.c          | 20 +++++++++------
> >  drivers/block/virtio_blk.c |  9 ++++---
> >  drivers/nvme/host/core.c   |  8 +++---
> >  include/linux/blkdev.h     | 51 ++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 72 insertions(+), 16 deletions(-)
> > 
> > Cc: Wang Shanker <shankerwangmiao@gmail.com>
> 
> Hello Guys,
> 
> Ping...

Hello,

Any comments on the two patches?


Thanks,
Ming

