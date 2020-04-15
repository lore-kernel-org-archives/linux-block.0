Return-Path: <SRS0=HXqG=57=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE64C2BB55
	for <linux-block@archiver.kernel.org>; Wed, 15 Apr 2020 13:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCCDF2074F
	for <linux-block@archiver.kernel.org>; Wed, 15 Apr 2020 13:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586956782;
	bh=LK5i17oKr75c/wlaNjsw+7HclaPdIRvTO6fWkrLjOec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vgomqV6D/xchoeO4dhIG/+piVi7h70w4Fj55+e4UZ7O+CToDiMNUaLQafE0lzDOA+
	 6IeL6Krby7X/Pe6wSiDq1uT37h0Mh1nR9sZHhOysATR1MrJhFXqUYK1CMbOhNIPJG3
	 h4zRZggNuSamVL4ZISfjbLtbfwG9ArYEuZQV7HtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506280AbgDONTk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:19:40 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38448 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505331AbgDONTT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Apr 2020 09:19:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id w3so1240441plz.5;
        Wed, 15 Apr 2020 06:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7IvG2bEA5VCaC2qgBtVR/FZ0IDKm4MJccJ5LrCzVHtM=;
        b=bJfSjuAWcr0o2SqPwRDSD4f/zznNmACFO7AMUI288bLG8n9CXbJX08ZTNHFh23VG2O
         20yQgmkDfy5gDldJ5n2S+q0nIgZAmKR4zgaASFNJLhTtlIjFqMg9Vy4MJIfOe04AAfEm
         MH8TMR7ck4zX/EnQAkx3MIP8kn2Ttj8Uxmg4f14we34pVFB1cUzH3r91f/wHQtNKVjNU
         tmIweebitxfeQLTlZ3ruZSBrNByGTrr5/vSP/q7Q2t4/z/10VKTF7/K/XS68x+u9iplE
         Gr9rbTw6MB/GThAFPvNTazNyWpcZ+c4ndDs/y+MLrs9lrryAAY5ZsnPCrIoAbVnwgYv2
         Ro1g==
X-Gm-Message-State: AGi0Pub9OgKPwbfjASurdBU86f0xTagjdIbL1gdmMAPMt6YI/oOf10DR
        /tvk8jp7Bb1ANkGD7Dt64Mk=
X-Google-Smtp-Source: APiQypKt0dyTdKtn4rGriYEeFWzmB80X5z3lTmEXBrfOHZD1nC8rYnZFAuTFIJUuQI3bysuLAnuDnA==
X-Received: by 2002:a17:902:8485:: with SMTP id c5mr5057637plo.242.1586956757999;
        Wed, 15 Apr 2020 06:19:17 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id n9sm3466685pjt.29.2020.04.15.06.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 06:19:16 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id CFE5D40277; Wed, 15 Apr 2020 13:19:15 +0000 (UTC)
Date:   Wed, 15 Apr 2020 13:19:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alan Jenkins <alan.christopher.jenkins@gmail.com>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 4/5] mm/swapfile: refcount block and queue before using
 blkcg_schedule_throttle()
Message-ID: <20200415131915.GV11244@42.do-not-panic.com>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-5-mcgrof@kernel.org>
 <20200414154447.GC25765@infradead.org>
 <20200415054234.GQ11244@42.do-not-panic.com>
 <20200415072712.GB21099@infradead.org>
 <20200415073443.GA21036@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415073443.GA21036@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 15, 2020 at 12:34:43AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 15, 2020 at 12:27:12AM -0700, Christoph Hellwig wrote:
> > On Wed, Apr 15, 2020 at 05:42:34AM +0000, Luis Chamberlain wrote:
> > > > I don't understand the atomic part of the comment.  How does
> > > > bdgrab/bdput help us there?
> > > 
> > > The commit log above did a better job at explaining this in terms of our
> > > goal to use the request_queue and how this use would prevent the risk of
> > > releasing the request_queue, which could sleep.
> > 
> > So bdput eventually does and iput, but what leads to an out of context
> > offload?
> > 
> > But anyway, isn't the original problem better solved by simply not
> > releasing the queue from atomic context to start with?  There isn't
> > really any good reason we keep holding the spinlock once we have a
> > reference on the queue, so something like this (not even compile tested)
> > should do the work:
> 
> Actually - mem_cgroup_throttle_swaprate already checks for a non-NULL
> current->throttle_queue above, so we should never even call
> blk_put_queue here.  Was this found by code inspection, or was there
> a real report?

No but report, this code path came up as a possible use of
blk_put_queue() which already exists in atomic context. So yes, it
already uses blk_put_queue(), but how are we *sure* its not going to be
the last one? Because if it is that mean the release will happen in
atomic context, defeating the goal of the last patch in this series.

Using bdgrab() however ensures that during the lifecycle of this path,
blk_put_queue() won't be the last if used after, but instead we are
sure it will be upon disk release.

In fact, with bdgrab() isn't the blk_get_queue() on
blkcg_schedule_throttle() no longer needed?

> In the latter case we need to figure out what protects >throttle_queue,
> as the way blkcg_schedule_throttle first put the reference and only then
> assign a value to it already looks like it introduces a tiny race
> window.
> 
> Otherwise just open coding the applicable part of blkcg_schedule_throttle
> in mem_cgroup_throttle_swaprate seems easiest:
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 5871a2aa86a5..e16051ef074c 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3761,15 +3761,20 @@ void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
>  	 */
>  	if (current->throttle_queue)
>  		return;
> +	if (unlikely(current->flags & PF_KTHREAD))
> +		return;
>  
>  	spin_lock(&swap_avail_lock);
>  	plist_for_each_entry_safe(si, next, &swap_avail_heads[node],
>  				  avail_lists[node]) {
> -		if (si->bdev) {
> -			blkcg_schedule_throttle(bdev_get_queue(si->bdev),
> -						true);
> -			break;
> +		if (!si->bdev)
> +			continue;
> +		if (blk_get_queue(dev_get_queue(si->bdev))) {
> +			current->throttle_queue = dev_get_queue(si->bdev);
> +			current->use_memdelay = true;
> +			set_notify_resume(current);
>  		}
> +		break;
>  	}
>  	spin_unlock(&swap_avail_lock);
>  }

Sorry, its not clear to me  who calls the respective blk_put_queue()
here?

  Luis
