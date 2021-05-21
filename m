Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D356C433ED
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 06:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CDA0613BE
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 06:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhEUG4a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 02:56:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234478AbhEUGzu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 02:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621580065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y0XnIZuv4nz0Xl0hIaU66At3giXiH88te3DduZy1Gw4=;
        b=GR0F5dSLsl7vht/SzItHvEhYvRHM+8lfDCwbzIF5gctv6NZns+/+n5vvzzJVNTYFR+SNII
        BRgqd0MWPAXORC8ugTGHnWFF5UKlaoHjXQ0H8yzG+/rbJeQ3DfKt6ucw/oNyEz9tYrSRmS
        H22eH6ZNoqHTsaZell9hd92mNvmBNek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-Flm1TZx-M5mSqRDVN3pmag-1; Fri, 21 May 2021 02:54:23 -0400
X-MC-Unique: Flm1TZx-M5mSqRDVN3pmag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 338C810074CD;
        Fri, 21 May 2021 06:54:22 +0000 (UTC)
Received: from T590 (ovpn-13-156.pek2.redhat.com [10.72.13.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1328362463;
        Fri, 21 May 2021 06:54:13 +0000 (UTC)
Date:   Fri, 21 May 2021 14:54:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Khazhy Kumykov <khazhy@google.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH 2/2] blk: Fix lock inversion between ioc lock and bfqd
 lock
Message-ID: <YKdZEanY3WtXGjAc@T590>
References: <20210520223353.11561-1-jack@suse.cz>
 <20210520223353.11561-3-jack@suse.cz>
 <YKcFZMJiFnsktsBu@T590>
 <CACGdZYKk01Ef7aVjdU9bmL+6Qo99Dc_HqKKiEECGJSsRmADtHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGdZYKk01Ef7aVjdU9bmL+6Qo99Dc_HqKKiEECGJSsRmADtHQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 20, 2021 at 08:29:49PM -0700, Khazhy Kumykov wrote:
> On Thu, May 20, 2021 at 5:57 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Fri, May 21, 2021 at 12:33:53AM +0200, Jan Kara wrote:
> > > Lockdep complains about lock inversion between ioc->lock and bfqd->lock:
> > >
> > > bfqd -> ioc:
> > >  put_io_context+0x33/0x90 -> ioc->lock grabbed
> > >  blk_mq_free_request+0x51/0x140
> > >  blk_put_request+0xe/0x10
> > >  blk_attempt_req_merge+0x1d/0x30
> > >  elv_attempt_insert_merge+0x56/0xa0
> > >  blk_mq_sched_try_insert_merge+0x4b/0x60
> > >  bfq_insert_requests+0x9e/0x18c0 -> bfqd->lock grabbed
> >
> > We could move blk_put_request() into scheduler code, then the lock
> > inversion is avoided. So far only mq-deadline and bfq calls into
> > blk_mq_sched_try_insert_merge(), and this change should be small.
> 
> We'd potentially be putting multiple requests if we keep the recursive merge.

Oh, we still can pass a list to hold all requests to be freed, then free
them all outside in scheduler code.


Thanks, 
Ming

