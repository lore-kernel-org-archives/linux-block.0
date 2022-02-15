Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851E7C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 01:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiBOBLP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 20:11:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiBOBLO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 20:11:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41F46D76C6
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 17:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644887465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4oWhO6pedKgIwDIL+4teVY9ub6KSTs2DHUfVoyoNKLw=;
        b=cOOhAQ6yK7XDi0/ukOdiWdSE2aHZugPnHGa0RrfWIzUr+bIv+5SLNFA0RbUCr0YfcCUYN5
        Ajl/rG6nFKKvKOSrGv0oWrZzz199tgIVjgt56xNDzJmAOvM63PSLuu3ik3HwAkfHbcK5qp
        Oa4XDh0Q6q2DTP91ab+u4Eqfc9elJUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-xrrVp6p9OeyT8qcNWh2ZHQ-1; Mon, 14 Feb 2022 20:11:02 -0500
X-MC-Unique: xrrVp6p9OeyT8qcNWh2ZHQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A0D02F46;
        Tue, 15 Feb 2022 01:11:00 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 955895C25D;
        Tue, 15 Feb 2022 01:10:22 +0000 (UTC)
Date:   Tue, 15 Feb 2022 09:10:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Li Ning <lining2020x@163.com>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH V2 5/7] block: throttle split bio in case of iops limit
Message-ID: <Ygr9evnWSjcCjYkd@T590>
References: <20220209091429.1929728-1-ming.lei@redhat.com>
 <20220209091429.1929728-6-ming.lei@redhat.com>
 <Ygq6GanKSLlTixqe@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygq6GanKSLlTixqe@slm.duckdns.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 14, 2022 at 10:22:49AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Feb 09, 2022 at 05:14:27PM +0800, Ming Lei wrote:
> > Chunguang Xu has already observed this issue and fixed it in commit
> > 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large IO scenarios").
> > However, that patch only covers bio splitting in __blk_queue_split(), and
> > we have other kind of bio splitting, such as bio_split() &
> > submit_bio_noacct() and other ways.
> 
> I see. So, we can go for adding split handling to all other places or try to
> find a common spot.
> 
> > This patch tries to fix the issue in one generic way by always charging
> > the bio for iops limit in blk_throtl_bio(). This way is reasonable:
> > re-submission & fast-cloned bio is charged if it is submitted to same
> > disk/queue, and BIO_THROTTLED will be cleared if bio->bi_bdev is changed.
> > 
> > This new approach can get much more smooth/stable iops limit compared with
> > commit 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large IO
> > scenarios") since that commit can't throttle current split bios actually.
> > 
> > Also this way won't cause new double bio iops charge in
> > blk_throtl_dispatch_work_fn() in which blk_throtl_bio() won't be called
> > any more.
> 
> But yeah, this should work too. This is simpler but more fragile given the
> twisted history around BIO_THROTTLED. I think the root cause of the
> convolution is that it's hooked at the wrong spot - it's sitting on top of
> the queue trying to guess what actually happens to the bios it sent down.
> Ideally, we probably wanna move this to rq-qos hooks which sit on the actual
> issue-to-the-device path.

The big problem is that rq-qos is only hooked for request based queue,
and we need to support cgroup/throttle for bio base queue.

> 
> For now, I don't have a strong preference. This looks fine to me too. Please
> feel free to add
> 
>  Acked-by: Tejun Heo <tj@kernel.org>
> 
> for the blk-throtl patches.

Thanks!

-- 
Ming

