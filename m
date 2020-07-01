Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2F5C433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 13:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99F2A206B6
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 13:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuP/lgMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbgGANpe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:45:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41859 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731194AbgGANp2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 09:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593611127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DZxSkx34tkBmlaabILfMfIsOlNK9eGRAl15m0sVIO5M=;
        b=iuP/lgMrbRGY0wP/AYbu+J69a+BQAw+I7f8rMXVkqr9hiQQF9VhYZQR83TLBUsvmY6jYDc
        duSM8oU2mUA7t1FFGbsuv3qPaCm7ZgpMaO76EgnafLdbjjHy97qv6uBzIXKnuWtA89AYTC
        +gsERGyAaLhC57ogIO6Gvxq3zIbN5Us=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-wsgrDM6yNca50KONfE81uQ-1; Wed, 01 Jul 2020 09:45:25 -0400
X-MC-Unique: wsgrDM6yNca50KONfE81uQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F2D7800C60;
        Wed,  1 Jul 2020 13:45:23 +0000 (UTC)
Received: from T590 (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D1D710013C0;
        Wed,  1 Jul 2020 13:45:17 +0000 (UTC)
Date:   Wed, 1 Jul 2020 21:45:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] blk-mq: put driver tag when this request is completed
Message-ID: <20200701134512.GA2443512@T590>
References: <20200629094759.2002708-1-ming.lei@redhat.com>
 <CGME20200701130104eucas1p1f8dcce58bf704b726aee1e89980fe19e@eucas1p1.samsung.com>
 <57fb09b1-54ba-f3aa-f82c-d709b0e6b281@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57fb09b1-54ba-f3aa-f82c-d709b0e6b281@samsung.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Marek,

On Wed, Jul 01, 2020 at 03:01:03PM +0200, Marek Szyprowski wrote:
> Hi
> 
> On 29.06.2020 11:47, Ming Lei wrote:
> > It is natural to release driver tag when this request is completed by
> > LLD or device since its purpose is for LLD use.
> >
> > One big benefit is that the released tag can be re-used quicker since
> > bio_endio() may take too long.
> >
> > Meantime we don't need to release driver tag for flush request.
> >
> > Cc: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> This patch landed recently in linux-next as commit 36a3df5a4574. Sadly 
> it causes a regression on one of my test systems (ARM 32bit, Samsung 
> Exynos5422 SoC based Odroid XU3 board with eMMC). The system boots fine 
> and then after a few seconds every executed command hangs. No 
> panic/ops/any other message. I will try to provide more information asap 
> I find something to share. Simple reverting it in linux-next is not 
> possible due to dependencies.

What is the exact eMMC's driver code(include the host driver)?

The usual way for handling completion is that host driver notifies block
layer via blk_mq_complete_request() after the LLD specific handling for
this request is done.

However, there might be driver which may use rq->tag in its rq completion
handler. I will see if the special case can be dealt with once you share
the driver info.


Thanks,
Ming

