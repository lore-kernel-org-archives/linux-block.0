Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB04C433DF
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 00:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F3320659
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 00:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFwqhiyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgENAvB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 20:51:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56304 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730617AbgENAvA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 20:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589417459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C8HeAGQVXe8PjUCyXkQx7atkFyX4b64zrQDnn2L/RDs=;
        b=JFwqhiyYcMaT+PNM5uFqGZQzl2zXPizn9sFm6wEiZ+yFtAT58c8OFOY55GAVIUyYapwvTl
        FiQ55F5GFIMamFzZDjUV5v7NnTLPjkRcXoCUh/16uqSz619+/ROVtLA8TIEIWinwv24LEc
        ZBuIUDEIpuN9yIzc9BkOTrIB3MMXkUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-E8EREa2wNUW0QPRTLCNl3A-1; Wed, 13 May 2020 20:50:55 -0400
X-MC-Unique: E8EREa2wNUW0QPRTLCNl3A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B0F880183C;
        Thu, 14 May 2020 00:50:54 +0000 (UTC)
Received: from T590 (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A0EF5C1BE;
        Thu, 14 May 2020 00:50:47 +0000 (UTC)
Date:   Thu, 14 May 2020 08:50:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [PATCH 3/9] blk-mq: don't predicate last flag in
 blk_mq_dispatch_rq_list
Message-ID: <20200514005043.GE2073570@T590>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-4-ming.lei@redhat.com>
 <20200513122753.GC23958@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513122753.GC23958@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 05:27:53AM -0700, Christoph Hellwig wrote:
> On Wed, May 13, 2020 at 05:54:37PM +0800, Ming Lei wrote:
> > .commit_rqs() is supposed to handle partial dispatch when driver may not
> > see .last of flag passed to .queue_rq().
> > 
> > We have added .commit_rqs() in case of partial dispatch and all consumers
> > of bd->last have implemented .commit_rqs() callback, so it is perfect to
> > pass real .last flag of the request list to .queue_rq() instead of faking
> > it by trying to allocate driver tag for next request in the batching list.
> 
> The current case still seems like a nice optimization to avoid an extra
> indirect function call.  So if you want to get rid of it I think it at
> least needs a better rationale.

You mean marking .last by trying to allocate for next request can
replace .commit_rqs()? No, it can't because .commit_rqs() can be
called no matter .last is set or not, both two are independent.

Removing it can avoid to pre-allocate one extra driver tag, and
improve driver tag's utilization.

Thanks,
Ming

