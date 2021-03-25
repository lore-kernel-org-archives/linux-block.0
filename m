Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3046C433DB
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 00:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB3861A13
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 00:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239319AbhCYAau (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 20:30:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239344AbhCYAah (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 20:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616632236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zb1munGH1BL6nLwLZ1MkpFhLWjSV89XYEuB0NfsLzTI=;
        b=feN54yOwZ02NQJtkPoYBmgjrSGicZSElvOhK1k84lol7tjRLUoCUbaZEEqVvC76ryrmC+O
        eszF26ZzzGGrP8nlnccUn3o4l9KOqSSCJGiwtziwbEECyiDn+2OPaupr6E/5bHtOiTnG8p
        99BhTd/EtimTlyRR0/NZpPmfICY+lx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-mfMx3IN2MBuSDPOV1_kWEA-1; Wed, 24 Mar 2021 20:30:34 -0400
X-MC-Unique: mfMx3IN2MBuSDPOV1_kWEA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AE6E107ACCD;
        Thu, 25 Mar 2021 00:30:33 +0000 (UTC)
Received: from T590 (ovpn-12-137.pek2.redhat.com [10.72.12.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8906963BA7;
        Thu, 25 Mar 2021 00:30:20 +0000 (UTC)
Date:   Thu, 25 Mar 2021 08:30:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Subject: Re: [PATCH V3 03/13] block: add helper of blk_create_io_context
Message-ID: <YFvZmB0LKCQRkoSG@T590>
References: <20210324121927.362525-1-ming.lei@redhat.com>
 <20210324121927.362525-4-ming.lei@redhat.com>
 <YFuCHvUFwhYRNa6Z@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFuCHvUFwhYRNa6Z@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 24, 2021 at 07:17:02PM +0100, Christoph Hellwig wrote:
> On Wed, Mar 24, 2021 at 08:19:17PM +0800, Ming Lei wrote:
> > Add one helper for creating io context and prepare for supporting
> > efficient bio based io poll.
> 
> Looking at what gets added later here I do not think this helper is
> a good idea.  Having a separate one for creating any needed poll-only
> context is a lot more clear.

The poll context actually depends on io_context, that is why I put them
all into one single helper.

thanks,
Ming

