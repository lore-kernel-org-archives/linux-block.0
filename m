Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D27C433F5
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 14:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiBIOCt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 09:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbiBIOCp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 09:02:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2CAC05CB88
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 06:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ELLQX5+RtU96CG5yDd1IkEalUila9b6dvtEJNRapEyg=; b=zhg5DiqCP3CilyWUFyfxWu4lU2
        KjQsb5xDJ5Zc+8A1ucXtHXwsRBte8n1m4KiOO5wwFs5RjhbvtlJuZr6HQiNn4gZO72czH265HZ6Tz
        bxdMr/X82NRgF0YYTVc6yRV2ZNre88+HMoXS5A1qsdpPUNBfW/RTSa/0mg0A0U6dDgoaqo7d64Koz
        J29BIEtXQKhbDqc/aPN0nbe+m3A3ct6EUdi0n85C+6VGqyojtRLy7PUJwsAwmFY07OuHWiD3/GCHI
        Z32BeTKHbolDu78O5w9d6fTXoN3I3EGCaVtFhCbAunYbEkk4b59ynA+iGt+ppAQ4j3Fm/Qu9aDxvu
        VkQoCyjg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHnYK-000Ht6-BY; Wed, 09 Feb 2022 14:02:36 +0000
Date:   Wed, 9 Feb 2022 06:02:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Li Ning <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH V2 3/7] block: don't declare submit_bio_checks in local
 header
Message-ID: <YgPJfCIoBCtmAsux@infradead.org>
References: <20220209091429.1929728-1-ming.lei@redhat.com>
 <20220209091429.1929728-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209091429.1929728-4-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 09, 2022 at 05:14:25PM +0800, Ming Lei wrote:
> submit_bio_checks() won't be called outside of block/blk-core.c any more
> since commit 9d497e2941c3 ("block: don't protect submit_bio_checks by
> q_usage_counter").

Please also mark it static while you're at it.
