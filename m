Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4CFEB64DD
	for <linux-block@archiver.kernel.org>; Sat, 22 Jul 2023 02:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjGVCn3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 22:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGVCn2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 22:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C644112F
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 19:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689993761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XoAqQtUgiRccRqvkYTsuV7fDTMH3g1ndC77oGk3IOhs=;
        b=WCnpb3hHYLk7v/1p0YQgdp4uUOncbnt7bgHVhKfo9vJMEnFdKdNXSS7uScJ5R3JmsGQosG
        tvHLSeM5B9ruzRtunSideecU9l6LdUswToTn2wp9JHW5WK8XSdsLEHM7sKo9Txkrc906i8
        ry9EYxsaXQrvWLdMrAQP2VrdKQ/uyvM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-fNxjkRqKN0Wt1GoJxLZfhQ-1; Fri, 21 Jul 2023 22:42:37 -0400
X-MC-Unique: fNxjkRqKN0Wt1GoJxLZfhQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C60F101A528;
        Sat, 22 Jul 2023 02:42:37 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C92C61454142;
        Sat, 22 Jul 2023 02:42:31 +0000 (UTC)
Date:   Sat, 22 Jul 2023 10:42:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        David Jeffery <djeffery@redhat.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Jan Kara <jack@suse.cz>, ming.lei@redhat.com
Subject: Re: [RFC PATCH] sbitmap: fix batching wakeup
Message-ID: <ZLtCEjZtbgCDcwwt@ovpn-8-16.pek2.redhat.com>
References: <20230721095715.232728-1-ming.lei@redhat.com>
 <87jzut43z4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzut43z4.fsf@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 21, 2023 at 12:35:43PM -0400, Gabriel Krisman Bertazi wrote:
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > From: David Jeffery <djeffery@redhat.com>
> >
> > Current code supposes that it is enough to provide forward progress by just
> > waking up one wait queue after one completion batch is done.
> >
> > Unfortunately this way isn't enough, cause waiter can be added to
> > wait queue just after it is woken up.
> >
> > Follows one example(64 depth, wake_batch is 8)
> >
> > 1) all 64 tags are active
> >
> > 2) in each wait queue, there is only one single waiter
> >
> > 3) each time one completion batch(8 completions) wakes up just one waiter in each wait
> > queue, then immediately one new sleeper is added to this wait queue
> >
> > 4) after 64 completions, 8 waiters are wakeup, and there are still 8 waiters in each
> > wait queue
> >
> > 5) after another 8 active tags are completed, only one waiter can be wakeup, and the other 7
> > can't be waken up anymore.
> >
> > Turns out it isn't easy to fix this problem, so simply wakeup enough waiters for
> > single batch.
> 
> yes, I think this makes sense. When working on this algorithm I remember
> I considered it (thus wake_up_nr being ready), but ended up believing it
> wasn't needed.  please take:
> 
> Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
> 
> I wonder how likely it is to reach it.  Did you get a bug report?

It was reported from one RH customer, and I am also hit once
when running dbench on loop(bfq) over scsi_debug in my routine test.

David figured out the idea, and we discussed other solutions too, but
turns out others can't work, and the above (extreme)example seems easier
to follow, from me.

Per David's early analysis, it should be easier to trigger since commit
26edb30dd1c0 ("sbitmap: Try each queue to wake up at least one waiter")
because 'wake_index' isn't updated before calling wake_up_nr(), then
multiple completion batch may only wakeup one same wait queue, meantime
multiple sleepers are added to same wait queue.


Thanks, 
Ming

