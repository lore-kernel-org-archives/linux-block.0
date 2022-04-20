Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB5AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 02:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358915AbiDTCXs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 22:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiDTCXs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 22:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB0F12AC60
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 19:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650421262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7nmJqhMRmg/yjGaYYM+pE/QMOABTkth3WNm+buaQly8=;
        b=P46sCEpWzcDg5BuYu/+tPL7HYyOWHtWE/g3rHn6ACIN+JqW3s9bKBLJMeUXXnFdOUNehFX
        L9bcDS7G22A0wVAJ6FPA/uqrfEQEfEltXDfxyD5UnfVqG1nmTmBXaAr2sUeavrAFY0w8y+
        oxxFET5RTG1uoB0uRZZklOAaa4G2eFc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-Tl8OV1EGNB6-Ye5-oLo-nA-1; Tue, 19 Apr 2022 22:20:59 -0400
X-MC-Unique: Tl8OV1EGNB6-Ye5-oLo-nA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE9CF80C8FB;
        Wed, 20 Apr 2022 02:20:58 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FD7D2166BA3;
        Wed, 20 Apr 2022 02:20:49 +0000 (UTC)
Date:   Wed, 20 Apr 2022 10:20:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/3] block: let blkcg_gq grab request queue's refcnt
Message-ID: <Yl9t/Dy7C53DFEh0@T590>
References: <20220318130144.1066064-1-ming.lei@redhat.com>
 <20220318130144.1066064-3-ming.lei@redhat.com>
 <eac2af72d9e73f79bbdbe8253f7562d9f17046b3.camel@intel.com>
 <292908e4-8721-20a0-2720-e60641a1fbe4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <292908e4-8721-20a0-2720-e60641a1fbe4@huawei.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 20, 2022 at 10:01:36AM +0800, yukuai (C) wrote:
> 在 2022/04/20 9:46, Williams, Dan J 写道:
> > On Fri, 2022-03-18 at 21:01 +0800, Ming Lei wrote:
> > > In the whole lifetime of blkcg_gq instance, ->q will be referred, such
> > > as, ->pd_free_fn() is called in blkg_free, and throtl_pd_free() still
> > > may touch the request queue via &tg->service_queue.pending_timer which
> > > is handled by throtl_pending_timer_fn(), so it is reasonable to grab
> > > request queue's refcnt by blkcg_gq instance.
> > > 
> > > Previously blkcg_exit_queue() is called from blk_release_queue, and it
> > > is hard to avoid the use-after-free. But recently commit 1059699f87eb ("block:
> > > move blkcg initialization/destroy into disk allocation/release handler")
> > > is merged to for-5.18/block, it becomes simple to fix the issue by simply
> > > grabbing request queue's refcnt.
> > 
> > This patch, upstream as commit 0a9a25ca7843 ("block: let blkcg_gq grab
> > request queue's refcnt") causes the nvdimm unit tests to spam messages
> > like:
> > 
> > [   51.439133] debugfs: Directory 'pmem2' with parent 'block' already present!
> > [   52.095679] debugfs: Directory 'pmem3' with parent 'block' already present!
> > [   52.505613] block device autoloading is deprecated and will be removed.
> > [   52.791693] debugfs: Directory 'pmem2' with parent 'block' already present!
> > [   53.240314] debugfs: Directory 'pmem3' with parent 'block' already present!
> > [   53.373472] debugfs: Directory 'pmem3' with parent 'block' already present!
> > [   53.688876] nd_pmem btt2.0: No existing arenas
> > [   53.773097] debugfs: Directory 'pmem2s' with parent 'block' already present!
> > [   53.884493] debugfs: Directory 'pmem2s' with parent 'block' already present!
> > [   54.042946] debugfs: Directory 'pmem2s' with parent 'block' already present!
> > [   54.195954] debugfs: Directory 'pmem2s' with parent 'block' already present!
> > [   54.383989] debugfs: Directory 'pmem2' with parent 'block' already present!
> > [   54.577206] nd_pmem btt3.0: No existing arenas
> > 
> Hi,
> 
> I saw the same warning in our test, and I posted a patch to fix the
> problem:
> 
> https://patchwork.kernel.org/project/linux-block/patch/20220415035607.1836495-1-yukuai3@huawei.com/
> 
> The root cause is not relate to the above commit, see details in
> the commit message.

Yeah, I am pretty sure the issue of 'debugfs: Directory 'XXXXX' with parent 'block' already
present!' is one block layer long-term issue.

Commit 0a9a25ca7843 ("block: let blkcg_gq grab request queue's refcnt") justs causes queue
released a bit late, then the issue becomes easier to trigger.


Thanks,
Ming

