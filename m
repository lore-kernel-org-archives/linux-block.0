Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA92AC7EE24
	for <linux-block@archiver.kernel.org>; Tue,  6 Jun 2023 03:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjFFDu3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jun 2023 23:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjFFDu2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2023 23:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6A510F
        for <linux-block@vger.kernel.org>; Mon,  5 Jun 2023 20:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686023382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hSOOdxHtG5JNYtrYEawXhmXi7iZRU3vUw/vcz97F7Yk=;
        b=dhrYWdjkaM6fMv8XrEQ1wcX2+kTTqRQ1yJ8uI7C83qLRqxfBpH/Q/JdaZJ8JGk3C9rk94F
        gawRQM/z/MzQAumm+xqHhG0Vka9+gd8nM//NLnFDFFv0ThXmf36VVWkOBPiTQaVS9g4VCK
        SCnSVAtl+z8S+lAMmGprQajBQBYJHAU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-ge9Rnm9qPamtMCdLHIoeYg-1; Mon, 05 Jun 2023 23:49:37 -0400
X-MC-Unique: ge9Rnm9qPamtMCdLHIoeYg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B5F71C03388;
        Tue,  6 Jun 2023 03:49:36 +0000 (UTC)
Received: from ovpn-8-17.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DB191121314;
        Tue,  6 Jun 2023 03:49:18 +0000 (UTC)
Date:   Tue, 6 Jun 2023 11:49:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, stable@vger.kernel.org,
        Jay Shin <jaeshin@redhat.com>,
        Waiman Long <longman@redhat.com>, mkoutny@suse.com,
        Yosry Ahmed <yosryahmed@google.com>, ming.lei@redhat.com
Subject: Re: [PATCH V3] blk-cgroup: Flush stats before releasing blkcg_gq
Message-ID: <ZH6suXYDNbIZjQyp@ovpn-8-17.pek2.redhat.com>
References: <20230525043518.831721-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525043518.831721-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 25, 2023 at 12:35:18PM +0800, Ming Lei wrote:
> As noted by Michal, the blkg_iostat_set's in the lockless list hold
> reference to blkg's to protect against their removal. Those blkg's
> hold reference to blkcg. When a cgroup is being destroyed,
> cgroup_rstat_flush() is only called at css_release_work_fn() which
> is called when the blkcg reference count reaches 0. This circular
> dependency will prevent blkcg and some blkgs from being freed after
> they are made offline.
> 
> It is less a problem if the cgroup to be destroyed also has other
> controllers like memory that will call cgroup_rstat_flush() which will
> clean up the reference count. If block is the only controller that uses
> rstat, these offline blkcg and blkgs may never be freed leaking more
> and more memory over time.
> 
> To prevent this potential memory leak:
> 
> - flush blkcg per-cpu stats list in __blkg_release(), when no new stat
> can be added
> 
> - add global blkg_stat_lock for covering concurrent parent blkg stat
> update
> 
> - don't grab bio->bi_blkg reference when adding the stats into blkcg's
> per-cpu stat list since all stats are guaranteed to be consumed before
> releasing blkg instance, and grabbing blkg reference for stats was the
> most fragile part of original patch
> 
> Based on Waiman's patch:
> 
> https://lore.kernel.org/linux-block/20221215033132.230023-3-longman@redhat.com/
> 
> Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> Cc: stable@vger.kernel.org
> Reported-by: Jay Shin <jaeshin@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: mkoutny@suse.com
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V3:
> 	- add one global blkg_stat_lock for avoiding concurrent update on
> 	blkg stat; this way is easier for backport, also won't cause contention;

Hello Jens and Tejun,

Can we move on with this patch or Waiman's version[1]?

I am fine with either one.

[1] https://lore.kernel.org/linux-block/20230525160105.1968749-1-longman@redhat.com/

Thanks, 
Ming

