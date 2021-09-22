Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCA0C433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 05:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B166112F
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 05:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhIVFYK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 01:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhIVFYJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 01:24:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1896AC061574;
        Tue, 21 Sep 2021 22:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=am/B39l3z9xACPiw/TmRIIL1/H5PSHN0ZZvj5bQfGJs=; b=q/a1J16KMt81ND9X1Rzgu2YPJE
        Y3MqGA6L7PnTzJxJj4Xc+nmdUuWsE4BwK9rT01qa5Vr5xOrW+5birF7wbsOsf3bZUC8eZuc8eP9LJ
        X+G6JSuYwFjTRGnApVkhx5I0qJRIKchBBFzF2ACh5fRP6+EOkkZ2hdxg7IMWsZqFGtsALOdl11Nxt
        Fb3cUWDYE16tuVpo6XiSvoP9H4CUBjJV+ITAooi7hKZ+z7L7LR9ZaCijYvLfW45hZeHDCc1j3U/2u
        zpmqlXjYXs53i54wopjgSvC6QuefZPu3kDmIDGMwAEO12mZVUOOwtZGo4XMrTmOgsOuLinAhEQzo1
        SXZuGltA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSuhL-004TKX-6A; Wed, 22 Sep 2021 05:21:47 +0000
Date:   Wed, 22 Sep 2021 06:21:35 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     axboe@kernel.dk, rostedt@goodmis.org, mingo@redhat.com,
        acme@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH] blktrace: Fix uaf in blk_trace access after removing by
 sysfs
Message-ID: <YUq9X2dHG+LkMvQ6@infradead.org>
References: <20210910092120.182270-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910092120.182270-1-chengzhihao1@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 10, 2021 at 05:21:20PM +0800, Zhihao Cheng wrote:
> +		else {
> +			/*
> +			 * Don't remove blk_trace under running state, in
> +			 * case triggering use-after-free in function
> +			 * __blk_add_trace().
> +			 */
> +			if (bt->trace_state != Blktrace_running)
> +				ret = blk_trace_remove_queue(q);
> +			else
> +				ret = -EBUSY;
> +		}
>  		goto out_unlock_bdev;

So who is going to eventually call blk_trace_free in this case?

Also Having the check in blk_trace_remove_queue would seem a little
cleaner.
