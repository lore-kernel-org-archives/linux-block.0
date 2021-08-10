Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563FDC4338F
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 02:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A5B60F25
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 02:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhHJCsK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 22:48:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38646 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232968AbhHJCsJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Aug 2021 22:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628563667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UaCBCwtuyOPqEJj0WTFZHGBTav9viELzb4W8hqTN36E=;
        b=Ckg6mlERWGQgnrvJ5twju1YVYIG5fucjnjgQCQG0czLmk+CVIItV/ux+mNUB4+7TDLe7fI
        7+tugesVg3/4o2fBLJDY7CIM1ZPo/ELO4XhkkMdJugEmH0mc7odAQ4XE8ktlATC4owCsf7
        ov44UuKQcDB9uLX++xDLlrK6Uer0kD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-kakqJMgSPKy5OwCCsylqhQ-1; Mon, 09 Aug 2021 22:47:44 -0400
X-MC-Unique: kakqJMgSPKy5OwCCsylqhQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25FE7875047;
        Tue, 10 Aug 2021 02:47:43 +0000 (UTC)
Received: from T590 (ovpn-13-190.pek2.redhat.com [10.72.13.190])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D81CF5D9DC;
        Tue, 10 Aug 2021 02:47:36 +0000 (UTC)
Date:   Tue, 10 Aug 2021 10:47:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH] block: return ELEVATOR_DISCARD_MERGE if possible
Message-ID: <YRHoxGKjD9JHjiXh@T590>
References: <20210729034226.1591070-1-ming.lei@redhat.com>
 <YQtcZHgE1cTl+KVz@T590>
 <a60094bf-c5b7-9b26-43b6-11188409edf1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a60094bf-c5b7-9b26-43b6-11188409edf1@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 09, 2021 at 02:36:25PM -0600, Jens Axboe wrote:
> On 8/4/21 9:35 PM, Ming Lei wrote:
> > On Thu, Jul 29, 2021 at 11:42:26AM +0800, Ming Lei wrote:
> >> When merging one bio to request, if they are discard IO and the queue
> >> supports multi-range discard, we need to return ELEVATOR_DISCARD_MERGE
> >> because both block core and related drivers(nvme, virtio-blk) doesn't
> >> handle mixed discard io merge(traditional IO merge together with
> >> discard merge) well.
> >>
> >> Fix the issue by returning ELEVATOR_DISCARD_MERGE in this situation,
> >> so both blk-mq and drivers just need to handle multi-range discard.
> >>
> >> Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> >> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > 
> > Hello Jens and Guys,
> > 
> > Ping...
> 
> Since this isn't a new regression this release and since this kind
> of change always makes me a bit nervous, any objections to queueing
> it up for 5.15 with the stable/fixes tags?

Fine, will post a new version with fixes tag.

-- 
Ming

