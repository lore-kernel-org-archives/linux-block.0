Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6263C433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 07:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiBOH5g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 02:57:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBOH5f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 02:57:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF74C559E
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 23:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tk6GspOSzGN9qb5BFSd8+mo2cfFLflDZRfIF9kUXnZI=; b=RiKtyd4Vz7xX3/GCVfTgTLNU24
        8u3zTHVDGp7riltA15UNU8mt3s6ErcVGlw+vRCIdq+ZarRjFM79QeLKQH1rnUfMrsIfjM7VMUihwB
        +J0iyA1xqLG3jj6KOBN/kp2kbtHdwniIrjd3zqWMsmjMlQR1BHp/hwfrXCF3lTJ8Y4TASCaFnqGci
        13TO2sEnZ58HgwthDPplFnQ+HqSLdurUjPlRxZcSIz062SaUiD7uQtx8dSbAU2lf0mdnKagJ39toq
        JD3WKglRPGxIbPDxBDGCcWYx7BnzlZhoQdio8uIC6OBjUVS1wjdI9MODebLS+kpKpdZBMUAiF04WL
        hXh6CFjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJsi2-001QI0-VN; Tue, 15 Feb 2022 07:57:14 +0000
Date:   Mon, 14 Feb 2022 23:57:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Li Ning <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH V3 4/8] block: don't check bio in
 blk_throtl_dispatch_work_fn
Message-ID: <Ygtc2rIGVZkLRgTp@infradead.org>
References: <20220215033050.2730533-1-ming.lei@redhat.com>
 <20220215033050.2730533-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215033050.2730533-5-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 15, 2022 at 11:30:46AM +0800, Ming Lei wrote:
> The bio has been checked already before throttling, so no need to check
> it again before dispatching it from throttle queue.
> 
> Add one local helper of submit_bio_noacct_nocheck() for this purpose.

s/one/a/.  Also I'm not sure I'd call it "local" given that it is used in
a different file.

> +void submit_bio_noacct_nocheck(struct bio *bio)
> +{
> +	__submit_bio_noacct_nocheck(bio);
> +}

No need for a wrapper here.
