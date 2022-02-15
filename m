Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEC8C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 07:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiBOH7D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 02:59:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBOH7D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 02:59:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C86513D30
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 23:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KNqxvRJ1QBkTU+YK5CCpeaSaSqTtJe74E1VHidiY5Bk=; b=E3Vm3F7H3xwQIKUVNZB79KI4yz
        s1oB9BYKsjMJvTauZIjPn1WK5rZlaWX8HZDcY6rL+FLD11N2YnNCEnaBgYTGSeaFAuo2bf0gjVDFH
        f7dPyUKcOD9i3L++xAquMmtPT2FmgtA5vC5buptOMOXY968+cfiPVl4/EcU14ECi7n+3gbH2URTbJ
        ADqmaqLAs47CGu2eaGC//KY5IxiOthICrrt7Mt4zQunwbsDyz8WZ0P6o6CYJA+EQBvG70eKpKhg2D
        t/xKyXM/B5qWu2IXaYg0lzRvz/tjTh9+JWBxiCrsfvvafam3JgXacS9ABZw1KvSHrdKDjiWZJSgkG
        wrVit04g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJsjT-001R1M-9i; Tue, 15 Feb 2022 07:58:43 +0000
Date:   Mon, 14 Feb 2022 23:58:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Li Ning <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 5/8] block: merge submit_bio_checks() into
 submit_bio_noacct
Message-ID: <YgtdM64LQ0Lv8FQV@infradead.org>
References: <20220215033050.2730533-1-ming.lei@redhat.com>
 <20220215033050.2730533-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215033050.2730533-6-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	if (!blk_throtl_bio(bio)) {
> +		blk_cgroup_bio_start(bio);
> +		blkcg_bio_issue_init(bio);
> +
> +		if (!bio_flagged(bio, BIO_TRACE_COMPLETION)) {
> +			trace_block_bio_queue(bio);
> +			/* Now that enqueuing has been traced, we need to
> +			 * trace completion as well.
> +			 */
> +			bio_set_flag(bio, BIO_TRACE_COMPLETION);
> +		}
> +
> +		__submit_bio_noacct_nocheck(bio);

I much prefered the early return in the old code as it clearly
document the flow.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
