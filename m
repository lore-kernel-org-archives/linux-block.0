Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A40AC433FE
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 01:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0697E23B54
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 01:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgLIBCr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 20:02:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbgLIBCr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Dec 2020 20:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607475679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pHSLKEYPkZSLVPn0PMFtupg/ADvjQnsxqHg4D8q8Ep8=;
        b=hvO8WibYxxrA4z7p0Ff6/jgYGZe7UIZVnJh3jVQU+uLx9aVZ4y4FxiYlrbWNOHYjubygKd
        XQfmPSTRFUa+An0qnIDwJuUkiXEt2F261dF5VbCQ9/K8dRtvUErU7qgJABoNsw8ek228+p
        RnM8hKkNK4RjrDZSp6r2Pk1MJsmRatI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-wGboA2NIPAypn2AgzECzhQ-1; Tue, 08 Dec 2020 20:01:17 -0500
X-MC-Unique: wGboA2NIPAypn2AgzECzhQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AAC8800D55;
        Wed,  9 Dec 2020 01:01:15 +0000 (UTC)
Received: from T590 (ovpn-12-139.pek2.redhat.com [10.72.12.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 490BC19C78;
        Wed,  9 Dec 2020 01:01:06 +0000 (UTC)
Date:   Wed, 9 Dec 2020 09:01:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, hare@suse.de,
        ppvk@codeaurora.org, bvanassche@acm.org, kashyap.desai@broadcom.com
Subject: Re: [RFC PATCH] blk-mq: Clean up references when freeing rqs
Message-ID: <20201209010102.GA1217988@T590>
References: <1606827738-238646-1-git-send-email-john.garry@huawei.com>
 <20201202033134.GD494805@T590>
 <aaf77015-3039-6b04-3417-d376e3467444@huawei.com>
 <20201203005505.GB540033@T590>
 <fa222311-2184-0041-61ab-b3d70fb92585@huawei.com>
 <7beb86a2-5c4b-bdc0-9fce-1b583548c6d0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7beb86a2-5c4b-bdc0-9fce-1b583548c6d0@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 08, 2020 at 11:36:58AM +0000, John Garry wrote:
> On 03/12/2020 09:26, John Garry wrote:
> > On 03/12/2020 00:55, Ming Lei wrote:
> > 
> > Hi Ming,
> > 
> > > > Yeah, so I said that was another problem which you mentioned
> > > > there, which
> > > > I'm not addressing, but I don't think that I'm making thing worse here.
> > > The thing is that this patch does not fix the issue completely.
> > > 
> > > > So AFAICS, the blk-mq/sched code doesn't wait for any "readers" to be
> > > > finished, such as those running blk_mq_queue_tag_busy_iter or
> > > > blk_mq_tagset_busy_iter() in another context.
> > > > 
> > > > So how about the idea of introducing some synchronization
> > > > primitive, such as
> > > > semaphore, which those "readers" must grab and release at start
> > > > and end (of
> > > > iter), to ensure the requests are not freed during the iteration?
> > > It looks good, however devil is in details, please make into patch for
> > > review.
> > 
> > OK, but another thing to say is that I need to find a somewhat reliable
> > reproducer for the potential problem you mention. So far this patch
> > solves the issue I see (in that kasan stops warning). Let me analyze
> > this a bit further.
> > 
> 
> Hi Ming,
> 
> I am just looking at this again, and have some doubt on your concern [0].
> 
> From checking blk_mq_queue_tag_busy_iter() specifically, don't we actually
> guard against this with the q->q_usage_counter mechanism? That is, an agent
> needs to grab a q counter ref when attempting the iter. This will fail when
> the queue IO sched is being changed, as we freeze the queue during this
> time, which is when the requests are freed, so no agent can hold a reference
> to a freed request then. And same goes for blk_mq_update_nr_requests(),
> where we freeze the queue.

blk_mq_queue_tag_busy_iter() can be run on another request queue just
between one driver tag is allocated and updating the request map, so one
extra request reference still can be grabbed.

So looks only holding one queue's usage_counter doesn't help this issue, since
bt_for_each() always iterates on driver tags wide.

> 
> But I didn't see such a guard for blk_mq_tagset_busy_iter().

IMO there isn't real difference between the two iteration.


Thanks, 
Ming

