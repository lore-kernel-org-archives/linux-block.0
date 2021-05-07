Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB18C433ED
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 02:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE79E61002
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 02:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhEGCHK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 22:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231288AbhEGCHK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 May 2021 22:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620353170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e80Gr4V4YHAMEV0Dn0mj+UfWD+HL+cQnSu5i/9UXof8=;
        b=hDYyOXItl4/F96WNyiFkyD+OXM/LV5rIZbZ9J3RQo7EaN9dvFYB5hl1UEWKo+B+8mdCaqP
        iT4G0lQDURgCPOYmRun/By3vEwkYz4v9bpXsXdii4HhFMJ7SxLejawBr6blNuVvzo5yeqQ
        upe6qsBTch5eWcKNnCgS33w6uMfKn9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-qA68oXV5MK2LE7CkJN-aEQ-1; Thu, 06 May 2021 22:06:09 -0400
X-MC-Unique: qA68oXV5MK2LE7CkJN-aEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CE021006C84;
        Fri,  7 May 2021 02:06:07 +0000 (UTC)
Received: from T590 (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01B93196A1;
        Fri,  7 May 2021 02:05:58 +0000 (UTC)
Date:   Fri, 7 May 2021 10:05:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V5 3/4] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
Message-ID: <YJSggHqgMFfWIALu@T590>
References: <20210505145855.174127-1-ming.lei@redhat.com>
 <20210505145855.174127-4-ming.lei@redhat.com>
 <20210506071256.GD328487@infradead.org>
 <YJOb+a85Cpb56Mdz@T590>
 <20210506121849.GA400362@infradead.org>
 <b21d9e07-577b-f9cd-257f-323a82d8d74d@acm.org>
 <YJSFm99PUlLedF+D@T590>
 <739456b9-e8d4-310e-9bf3-7b8930a1e51c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <739456b9-e8d4-310e-9bf3-7b8930a1e51c@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 06, 2021 at 06:10:09PM -0700, Bart Van Assche wrote:
> On 5/6/21 5:11 PM, Ming Lei wrote:
> > On Thu, May 06, 2021 at 07:51:53AM -0700, Bart Van Assche wrote:
> > > I'm not sure that would be a better name since I don't think that it is
> > > necessary to hold that lock around the cmpxchg() calls. How about using
> > > something like the following code in blk_mq_clear_rq_mapping() instead
> > > of the code in v5 of patch 3/4?
> > > 
> > > 	spin_lock_irqsave(&drv_tags->lock, flags);
> > > 	spin_unlock_irqrestore(&drv_tags->lock, flags);
> > > 
> > > 	list_for_each_entry(page, &tags->page_list, lru) {
> > > 		/* use cmpxchg() to clear request pointer selectively */
> > > 	}
> > 
> > This way won't work as expected because iterating may happen between
> > releasing drv_tags->lock and cmpxchg(->rqs[]), then freed requests
> > may still be touched during iteration after they are freed in blk_mq_free_rqs().
> 
> Right, the unlock should happen after the pointers have been cleared. But I
> think it is safe to move the spin_lock call down such that both the
> spin_lock and spin_unlock call happen after the pointers have been cleared.
> That is sufficient to guarantee that all blk_mq_find_and_get_req() calls
> either happen before or after the spin lock / unlock pair.
> blk_mq_find_and_get_req() calls that happen before the pair happen before
> the request pointers are freed. Calls that happen after the spin lock /
> unlock pair will either read NULL or a pointer to a request that is
> associated with another queue and hence won't trigger a use-after-free.

Putting the lock pair after clearing rq mapping should work, but not see
any benefit: not very readable, and memory barrier knowledge is required for
understanding its correctness(cmpxchg has to be completed before unlock), ...,
so is it better idea to move lock pair after clearing rq mapping?



Thanks,
Ming

