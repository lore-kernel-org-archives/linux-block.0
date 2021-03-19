Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57047C433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 16:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D0561942
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 16:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhCSQw6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 12:52:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56097 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230047AbhCSQwz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 12:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616172774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GQrOYOQ4JqTkQFy6p6LfwIHWaCJbsAcGeIAzSro5ONk=;
        b=NzOCYtjOByw1yNoAomY68fXZpvnLwv8ifFB6Hnp69VlMvlWiNEmtrffrMDVyYsaWt5FJvi
        IlQxA7VAfIXU8p40l95Fo/g5it/wtLY3wDnOACHynpq42Lza6Oh4+b5zdlaVAd/BRmfFu/
        HOwx/kLrhBtTLcPzVxalZfvzyUpXIZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-vNzuYJbmMnm4cjjlYMbbZw-1; Fri, 19 Mar 2021 12:52:51 -0400
X-MC-Unique: vNzuYJbmMnm4cjjlYMbbZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9737E1009456;
        Fri, 19 Mar 2021 16:52:50 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 715F060CD0;
        Fri, 19 Mar 2021 16:52:42 +0000 (UTC)
Date:   Fri, 19 Mar 2021 12:52:42 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com
Subject: Re: [RFC PATCH V2 01/13] block: add helper of blk_queue_poll
Message-ID: <20210319165241.GA9938@redhat.com>
References: <20210318164827.1481133-1-ming.lei@redhat.com>
 <20210318164827.1481133-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318164827.1481133-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 18 2021 at 12:48pm -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> There has been 3 users, and will be more, so add one such helper.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Not sure if you're collecting Reviewed-by or Acked-by at this point?
Seems you dropped Chaitanya's Reviewed-by to v1:
https://listman.redhat.com/archives/dm-devel/2021-March/msg00166.html

Do you plan to iterate a lot more before you put out a non-RFC?  For
this RFC v2, I'll withhold adding any of my Reviewed-by tags and just
reply where I see things that might need folding into the next
iteration.

Mike

