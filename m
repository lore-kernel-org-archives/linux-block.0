Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8862BC77B7A
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 01:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjFLBho (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Jun 2023 21:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjFLBhn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Jun 2023 21:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5763BC7
        for <linux-block@vger.kernel.org>; Sun, 11 Jun 2023 18:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686533816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YrQbBfCMruid3dvNA82sFQHqZr8uVfLOg59uBwIc3/c=;
        b=GtXqoiYxpJGr6bV9nnuL0rY7iDHEPvSLcTDuja3p2eFIBdFdVXVezazwrqINGYG26/d31+
        6uiGrFRNi0OVzBp7l9yik+QNLLzaTJnnCKAdrJ2YkVBb6smhUKuyflYo6v2GiMuQQICnvJ
        Q9TpyGLYe7/lY5CUwRWYfBGJtA1JHC8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-9d73ADh_PcmrLuVMuf7Xug-1; Sun, 11 Jun 2023 21:36:51 -0400
X-MC-Unique: 9d73ADh_PcmrLuVMuf7Xug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F3FA1C03DB4;
        Mon, 12 Jun 2023 01:36:51 +0000 (UTC)
Received: from ovpn-8-23.pek2.redhat.com (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F48C2166B25;
        Mon, 12 Jun 2023 01:36:45 +0000 (UTC)
Date:   Mon, 12 Jun 2023 09:36:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, stable@vger.kernel.org,
        Jay Shin <jaeshin@redhat.com>, Tejun Heo <tj@kernel.org>,
        Waiman Long <longman@redhat.com>, mkoutny@suse.com,
        Yosry Ahmed <yosryahmed@google.com>, ming.lei@redhat.com
Subject: Re: [PATCH V4] blk-cgroup: Flush stats before releasing blkcg_gq
Message-ID: <ZIZ2qGXw7vrRB78e@ovpn-8-23.pek2.redhat.com>
References: <20230609234249.1412858-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609234249.1412858-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jun 10, 2023 at 07:42:49AM +0800, Ming Lei wrote:
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
> Acked-by: Tejun Heo <tj@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: mkoutny@suse.com
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V4:
> 	- add ack tag

Hi Jens,

Waiman agrees with this approach too[1], can you make it in v6.4 if you
are fine?

[1] https://lore.kernel.org/linux-block/64f20e27-0927-334d-5414-9bb81d639cec@redhat.com/

Thanks,
Ming

