Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB92C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 05:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240858AbiDLFaN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 01:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240383AbiDLFaL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 01:30:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFF234B81
        for <linux-block@vger.kernel.org>; Mon, 11 Apr 2022 22:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=32XuRnLyycr6E1ydFLiKQS7WOYQdiFoBJCL0skZrtUY=; b=osDQtdSRYYyuty4FeErIdlzrtG
        H5xNmpSBSBjl956pugv3bQoyW1M3Ap6xLvmrd8Bs1hIGVKeN1QBKt5ZIndAAWqPQxvrP/RbqTgJoR
        aKle0U8Trw5qWuH8GdLK5IRytnu4qvErMfBrhN/RMjaerleaxgMt28CZdnorc5wdLOgBVDHNVJoKv
        0FdFqRhVszyXIZaoR57UfA5RLe0+O2Xop5KwBfijMcj3GrDSWOPMn/PI/i+QOavx5maTOhNiKQq2C
        N55SpQps6cAYoxY2DOx33qNGcqaKs/q6OKMbLMnoO49U9goiW0LuncLwGnHGNQrjeYje6NI/Plod6
        pivGo/Jg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ne94F-00BmLK-0M; Tue, 12 Apr 2022 05:27:55 +0000
Date:   Mon, 11 Apr 2022 22:27:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Dennis Zhou <dennis@kernel.org>, tj@kernel.org,
        axboe@kernel.dk, dm-devel@redhat.com
Subject: Re: [PATCH] block: remove redundant blk-cgroup init from __bio_clone
Message-ID: <YlUN2pVsIn1dbzHg@infradead.org>
References: <YkSK6mU1fja2OykG@redhat.com>
 <YkRM7Iyp8m6A1BCl@fedora>
 <YkUwmyrIqnRGIOHm@infradead.org>
 <YkVBjUy9GeSMbh5Q@fedora>
 <YkVxLN9p0t6DI5ie@infradead.org>
 <YlBX+ytxxeSj2neQ@redhat.com>
 <YlEWfc39+H+esrQm@infradead.org>
 <YlReKjjWhvTZjfg/@redhat.com>
 <YlRiUVFK+a0DwQhu@redhat.com>
 <YlRmhlL8TtQow0W0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlRmhlL8TtQow0W0@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 11, 2022 at 01:33:58PM -0400, Mike Snitzer wrote:
> When bio_{alloc,init}_clone are passed a bdev, bio_init() will call
> bio_associate_blkg() so the __bio_clone() work to initialize blkcg
> isn't needed.

No, unfortunately it isn't as simple as that.  There are bios that do
not use the default cgroup and thus blkg, e.g. those that come from
cgroup writeback.
