Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBEAC433EF
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 08:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbiAQIVs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiAQIVs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 03:21:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A179C061574
        for <linux-block@vger.kernel.org>; Mon, 17 Jan 2022 00:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S1Cv1oQVWM5nQp6CNO1bNho0njmU7CfIDXlPXseVftw=; b=wKShy7SVvI0xi4OIB4qTPlbMFZ
        5kp53mwvOzay0LzRjZsHe6/f0L1Te4E6yZ6tWVb/iYpR+mTF51J8Omo2Tx3BUFQj0CmsIIEhfrV4o
        LXBttzM9o5/Junleldg5/81hhGGkhxP3/MbVjVuAjg2k6ZMZBzlzIWrdCWYNL+Ck95DfY+OsYO4P5
        yWWtdt/9jLRyLzHn0MoqSz28p3WEDt6fznAkwvZR9igFweoe+wOcm6BNG81MKoC8WE9bAGy0HPKey
        UU1dUVzUgQHSiiDLdb1lkTE8PPXCRlCGgtBJ3HVagrE9ZhODcFFRzU9vHnrj+fO9rK9Q6ykeqw+8j
        9mDLdGtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9NGj-00E3Ca-8w; Mon, 17 Jan 2022 08:21:37 +0000
Date:   Mon, 17 Jan 2022 00:21:37 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Li Ning <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [RFC PATCH 3/7] block: allow to bypass bio check before
 submitting bio
Message-ID: <YeUnERz9Qoz2UtVn@infradead.org>
References: <20220111115532.497117-1-ming.lei@redhat.com>
 <20220111115532.497117-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111115532.497117-4-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>   * systems and other upper level users of the block layer should use
>   * submit_bio() instead.
>   */
> -void submit_bio_noacct(struct bio *bio)
> +void __submit_bio_noacct(struct bio *bio, bool check)
>  {
> -	if (unlikely(!submit_bio_checks(bio)))
> +	if (unlikely(check && !submit_bio_checks(bio)))
>  		return;

This doesn't make sense as an API - you can just move the checks
into the caller that pass check=true.

Also the lowlevel nocheck API really has no business being exported.
