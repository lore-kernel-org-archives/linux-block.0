Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C889C433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 11:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C701761261
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 11:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbhDLLnF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:43:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238780AbhDLLnF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 07:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618227767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pMMp26rKj9eBld3YiaOUWA6vyF3G7c8bUAq3SL0JPkM=;
        b=YfIX7PSOGMPethcUyUondEo2aRJU1Bca6RQTOhnywFZ6xRoHhiLEq2vH59ZJT7KxtDAtfB
        HSFDBN6hz/bV9pYoZH6i1PxVDpNPuz1lQ2oFpr/SLYFRZ9/eFr7znbmxQumZRaMhznx5Nf
        TE2Ku50oIxDouqJCouQEKbrsHm8csGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-QUslvevQMg6bK3g3Dqf66A-1; Mon, 12 Apr 2021 07:42:43 -0400
X-MC-Unique: QUslvevQMg6bK3g3Dqf66A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51A8D1020C21;
        Mon, 12 Apr 2021 11:42:42 +0000 (UTC)
Received: from T590 (ovpn-12-111.pek2.redhat.com [10.72.12.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43FF6100AE4E;
        Mon, 12 Apr 2021 11:42:20 +0000 (UTC)
Date:   Mon, 12 Apr 2021 19:42:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 08/12] block: use per-task poll context to implement
 bio based io polling
Message-ID: <YHQyGVQb48g5rYsJ@T590>
References: <20210401021927.343727-1-ming.lei@redhat.com>
 <20210401021927.343727-9-ming.lei@redhat.com>
 <20210412095427.GA987123@infradead.org>
 <YHQfB83n8dQSwD3O@T590>
 <20210412102947.GA998763@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412102947.GA998763@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 12, 2021 at 11:29:47AM +0100, Christoph Hellwig wrote:
> On Mon, Apr 12, 2021 at 06:20:55PM +0800, Ming Lei wrote:
> > > > +static inline void *bio_grp_data(struct bio *bio)
> > > > +{
> > > > +	return bio->bi_poll;
> > > > +}
> > > 
> > > What is the purpose of this helper?  And why does it have to lose the
> > > type information?
> > 
> > This patch stores bio->bi_end_io(shared with ->bi_poll) into one per-task
> > data structure, and links all bios sharing same .bi_end_io into one list
> > via ->bi_end_io. And their ->bi_end_io is recovered before calling
> > bio_endio().
> > 
> > The helper is used for checking if one bio can be added to bio group,
> > and storing the data. The helper just serves for document purpose.
> > 
> > And the type info doesn't matter.
> 
> So why is bi_poll typed to start with then just to need a accessor
> to remove the typer information?

It should be a bug from the beginning, either .bi_poll can be dropped
or it should be 'void *'. Just find it, thanks for pointing it out.


Thanks,
Ming

