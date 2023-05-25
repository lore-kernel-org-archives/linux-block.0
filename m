Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E121C7EE29
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 15:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbjEYPeX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 11:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241738AbjEYPeV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 11:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817B599
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 08:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685028819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJxkct/CFcXSKfC56+wbDQMWjXSTzFVq1O6PxZv8Z7Y=;
        b=PFIOzVHtWE0aUVRnWO95YgAqPmxu9dPhEw/zefPjM4yaMgl2ry8e4tk45goLIfZlChyTSU
        vKHgfA2SRZSng1smAf8a+MZ8eUbaPZPbE31vIKDYgcgvyXSig20tsdSex7YRInYUYG4aH+
        Cr5+U0R/7IXPKz1nPNDqjiDv5L/lkuk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480--ds8VVeUMnisbEV12kvcLQ-1; Thu, 25 May 2023 11:33:36 -0400
X-MC-Unique: -ds8VVeUMnisbEV12kvcLQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9069802A55;
        Thu, 25 May 2023 15:33:35 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CB38C154D2;
        Thu, 25 May 2023 15:33:30 +0000 (UTC)
Date:   Thu, 25 May 2023 23:33:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        stable@vger.kernel.org, Jay Shin <jaeshin@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH V3] blk-cgroup: Flush stats before releasing blkcg_gq
Message-ID: <ZG9/xgWpob8ooGlZ@ovpn-8-21.pek2.redhat.com>
References: <20230525043518.831721-1-ming.lei@redhat.com>
 <sqsb7wcvxjfd3nbohhpbjihbr4armrh5sr6vu5pxci62ga7for@6om7ayuncxnc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sqsb7wcvxjfd3nbohhpbjihbr4armrh5sr6vu5pxci62ga7for@6om7ayuncxnc>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 25, 2023 at 04:11:34PM +0200, Michal Koutný wrote:
> On Thu, May 25, 2023 at 12:35:18PM +0800, Ming Lei <ming.lei@redhat.com> wrote:
> > It is less a problem if the cgroup to be destroyed also has other
> > controllers like memory that will call cgroup_rstat_flush() which will
> > clean up the reference count. If block is the only controller that uses
> > rstat, these offline blkcg and blkgs may never be freed leaking more
> > and more memory over time.
> 
> On v2, io implies memory too.
> Do you observe the leak on the v2 system too?

blkg leak is only observed on v1.

> 
> (Beware that (not only) dirty pages would pin offlined memcg, so the
> actual mem_cgroup_css_release and cgroup_rstat_flush would be further
> delayed.)
> 
> > To prevent this potential memory leak:
> > 
> > - flush blkcg per-cpu stats list in __blkg_release(), when no new stat
> > can be added
> > 
> > - add global blkg_stat_lock for covering concurrent parent blkg stat
> > update
> 
> It's bit unfortunate yet another lock is added :-/

Cause it should be the simplest one for backport, :-)

> 
> IIUC, even Waiman's patch (flush in blkcg_destroy_blkcfs) would need
> synchronization for different CPU replicas flushes in
> blkcg_iostat_update, right?
> 
> > - don't grab bio->bi_blkg reference when adding the stats into blkcg's
> > per-cpu stat list since all stats are guaranteed to be consumed before
> > releasing blkg instance, and grabbing blkg reference for stats was the
> > most fragile part of original patch
> 
> 
> At one moment, the lhead -> blkcg_gq reference seemed alright to me and

But bio->bi_blkg has grabbed one reference in blk_cgroup_bio_start
already.

> consequently blkcg_gq -> blkcg is the one that looks reversed (forming

IMO, this one is correct, cause blkcg_gq depends on blkcg.

> the cycle). But changing its direction would be much more fundamental
> change, it'd need also kind of blkcg_gq reparenting -- similarly to
> memcg.

Thanks, 
Ming

