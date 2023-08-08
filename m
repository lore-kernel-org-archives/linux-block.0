Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E37CC41513
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 17:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjHHRwX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjHHRvm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 13:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857D5B4F2B
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691511724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RcNvV0Qjz5yRjBCjldonHF9keAbdWFFrzIeJa3Xxa4c=;
        b=bcDPPWM2LEzHJ6vbrfyqjBjPFa9aVjr5jyM66Bj7R66C9NXvvIDsVHVRqMlYX+bRPOJcBM
        wmGm9k4zDW+Q/UCjfCwroXKYsDibJ49ehqVl8uyODfZdNJm0SeXcd46SaMgHw3scf/ukCX
        GtVVZ6+3zTShvdf/XcV3XakRBOhpCTQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-uimWGIJLPUuMD_DoV3yRvQ-1; Tue, 08 Aug 2023 04:19:01 -0400
X-MC-Unique: uimWGIJLPUuMD_DoV3yRvQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9051F1021E19;
        Tue,  8 Aug 2023 08:19:00 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DBFCE40D283F;
        Tue,  8 Aug 2023 08:18:55 +0000 (UTC)
Date:   Tue, 8 Aug 2023 16:18:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        David Jeffery <djeffery@redhat.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        ming.lei@redhat.com
Subject: Re: [RFC PATCH] sbitmap: fix batching wakeup
Message-ID: <ZNH6as/wUkbCMAcN@fedora>
References: <20230721095715.232728-1-ming.lei@redhat.com>
 <20230802160553.uv5wn6nfjseniyxx@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802160553.uv5wn6nfjseniyxx@quack3>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 02, 2023 at 06:05:53PM +0200, Jan Kara wrote:
> On Fri 21-07-23 17:57:15, Ming Lei wrote:
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
> > 
> > Cc: David Jeffery <djeffery@redhat.com>
> > Cc: Kemeng Shi <shikemeng@huaweicloud.com>
> > Cc: Gabriel Krisman Bertazi <krisman@suse.de>
> > Cc: Chengming Zhou <zhouchengming@bytedance.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> I'm sorry for the delay - I was on vacation. I can see the patch got
> already merged and I'm not strictly against that (although I think Gabriel
> was experimenting with this exact wakeup scheme and as far as I remember
> the more eager waking up was causing performance decrease for some
> configurations). But let me challenge the analysis above a bit. For the
> sleeper to be added to a waitqueue in step 3), blk_mq_mark_tag_wait() must
> fail the blk_mq_get_driver_tag() call. Which means that all tags were used

Here only allocating request by blk_mq_get_tag() is involved, and
getting driver tag isn't involved.

> at that moment. To summarize, anytime we add any new waiter to the
> waitqueue, all tags are used and thus we should eventually receive enough
> wakeups to wake all of them. What am I missing?

When running the final retry(__blk_mq_get_tag) before
sleeping(io_schedule()) in blk_mq_get_tag(), the sleeper has been added to
wait queue.

So when two completion batch comes, the two may wake up same wq because
same ->wake_index can be observed from two completion path, and both two
wake_up_nr() can return > 0 because adding sleeper into wq and wake_up_nr()
can be interleaved, then 16 completions just wakeup 2 sleepers added to
same wq.

If the story happens on one wq with >= 8 sleepers, io hang will be
triggered, if there are another two pending wq.


Thanks, 
Ming

