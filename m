Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C002C433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 11:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55EA361166
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 11:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhKDLXH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 07:23:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40858 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhKDLXG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 07:23:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ECA001FD47;
        Thu,  4 Nov 2021 11:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636024827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PsoLA/FsZWXPrATFMbo87CUF0o1aOiWzMpB4gp0vyl0=;
        b=rE1KC143ckJ6LpHJUduF+99SEIpvYdeWZlxljDT7C0nsKWwtuTyEezJBXhMwiEHxX19xsQ
        qfH4CvMrh+gobtLrNYdC8V8JYy2McuTsaf7k9mrWyqknN59gu2gDufAN86frzFCNpEb/go
        zdWS2khygBEJwDd9qlQXwpGR40CpScM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636024827;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PsoLA/FsZWXPrATFMbo87CUF0o1aOiWzMpB4gp0vyl0=;
        b=Spd16/kDuh5Hm+306tDYYNvzVBYvHmbJx0ZcVVVuQgebclmaxY3ZEHXohrhp5BBzwJc2oo
        ZKTS+eXje7VuQKDw==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id DBE4A2C150;
        Thu,  4 Nov 2021 11:20:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AEBA01E1265; Thu,  4 Nov 2021 12:20:27 +0100 (CET)
Date:   Thu, 4 Nov 2021 12:20:27 +0100
From:   Jan Kara <jack@suse.cz>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Jan Kara <jack@suse.cz>, Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 4/8] bfq: Limit number of requests consumed by each cgroup
Message-ID: <20211104112027.GC10060@quack2.suse.cz>
References: <20211006164110.10817-1-jack@suse.cz>
 <20211006173157.6906-4-jack@suse.cz>
 <20211102181658.GA63407@blackbody.suse.cz>
 <20211103130314.GC20482@quack2.suse.cz>
 <20211103181211.GA10322@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211103181211.GA10322@blackbody.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 03-11-21 19:12:12, Michal Koutný wrote:
> On Wed, Nov 03, 2021 at 02:03:14PM +0100, Jan Kara <jack@suse.cz> wrote:
> > Since we stop the loop at bfq_class_idx(entity)
> 
> Aha! I overlooked the for loop ends with the entity's class here and not
> after the full range of classes.
> 
> > I.e., we scale available tags proportionally to bfq_queue weight (which
> > scales linearly with IO priority).
> 
> Yes, you're working within the "order" of the entity's class and it's
> always the last, i.e. least too, so the scale is 1.
> 
> > So in principle it can happen that there would be no tag left for a
> > process in lower IO priority class - and that is fine, we don't care,
> > because we don't want to submit IO from lower IO priority class while
> > there is still IO in higher IO priority class.
> 
> Actually, can it ever happen that the higher class leaves some tags for
> the lower? (IOW, is the CLS_wsum anytime exceeding sum of all active
> entities of the CLS at the given point in time?) (1)

Yes, that can happen. Here we compute just an upper bound on the number of
tags. Each entity can use less than this upper limit and thus there will be
tags left for entities in lower IO priority classes.

> > Now consider a situation for a process in BE IO priority class in this
> > setting. All processes in BE class can together occupy at most BE_wsum /
> > (RT_wsum * IOPRIO_BE_NR + BE_wsum) fraction of tags. This is admittedly
> > somewhat arbitrary fraction but it makes sure for each process in RT class
> > there are at least as many tags left as for the highest priority process in
> > BE class.
> 
> Can it happen that bfqq_request_over_limit() is called for a BE entity
> before calling it for an RT entity (more precisely, not the
> bfqq_request_over_limit() calls but actual allocation of tags)? (2)

Sure, that can happen. bfqq_request_over_limit() gets called (as well as
scheduler tag allocation happens) at the moment process calls submit_bio().
Time when each process calls submit_bio() is completely out of our control.
It can even happen that BE process submits lots of IO, we let it allocate
lots of tags (because there isn't any other process in the service trees)
and then RT process submits its first IO - only at this moment tag limit
for BE process is reduced so BE process will block when trying to allocate
any further tag until it frees enough tags by completing IO. This is
actually the reason why we always allow a process to allocate at least some
tags so that it can enter service tree, then it can gradually allocate more
and more tags (because its tag allocation is not limited unlike the tag
allocation for BE process) until it uses appropriate share of tags.

> > As I wrote above, the highest active IO priority class effectively allows
> > processes in this class to consume all tags available for a cgroup. If
> > there are lower IO priority classes active as well, we allow them to
> > consume some tags but never allow them to consume all of them...
> 
> I assume this implies the answer to my previous question (2) is "yes"
> and to the question (1) is: "numerically no, but lower class entity can
> take some tags if it gets to draw them earlier".

Exactly.

> > Yes, this is kind of an extension of bfq_io_prio_to_weight() that allows
> > some comparison of queues from different IO priority classes.
> 
> I see there's no point using the same values for the weights in the
> bfqq_request_over_limit() calculations as bfq_ioprio_to_weight()
> calculates given the nature of strict ordering of classes above each
> other. Your scoring makes sense to me now.
> 
> Reviewed-by: Michal Koutný <mkoutny@suse.com>

Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
