Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03106C433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 12:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D952D6103B
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 12:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbhI0M2Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbhI0M2P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 08:28:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CF6C061575
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 05:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=De9ycQdIBm+wMhFeTN99MU2UIX05Sh5gE12mRTutDzM=; b=am1pY0Ji/XNpPJht9j8C9y4Jkc
        t4K3RXahr5SCd/Lh2ItXyyfQaPhUNjyXaUCWIMQtEHN4CybxBIC4CB5LquYf9EiBCbkwsPLEo2mrg
        T6Ipa8uZwb/3GjdmPl0p+90nhdX3EBGXWIex5oYGYRLnV/NdBtw+TJBVCDlYnvKO1Qeg+o1/BUyUM
        3CkpqvfytMj2SEAia5mOChTSsV6EgfZrQ9aneZKhXA3Bf6YuXp3Bwti23rK+hKLen536LR/rREiGY
        ba1DOTfSriNwTtyY4KuiFewQBTYl7c4i0QW3cl/Ga2U3rdEqIf1PGpe/cIbdHBqFLWM+itcqcRx/x
        1BeaYmWg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUpLp-009iqN-E4; Mon, 27 Sep 2021 12:03:35 +0000
Date:   Mon, 27 Sep 2021 13:03:17 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Muneendra Kumar <muneendra.kumar@broadcom.com>,
        Tejun Heo <tj@kernel.org>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH] block: only allocate blkcg->fc_app_id when starting to
 use it
Message-ID: <YVGzBWTk4jO5vqvv@infradead.org>
References: <20210924122416.1552721-1-ming.lei@redhat.com>
 <YU33EJ8dLgwPj2/5@infradead.org>
 <YVAnW8hQqItBeQAn@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVAnW8hQqItBeQAn@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Sep 26, 2021 at 03:55:07PM +0800, Ming Lei wrote:
> There isn't such sync for strlcpy, blkcg_set_fc_appid is called from
> sysfs attribute write, and cgroup_id is specified on the write buffer,
> so cmpxchg is needed. Also the comment in blkcg_set_fc_appid() explained
> that:
> 
>         /*
>          * There is a slight race condition on setting the appid.
>          * Worst case an I/O may not find the right id.
>          * This is no different from the I/O we let pass while obtaining
>          * the vmid from the fabric.
>          * Adding the overhead of a lock is not necessary.
>          */

But it isn't really a good idea.  If you have e.g. IDs with a shared
prefix this will lead to incorrect results.  I think we need a proper
locking or RCU scheme here, which should also give you the dynamic
allocation and freeing for free.
