Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8A4C433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 09:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbiGVJIP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 05:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiGVJH7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 05:07:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B53E59FE39
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 02:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658480821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B9Ir2c2JvWf3oST9qGNjswV+dkWoW/lcLtdqAFUz+vU=;
        b=g/m1wXB7SWH4uG64l5uSXecRewHmidFl0eF40WaXPcirop0HyEu16biRwVN4DDH8TVTqg/
        EbAsABzmycvZHxVQBtqTWl1qLNWkYYiOKtDmBeIOEcQjM2H69QQsLboDx3xRn2Im26VntY
        L/XUAWHqm/9diFAIHAZxXvaippEbuS4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-CnLTfc7GOaiUaxNqjnZulg-1; Fri, 22 Jul 2022 05:06:52 -0400
X-MC-Unique: CnLTfc7GOaiUaxNqjnZulg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6ABE18E0043;
        Fri, 22 Jul 2022 09:06:51 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79328403D0E2;
        Fri, 22 Jul 2022 09:06:47 +0000 (UTC)
Date:   Fri, 22 Jul 2022 17:06:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: ublk vs write cache and FUA
Message-ID: <YtpooYTRpjuV3dV4@T590>
References: <20220721151458.GA4399@lst.de>
 <YtlwYKu8S4SV68MK@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtlwYKu8S4SV68MK@T590>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 21, 2022 at 11:27:28PM +0800, Ming Lei wrote:
> On Thu, Jul 21, 2022 at 05:14:58PM +0200, Christoph Hellwig wrote:
> > Hi Ming,
> > 
> > ublk implements REQ_OP_FLUSH and REQ_FUA, but will never see those as
> > it never calls blk_queue_write_cache.  Can we drop the code?  Or should
> > there be a flag to enable write cache and fua support when setting up
> > a device?
> 
> There should have been flags defined in ublksrv_ctrl_dev_info for describe
> wc/fua info, since ublk_drv doesn't handle any device specific logic.
> 
> So please keep REQ_OP_FLUSH and REQ_FUA which two should be useful, and I
> will add flags and related code to use them.

Actually we can add two commands for set/get device parameter, then at least
generic block device parameters(wc, fua, discard, zoned, rototional, ...)
can be configurable, so all kinds of block device can be simulated
with userspace ublk.

Thanks,
Ming

