Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBFCC433DF
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 02:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A76207DE
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 02:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enfRDsF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgHUCus (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Aug 2020 22:50:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22740 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726975AbgHUCur (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 22:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597978246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bTrDBXFli6DNtQgCYAzM9zRVnvXOXoJft3x/mnoAhog=;
        b=enfRDsF93AuBvwKc78o015b8bz/7vnXRLe+Ydg5EnmPNFriSgjlHTnww7Zyv/s0HRbzFWY
        PAcFiVqqpdjj5MRJwqStNBPzhb0sryiyDWqBecqw2w+9qBdeHXXlGwl1Lces5h/YQ42DZe
        J/opCz6S0XrRSdtKcYxTFKGyHFfSb/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-yD1Z5KMDP86P147aURmptA-1; Thu, 20 Aug 2020 22:50:02 -0400
X-MC-Unique: yD1Z5KMDP86P147aURmptA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E644B425D8;
        Fri, 21 Aug 2020 02:50:00 +0000 (UTC)
Received: from T590 (ovpn-13-106.pek2.redhat.com [10.72.13.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CBC27E306;
        Fri, 21 Aug 2020 02:49:53 +0000 (UTC)
Date:   Fri, 21 Aug 2020 10:49:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/5] blk-mq: fix use-after-free on stale request
Message-ID: <20200821024949.GA3110165@T590>
References: <20200820180335.3109216-1-ming.lei@redhat.com>
 <accb98d8-8186-2e74-a5c3-e0f09ce2b3ff@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <accb98d8-8186-2e74-a5c3-e0f09ce2b3ff@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Bart,

On Thu, Aug 20, 2020 at 01:30:38PM -0700, Bart Van Assche wrote:
> On 8/20/20 11:03 AM, Ming Lei wrote:
> > We can't run allocating driver tag and updating tags->rqs[tag] atomically,
> > so stale request may be retrieved from tags->rqs[tag]. More seriously, the
> > stale request may have been freed via updating nr_requests or switching
> > elevator or other use cases.
> > 
> > It is one long-term issue, and Jianchao previous worked towards using
> > static_rqs[] for iterating request, one problem is that it can be hard
> > to use when iterating over tagset.
> > 
> > This patchset takes another different approach for fixing the issue: cache
> > freed rqs pages and release them until all tags->rqs[] references on these
> > pages are gone.
> 
> Hi Ming,
> 
> Is this the only possible solution? Would it e.g. be possible to protect the
> code that iterates over all tags with rcu_read_lock() / rcu_read_unlock() and
> to free pages that contain request pointers only after an RCU grace period has
> expired?

That can't work, tags->rqs[] is host-wide, request pool belongs to scheduler tag
and it is owned by request queue actually. When one elevator is switched on this
request queue or updating nr_requests, the old request pool of this queue is freed,
but IOs are still queued from other request queues in this tagset. Elevator switch
or updating nr_requests on one request queue shouldn't or can't other request queues
in the same tagset.

Meantime the reference in tags->rqs[] may stay a bit long, and RCU can't cover this
case. 

Also we can't reset the related tags->rqs[tag] simply somewhere, cause it may
race with new driver tag allocation. Or some atomic update is required,
but obviously extra load is introduced in fast path.

> Would that perhaps result in a simpler solution?

No, that doesn't work actually.

This patchset looks complicated, but the idea is very simple. With this
approach, we can extend to support allocating request pool attached to
driver tags dynamically. So far, it is always pre-allocated, and never be
used for normal single queue disks.


Thanks,
Ming

