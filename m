Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA339C3A59B
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 08:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74902085A
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 08:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfHSIPv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 04:15:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHSIPu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 04:15:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9246A8E24F;
        Mon, 19 Aug 2019 08:15:50 +0000 (UTC)
Received: from ming.t460p (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 109CA80498;
        Mon, 19 Aug 2019 08:15:42 +0000 (UTC)
Date:   Mon, 19 Aug 2019 16:15:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH] block: don't acquire .sysfs_lock before removing mq &
 iosched kobjects
Message-ID: <20190819081536.GA9852@ming.t460p>
References: <20190816135506.29253-1-ming.lei@redhat.com>
 <429c8ae2-894a-1eb2-83d3-95703d1573cf@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429c8ae2-894a-1eb2-83d3-95703d1573cf@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 19 Aug 2019 08:15:50 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 16, 2019 at 08:14:13AM -0700, Bart Van Assche wrote:
> On 8/16/19 6:55 AM, Ming Lei wrote:
> > The kernfs built-in lock of 'kn->count' is held in sysfs .show/.store
> > path. Meantime, inside block's .show/.store callback, q->sysfs_lock is
> > required.
> > 
> > However, when mq & iosched kobjects are removed via
> > blk_mq_unregister_dev() & elv_unregister_queue(), q->sysfs_lock is held
> > too. This way causes AB-BA lock because the kernfs built-in lock of
> > 'kn-count' is required inside kobject_del() too, see the lockdep warning[1].
> > 
> > On the other hand, it isn't necessary to acquire q->sysfs_lock for
> > both blk_mq_unregister_dev() & elv_unregister_queue() because
> > clearing REGISTERED flag prevents storing to 'queue/scheduler'
> > from being happened. Also sysfs write(store) is exclusive, so no
> > necessary to hold the lock for elv_unregister_queue() when it is
> > called in switching elevator path.
> > 
> > Fixes the issue by not holding the q->sysfs_lock for blk_mq_unregister_dev() &
> > elv_unregister_queue().
> 
> Have you considered to split sysfs_lock into multiple mutexes? Today it is

So far, not consider it. At least now, I just don't see the need to hold
sysfs_lock for both blk_mq_unregister_dev() & elv_unregister_queue().
Then we can fix the deadlock issue which can be triggered quite easily,
and the fix should be for -stable.

Yeah, I agree that sysfs_lock has been used too widely.

> very hard to verify the correctness of block layer code that uses sysfs_lock
> because it has not been documented anywhere what that mutex protects. I
> think that mutex should be split into at least two mutexes: one that
> protects switching I/O schedulers and another one that protects hctx->tags
> and hctx->sched_tags.

sysfs_lock is required in any .show & .store callback, and switching I/O
scheduler is done in .store(), then hctx->sched_tags is protected by sysfs_lock
too.

hctx->tags is tagset wide or host-wide, which is protected by set->tag_list_lock.


Thanks,
Ming
