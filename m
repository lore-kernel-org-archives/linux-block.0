Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA954C433C1
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 11:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA69619BA
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 11:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhCWL1F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 07:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229879AbhCWL05 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 07:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616498817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rld1UL6tlVVUarBafZlqfVOIMz6Gjqc0bpXjGoeBHcQ=;
        b=EuOqD9CWOwA0txr5AXFCgxFg3I+z7oMeeve0mds2BBlNTdh5aO9QYdvNaxXDxmnTny4maT
        9DaGqKT8kC4VmDFPZ/pXEbgPS8gjcg6IlG65ivRwO9ccjoIHLw5gCehFjMjwIPawpehi/h
        CG5u6qayiFhn1188HriPFFv8ralEBwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-kCUt2jZsOlihBKKPhoHb2g-1; Tue, 23 Mar 2021 07:26:53 -0400
X-MC-Unique: kCUt2jZsOlihBKKPhoHb2g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC09E80364C;
        Tue, 23 Mar 2021 11:26:51 +0000 (UTC)
Received: from T590 (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AC8563622;
        Tue, 23 Mar 2021 11:26:38 +0000 (UTC)
Date:   Tue, 23 Mar 2021 19:26:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com
Subject: Re: [RFC PATCH V2 05/13] block: add req flag of REQ_TAG
Message-ID: <YFnQaXoyOhSMlAYY@T590>
References: <20210318164827.1481133-1-ming.lei@redhat.com>
 <20210318164827.1481133-6-ming.lei@redhat.com>
 <20210319173813.GC9938@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319173813.GC9938@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 19, 2021 at 01:38:13PM -0400, Mike Snitzer wrote:
> On Thu, Mar 18 2021 at 12:48pm -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > Add one req flag REQ_TAG which will be used in the following patch for
> > supporting bio based IO polling.
> 
> "REQ_TAG" is so generic yet is used in such a specific way (to mark an
> FS bio as having polling context)
> 
> I don't have a great suggestion for a better name, just seems "REQ_TAG"
> is lacking... (especially given the potential for confusion due to
> blk-mq's notion of "tag").
> 
> REQ_FS? REQ_FS_CTX? REQ_POLL? REQ_POLL_CTX? REQ_NAMING_IS_HARD :)
> 

Maybe REQ_POLL_CTX is better, it is just for marking bios:

1) which need to be polled in this context

2) which can be polled in this context

-- 
Ming

