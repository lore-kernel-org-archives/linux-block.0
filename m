Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70426C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 07:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiBOH4Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 02:56:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBOH4X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 02:56:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D976EBF525
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 23:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h5VruHn8LgH13wZY1qVk/ADsyG+juzIjMyOI6uXRWLA=; b=AoURVGvNA3XbO2/1A3n8A4uQ7r
        tl1gnUiLUz3kTqN7rA+h6SQWYyuVqZ4O4qKvgCqcCKiNtZHmWUiIXEZ0jdqoKvkpGoxBaYI8AvjHv
        QM/mutPMc74xv8aArNc+upRt93E+UFr2xjnYXFrGrCuttMIEgmIpB/8iuYg06kNxBxH20BBtdF5nP
        PKkOx1ntUDML7mATWM4tO5+2aPdaCs5qQih23YTppSBxLupAivF15rzlvd3G6waiIoI/0SbwCJlF5
        japBqPR0AL3cJuoDghy3jfKzf0tzR5oQsxGkrSaN/veCAgntWyNjnKpAEkphA+rZRPJBF84U4cSRf
        vwPz8LkA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJsgr-001Pm6-HE; Tue, 15 Feb 2022 07:56:01 +0000
Date:   Mon, 14 Feb 2022 23:56:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Li Ning <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH V3 3/8] block: don't declare submit_bio_checks in local
 header
Message-ID: <YgtckZP+u8hir5gj@infradead.org>
References: <20220215033050.2730533-1-ming.lei@redhat.com>
 <20220215033050.2730533-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215033050.2730533-4-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 15, 2022 at 11:30:45AM +0800, Ming Lei wrote:
> submit_bio_checks() won't be called outside of block/blk-core.c any more
> since commit 9d497e2941c3 ("block: don't protect submit_bio_checks by
> q_usage_counter"), so mark it as one local helper.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
