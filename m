Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974F3C433F5
	for <linux-block@archiver.kernel.org>; Fri, 22 Apr 2022 03:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiDVDEu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Apr 2022 23:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443637AbiDVDEt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 23:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8756A4D240
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 20:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650596516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gUVXe3BQrg8EcXeZiKf6tLvHKvFJz9HPKCASAg863MI=;
        b=GhuGyu/vcKPDfXpp0OG4bRufvtIDT9ZixoLi6Y+sR7cUOqix+dVi1EcSoPpVg4L+rtIO+j
        jC0Cxs8t68OCyJUByJk21exYtCBwF4bwx5KRkJ18YT6uAQgpZdnjQaVOtSAFdkLpeKuM5l
        NEL8VtviCL8HdXSM37sbr5Vas9stNFE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-SZQlaQleMVyyLHscz44wAw-1; Thu, 21 Apr 2022 23:01:53 -0400
X-MC-Unique: SZQlaQleMVyyLHscz44wAw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E60911C04B61;
        Fri, 22 Apr 2022 03:01:52 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 17F51145BA76;
        Fri, 22 Apr 2022 03:01:48 +0000 (UTC)
Date:   Fri, 22 Apr 2022 11:01:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] block: fix "Directory XXXXX with parent 'block' already
 present!"
Message-ID: <YmIalwWdv30FgmKE@T590>
References: <20220421083431.2917311-1-ming.lei@redhat.com>
 <YmGBnbYByitxF3UW@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmGBnbYByitxF3UW@infradead.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 21, 2022 at 09:09:01AM -0700, Christoph Hellwig wrote:
> On Thu, Apr 21, 2022 at 04:34:31PM +0800, Ming Lei wrote:
> > q->debugfs_dir is used by blk-mq debugfs and blktrace. The dentry is
> > created when adding disk, and removed when releasing request queue.
> > 
> > There is small window between releasing disk and releasing request
> > queue, and during the period, one disk with same name may be created
> > and added, so debugfs_create_dir() may complain with "Directory XXXXX
> > with parent 'block' already present!"
> > 
> > Fixes the issue by moving debugfs_create_dir() into blk_alloc_queue(),
> > and the dir name is named with q->id from beginning, and switched to
> > disk name when adding disk, and finally changed to q->id in disk_release().
> 
> Is there any good reason to not just debugfs_remove_recursive in
> blk_unregister_queue and do away with all the renaming?

Please see the following reasons:

1) disk_release_mq() calls elevator_exit()/rq_qos_exit(), and the two
may trigger UAF if q->debugfs_dir is removed in blk_unregister_queue().

2) after deleting disk, blktrace still should/can work for tracing
passthrough request.

3) "debugfs directory deleted with blktrace active" in block/002 could
be triggered



thanks,
Ming

