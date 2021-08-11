Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F42C4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 05:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B6560F55
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 05:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbhHKFWt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 01:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbhHKFWt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 01:22:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9440BC061765;
        Tue, 10 Aug 2021 22:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vpzaQyEKrZmYpNp17799MlfevE7lZ5qGY4jkrsTFkd4=; b=mFTzQwKJPyhWj8LabAH5uU9j4b
        F3jWWlaCoCd0sPss8/w0SnqlNPJI8wu1qb8etX+TDJx06ZQIEe95hK5uiNHr+ZhTnAXAvc36eutjr
        UbVeSuHd0j043Sep41pznPLKjeFojPT1aLYAbLFWCP+N14Ye3aSlhLChPTP823Be/frDLeYT8osNN
        AXrRDcOs6rWJ06OHJ20PnCwFzsw5lZm+so3IHpxM0B7j6jHPlI97t7l6M7/ssihiqhFgvIaLJgAfH
        6Z8R5icMjMtTLp4lRWUjNHk1TuSEbKpI7t2bdvPQj6geefGpzjrSJ+5NvezQLcXFn8cvsOISbXLSq
        PJE9ZZJw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDgeG-00CzyX-HN; Wed, 11 Aug 2021 05:19:44 +0000
Date:   Wed, 11 Aug 2021 06:19:28 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     luomeng <luomeng12@huawei.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] block: replace incorrect uses of GENHD_FL_UP
Message-ID: <YRNd4O1uV1auj/pK@infradead.org>
References: <20210720182048.1906526-1-mcgrof@kernel.org>
 <051ab019-5163-e691-43ed-052401b6b95a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <051ab019-5163-e691-43ed-052401b6b95a@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 11, 2021 at 10:42:20AM +0800, luomeng wrote:
> Hi:
>    When the fuzz test injected memory allocation failed, I had this BUG_ON:
> kernel BUG at fs/sysfs/group.c:116.
>   The cause of the bug_ON is that the add_disk memory fails to be allocated
> but no error processing is performed.
>   I find your patches add error processing. So what is your next step with
> these patches.

I have one more pending series on top of this one I need to submit here:

http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/alloc_disk

to make sure the disk always has a valid queue reference.  After that
Luis work to return an error from add_disk should be much easier bause
we not have defined state.
