Return-Path: <SRS0=QBb8=4U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E13C3F2CD
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 13:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFD120848
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 13:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgCCNf1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:35:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbgCCNf1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Mar 2020 08:35:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 149D920838;
        Tue,  3 Mar 2020 13:35:26 +0000 (UTC)
Date:   Tue, 3 Mar 2020 08:35:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Bob Liu <bob.liu@oracle.com>
Cc:     Cengiz Can <cengiz@kernel.wtf>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blktrace: fix dereference after null check
Message-ID: <20200303083523.78233c24@gandalf.local.home>
In-Reply-To: <ec24c6d8-617f-1460-0420-bc2ac3f346c6@oracle.com>
References: <20200303073358.57799-1-cengiz@kernel.wtf>
        <ec24c6d8-617f-1460-0420-bc2ac3f346c6@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 3 Mar 2020 21:29:08 +0800
Bob Liu <bob.liu@oracle.com> wrote:

> On 3/3/20 3:33 PM, Cengiz Can wrote:
> > There was a recent change in blktrace.c that added a RCU protection to
> > `q->blk_trace` in order to fix a use-after-free issue during access.
> > 
> > However the change missed an edge case that can lead to dereferencing of
> > `bt` pointer even when it's NULL:
> > 
> > ```
> >         bt->act_mask = value; // bt can still be NULL here
> > ```
> > 
> > Added a reassignment into the NULL check block to fix the issue.
> > 
> > Fixes: c780e86dd48 ("blktrace: Protect q->blk_trace with RCU")
> > 
> > Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
> > ---
> >  Huge thanks goes to Steven Rostedt for his assistance.
> > 
> >  kernel/trace/blktrace.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> > index 4560878f0bac..29ea88f10b87 100644
> > --- a/kernel/trace/blktrace.c
> > +++ b/kernel/trace/blktrace.c
> > @@ -1896,8 +1896,10 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
> >  	}
> > 
> >  	ret = 0;
> > -	if (bt == NULL)
> > +	if (bt == NULL) {
> >  		ret = blk_trace_setup_queue(q, bdev);
> > +		bt = q->blk_trace;  
> 
> The return value 'ret' should be judged, it's wrong to set 'bt' if blk_trace_setup_queue()
> return failure.

Why? If ret is an error, q is still valid, and bt would just be garbage. bt
is ignored below if ret is anything but zero. Why add an unnecessary if
condition here?

That said, the bt assignment still needs rcu annotation:

		bt = rcu_dereference_protected(q->blk_trace,
				lockdep_is_held(&q->blk_trace_mutex));

-- Steve


> 
> > +	}
> > 
> >  	if (ret == 0) {
> >  		if (attr == &dev_attr_act_mask)
> > --
> > 2.25.1
> >   

