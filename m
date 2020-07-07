Return-Path: <SRS0=CAbX=AS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A3EC433DF
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 07:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62BDA20702
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 07:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1yCZd/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGGHRJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:17:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37149 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726661AbgGGHRJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jul 2020 03:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594106228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PTBV+ndw8S9JKbMmISO7ODhQ88POe57xFK/8XW1bhfY=;
        b=d1yCZd/lwmw3SCQ4NUF0z/0D0Ijtlle9KxxKTjjJM/BqizXowghj0H+EKBvl0TqhOq5dlk
        TK+0mpyy1zo/ekn5gkX5f5/KluGw+LOI/s6cbk67C+3XRLRPobJTue3XPiemI5RFihWma1
        cs5uTB0EXGLBoT7EsBqek9saWeSf8jU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-8tr40A0-PJeK04fY2uDF4Q-1; Tue, 07 Jul 2020 03:17:04 -0400
X-MC-Unique: 8tr40A0-PJeK04fY2uDF4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64DED107ACF3;
        Tue,  7 Jul 2020 07:17:03 +0000 (UTC)
Received: from T590 (ovpn-12-188.pek2.redhat.com [10.72.12.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D84D5D9C9;
        Tue,  7 Jul 2020 07:16:57 +0000 (UTC)
Date:   Tue, 7 Jul 2020 15:16:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] blk-mq: centralise related handling into
 blk_mq_get_driver_tag
Message-ID: <20200707071652.GA3269442@T590>
References: <20200706144111.3260859-1-ming.lei@redhat.com>
 <841c8170-f082-814a-70cc-b0e3e8b5be54@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <841c8170-f082-814a-70cc-b0e3e8b5be54@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 07, 2020 at 07:37:41AM +0100, John Garry wrote:
> On 06/07/2020 15:41, Ming Lei wrote:
> > -	hctx = flush_rq->mq_hctx;
> >   	if (!q->elevator) {
> 
> Is there a specific reason we do:
> 
> if (!a)
> 	do x
> else
> 	do y
> 
> as opposed to:
> 
> if (a)
> 	do y
> else
> 	do x
> 
> Do people find this easier to read or more obvious? Just wondering.

If you like the style, please go ahead to switch to this way.

The check on 'q->elevator' isn't added by this patch, and it won't be
this patch's purpose at all.


Thanks, 
Ming

