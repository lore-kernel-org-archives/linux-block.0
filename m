Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7674C4338F
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 03:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 893BC61051
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 03:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbhHJD3R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 23:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236799AbhHJD3N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Aug 2021 23:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628566131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zU+tbeF5cdcnLxTRgRGaA9ZLrJOz63y76gvrboLDlDI=;
        b=W/g15d9sXk3ZYRbvb7X4GtGrwy1+zgdyjy/XtEYwYwgj6Ix7t8FkmF0a8Lq4/6M+6MvXoK
        VLnEeC1XFuvkmPSzrh+y7xFmRFP7LXGDP2OsLEFlPfXKoUrnV0t1TUm+aLk/OJ41V7VrG1
        aFTyPO6mbLbHx0TNyt6PX+s990/L4GE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-qDEt7pi5NryyMkDZYSr9og-1; Mon, 09 Aug 2021 23:28:47 -0400
X-MC-Unique: qDEt7pi5NryyMkDZYSr9og-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52EF5801B3C;
        Tue, 10 Aug 2021 03:28:46 +0000 (UTC)
Received: from T590 (ovpn-13-190.pek2.redhat.com [10.72.13.190])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 671A419D9B;
        Tue, 10 Aug 2021 03:28:39 +0000 (UTC)
Date:   Tue, 10 Aug 2021 11:28:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH] block: return ELEVATOR_DISCARD_MERGE if possible
Message-ID: <YRHyYmqxNSMMdyXo@T590>
References: <20210729034226.1591070-1-ming.lei@redhat.com>
 <YQtcZHgE1cTl+KVz@T590>
 <a60094bf-c5b7-9b26-43b6-11188409edf1@kernel.dk>
 <YRHoxGKjD9JHjiXh@T590>
 <eabcef59-64a1-6e6e-adbd-5924fabf9810@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eabcef59-64a1-6e6e-adbd-5924fabf9810@kernel.dk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 09, 2021 at 08:55:16PM -0600, Jens Axboe wrote:
> On 8/9/21 8:47 PM, Ming Lei wrote:
> > On Mon, Aug 09, 2021 at 02:36:25PM -0600, Jens Axboe wrote:
> >> On 8/4/21 9:35 PM, Ming Lei wrote:
> >>> On Thu, Jul 29, 2021 at 11:42:26AM +0800, Ming Lei wrote:
> >>>> When merging one bio to request, if they are discard IO and the queue
> >>>> supports multi-range discard, we need to return ELEVATOR_DISCARD_MERGE
> >>>> because both block core and related drivers(nvme, virtio-blk) doesn't
> >>>> handle mixed discard io merge(traditional IO merge together with
> >>>> discard merge) well.
> >>>>
> >>>> Fix the issue by returning ELEVATOR_DISCARD_MERGE in this situation,
> >>>> so both blk-mq and drivers just need to handle multi-range discard.
> >>>>
> >>>> Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> >>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>>
> >>> Hello Jens and Guys,
> >>>
> >>> Ping...
> >>
> >> Since this isn't a new regression this release and since this kind
> >> of change always makes me a bit nervous, any objections to queueing
> >> it up for 5.15 with the stable/fixes tags?
> > 
> > Fine, will post a new version with fixes tag.
> 
> Sorry if I wasn't clear, I mean are you fine with queueing this for
> 5.15? I already did add the fixes tag.

Sorry for misunderstanding your point, yeah, I am fine with queuing in
5.15.


Thanks,
Ming

