Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6D8C433DF
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 15:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFD3206C3
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 15:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591110638;
	bh=Pgmebh21MiHoPm58nXFPJEqeFSbhIvnL8TyWXJx2Gq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iOoxLZeNn8jldOpV8tSvMpA4Z5tIGAvqeUgqJL1qGxLLSg/9UtBMry1t1UKprLCsj
	 /Uu88MEf3XWIxGLzGw6N9QOpATNd6RaTK+7FZCJUWQugt09CwlwRHy44JKhYRtOEkC
	 O+qT+iblz64ZwoawqIzCecYvRMvelCxGpjDa18gg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgFBPKi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 11:10:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46609 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBPKi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jun 2020 11:10:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id n2so1438348pld.13
        for <linux-block@vger.kernel.org>; Tue, 02 Jun 2020 08:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pwv2Ql0InxKCmqySkl1LrmXVCQiGrBQdZLsznXTptg8=;
        b=rvVYCilSLA4uM7fcPD5Qw+K+5gKaQjF8r8g6+/8EwwdUTsKqLpcLvXhv9Seyd7i5Hw
         B2Z8KruBH3csC6A9OU/ReiYilp2BB0zig42WOh1CLDPzupjiC7grHjd2wOegoSOESiUK
         V3VTG2/NAEQ39n9nw9U/gLo234dgxLnnEUYv4cE5zLwdf5c+fBUATU5DpaofrN0zhqrb
         bHIuKctcZdaQPYDE52kLUpkZDv/qYDIZ1giTALX06aJYdQRSUv//ZxDMYv6+0vOO/v4N
         kIZfkJjD6YCSIf47xJTaIRMsshEzZUYklR2o8cA5r1FFhnPK3bNfGqwOskT3tle9EP+s
         xdVg==
X-Gm-Message-State: AOAM531wWdFxpHgSDJ8tzaFP1GsRypeoDZ8UXWih+ujtOSxJPQELp6Yv
        68NMaIYl6HtQFF4+tUwNGsY=
X-Google-Smtp-Source: ABdhPJxeZoYUTjt7xdk1YWtavIISIKvOUrvAe6/Jmsf1W5G7dOij0e4x6DRTt4GQEihwdakASnc5lQ==
X-Received: by 2002:a17:90a:7446:: with SMTP id o6mr1356903pjk.217.1591110636983;
        Tue, 02 Jun 2020 08:10:36 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a2sm2478889pgh.81.2020.06.02.08.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 08:10:34 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 6034040256; Tue,  2 Jun 2020 15:10:33 +0000 (UTC)
Date:   Tue, 2 Jun 2020 15:10:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, bvanassche@acm.org,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] blktrace: Avoid sparse warnings when assigning
 q->blk_trace
Message-ID: <20200602151033.GG13911@42.do-not-panic.com>
References: <20200602071205.22057-1-jack@suse.cz>
 <20200602141734.GL11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602141734.GL11244@42.do-not-panic.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 02, 2020 at 02:17:34PM +0000, Luis Chamberlain wrote:
> On Tue, Jun 02, 2020 at 09:12:05AM +0200, Jan Kara wrote:
> > Here is version of my patch rebased on top of Luis' blktrace fixes. Luis, if
> > the patch looks fine, can you perhaps include it in your series since it seems
> > you'll do another revision of your series due to discussion over patch 5/7?
> > Thanks!
> 
> Sure thing, will throw in the pile.

I've updated the commit log as follows as well, as I think its important
to annotate that the check for processing of the blktrace only makes
sense if it was not set. Let me know if this is fine. The commit log
is below.

From: Jan Kara <jack@suse.cz>
Date: Tue, 2 Jun 2020 09:12:05 +0200
Subject: [PATCH 1/8] blktrace: Avoid sparse warnings when assigning
 q->blk_trace

Mostly for historical reasons, q->blk_trace is assigned through xchg()
and cmpxchg() atomic operations. Although this is correct, sparse
complains about this because it violates rcu annotations since commit
c780e86dd48e ("blktrace: Protect q->blk_trace with RCU") which started
to use rcu for accessing q->blk_trace. Furthermore there's no real need
for atomic operations anymore since all changes to q->blk_trace happen
under q->blk_trace_mutex *and* since it also makes more sense to check
if q->blk_trace is set with the mutex held *earlier* and this is now
done through the patch titled "blktrace: break out on concurrent calls"
and was already before on blk_trace_setup_queue().

So let's just replace xchg() with rcu_replace_pointer() and cmpxchg()
with explicit check and rcu_assign_pointer(). This makes the code more
efficient and sparse happy.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
