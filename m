Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53280C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196BE20870
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544716040;
	bh=uyTqY7ieijazWOMuOQ32ThMiRTihpmC1vUZ4/3kwTPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OGlvL+0aDdEeU/JBy6a4GicBwORa3mCnyOXa724/pOmWbEUuLAfgQBx3EKny8Ejwz
	 +wyLzzraEmhVe/LGa6M7KREqIvDr9cPlttEwwdr1TO19IexqSaq5UJHjMonjo6/0po
	 hYB7gI6xf02ec+qoSmjz60/xGuV9QZ+9A+jOhJb0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196BE20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeLMPrT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:47:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37994 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeLMPrT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 10:47:19 -0500
Received: by mail-qk1-f196.google.com with SMTP id a1so1322461qkc.5;
        Thu, 13 Dec 2018 07:47:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HvY3Xbu3sqpn2hBpXa+Yc47YOoO1K16g2qWpj3u3juM=;
        b=omXSAnUOr7eWbIGf2aI8LdTl21N6IVzw1zOmtEYi329ZVznFkRF1cMIGIG+6+0eZX7
         yFcHEGqqeHGPth5i2+1gRIVQlLGRkzxl/SibKqAaJ5/ZWIwI9eUt97LXZdXY4ciH0hfL
         pMBRu5JYC7hPYC5dWKloQLwzXG8vvtAEQlLqgB+jnx5c+3dX4u/iW1ppEfqGKPaW3rBA
         AAKXv45PLFanutpgKQNuXy0kgDvefBd+GbZw7VjDiSrWO3l6IfiXeyF2s7m/25BEeCnK
         GvErbwjckiGLK3dTmRvSJNWzCiPJTPhJM0tuWZ0qBuj7P/8euVtY/bCVa+z7vP064jRe
         Deaw==
X-Gm-Message-State: AA+aEWYup3kelNVlkdsO9wnh6+XV2dAJSi+Dqe2P0b1OtoPvRMla4DVZ
        r3DDUaJmzvzpUR7gOgCs/jg=
X-Google-Smtp-Source: AFSGD/W9TPb5W7WKC0xiBuHMd/HhHaDmtgsOnbrcrSvT7JFWbq4lqKE8f4Hd2BOn5PYUKV2BZ9RNRA==
X-Received: by 2002:a37:ba06:: with SMTP id k6mr22580676qkf.115.1544716036609;
        Thu, 13 Dec 2018 07:47:16 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::7:b1cc])
        by smtp.gmail.com with ESMTPSA id s46sm1369866qtc.63.2018.12.13.07.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 07:47:15 -0800 (PST)
Date:   Thu, 13 Dec 2018 10:47:13 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] blkcg: handle dying request_queue when associating a blkg
Message-ID: <20181213154713.GA76721@dennisz-mbp.dhcp.thefacebook.com>
References: <20181211230308.66276-1-dennis@kernel.org>
 <1544570173.185366.397.camel@acm.org>
 <20181212040643.GA73727@dennisz-mbp.dhcp.thefacebook.com>
 <1544658892.185366.412.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544658892.185366.412.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 12, 2018 at 03:54:52PM -0800, Bart Van Assche wrote:
> On Tue, 2018-12-11 at 23:06 -0500, Dennis Zhou wrote:
> > Hi Bart,
> > 
> > On Tue, Dec 11, 2018 at 03:16:13PM -0800, Bart Van Assche wrote:
> > > On Tue, 2018-12-11 at 18:03 -0500, Dennis Zhou wrote:
> > > > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > > > index 6bd0619a7d6e..c30661ddc873 100644
> > > > --- a/block/blk-cgroup.c
> > > > +++ b/block/blk-cgroup.c
> > > > @@ -202,6 +202,12 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
> > > >  	WARN_ON_ONCE(!rcu_read_lock_held());
> > > >  	lockdep_assert_held(&q->queue_lock);
> > > >  
> > > > +	/* request_queue is dying, do not create/recreate a blkg */
> > > > +	if (blk_queue_dying(q)) {
> > > > +		ret = -ENODEV;
> > > > +		goto err_free_blkg;
> > > > +	}
> > > > +
> > > >  	/* blkg holds a reference to blkcg */
> > > >  	if (!css_tryget_online(&blkcg->css)) {
> > > >  		ret = -ENODEV;
> > > 
> > > What prevents that the queue state changes after blk_queue_dying() has returned
> > > and before blkg_create() returns? Are you sure you don't need to protect this
> > > code with a blk_queue_enter() / blk_queue_exit() pair?
> > > 
> > 
> > Hmmm. So I think the idea is that we rely on normal shutdown as I don't
> > think there is anything wrong with creating a blkg on a dying
> > request_queue. When we are doing association, the request_queue should
> > be pinned by the open call. What we are racing against is when the
> > request_queue is shutting down, it goes around and destroys the blkgs.
> > For clarity, QUEUE_FLAG_DYING is set in blk_cleanup_queue() before
> > calling blk_exit_queue() which eventually calls blkcg_exit_queue().
> > 
> > The use of blk_queue_dying() is to determine whether blkg shutdown has
> > already started as if we create one after it has started, we may
> > incorrectly orphan a blkg and leak it. Both blkg creation and
> > destruction require holding the queue_lock, so if the QUEUE_FLAG_DYING
> > flag is set after we've checked it, it means blkg destruction hasn't
> > started because it has to wait on the queue_lock. If QUEUE_FLAG_DYING is
> > set, then we have no guarantee of knowing what phase blkg destruction is
> > in leading to a potential leak.
> 
> Hi Dennis,
> 
> To answer my own question: since all queue flag manipulations are protected
> by the queue lock and since blkg_create() is called with the queue lock held
> the above code does not need any further protection. Hence feel free to add
> the following:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> 

It seems that Christoph in 57d74df90783 ("block: use atomic bitops for
->queue_flags") changed it so that flag manipulations no longer are
protected by the queue_lock in for-4.21/block. But I think my
explanation above suffices that we will always be able to clean up a
blkg created as long as the QUEUE_FLAG_DYING is not set.

Thanks for reviewing this!
Dennis
