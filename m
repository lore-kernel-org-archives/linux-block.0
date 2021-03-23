Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9530AC433C1
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 11:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 697D1619B8
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 11:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhCWLSa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 07:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhCWLR6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 07:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616498277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fEyCPjfB1lRuNmux4TUgSTUDLeSi+0dHPVKsXtM+qB4=;
        b=RK++CBbhnTgXLzFQJh9QwsWw4njc5WwItevt9kAY/5mQ0f2PQG839xewKJ4oQc771ybHzH
        xIvt1WqNVkfPA699WMHhml2WkcMMEuAjgUHUIXBGif2eF78SpWfCsGumkbiQrl9U7pjn3G
        BUec+mUQiDVTpHYr4prFGB9doYI1Z5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-0R8p61ecNwGufIGiH6IZ_Q-1; Tue, 23 Mar 2021 07:17:53 -0400
X-MC-Unique: 0R8p61ecNwGufIGiH6IZ_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E39B5B361;
        Tue, 23 Mar 2021 11:17:52 +0000 (UTC)
Received: from T590 (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FD871002D71;
        Tue, 23 Mar 2021 11:17:38 +0000 (UTC)
Date:   Tue, 23 Mar 2021 19:17:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com
Subject: Re: [RFC PATCH V2 01/13] block: add helper of blk_queue_poll
Message-ID: <YFnOS23G0OcL34RI@T590>
References: <20210318164827.1481133-1-ming.lei@redhat.com>
 <20210318164827.1481133-2-ming.lei@redhat.com>
 <20210319165241.GA9938@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319165241.GA9938@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 19, 2021 at 12:52:42PM -0400, Mike Snitzer wrote:
> On Thu, Mar 18 2021 at 12:48pm -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > There has been 3 users, and will be more, so add one such helper.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Not sure if you're collecting Reviewed-by or Acked-by at this point?
> Seems you dropped Chaitanya's Reviewed-by to v1:
> https://listman.redhat.com/archives/dm-devel/2021-March/msg00166.html

Sorry, that should be an accident.

> 
> Do you plan to iterate a lot more before you put out a non-RFC?  For
> this RFC v2, I'll withhold adding any of my Reviewed-by tags and just
> reply where I see things that might need folding into the next
> iteration.

If no one objects the basic approach taken in V2, I will remove RFC in
V3.

-- 
Ming

