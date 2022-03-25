Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3341AC433F5
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 08:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355842AbiCYIsZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 04:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbiCYIsZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 04:48:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5831BCA0C5;
        Fri, 25 Mar 2022 01:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GndsMS+HCCXrAMYVTl7GFIxT7eAgYgogUAniECCXeLE=; b=rrPLZq5D/c+Y/KXvuRsHhIzE8D
        fFh+5QYx9fA2Jes9DPGwYAIgiiPHna1frqq/3nlXz9KS8Uo0+NCK42ErwN47oVQtgPA8uZYv2C+TI
        rPlukl4f++52AXvmTmVvvTQat84iMR+1vnks6kASddpKBS9QJydD3OmJHWAN/9tUGhVwJOA4XLHKb
        p0g3oyKsPEh63YD5eG7qAYQe8cDe/E1+5uQL6n8HpC/4vkYT5JCfdViVhIgQM5nLWVg0TWIPdal0P
        60Yko4Lxp4SJpFmL9sqe4zD5S/YScQQxWEB5ieWenImP65AZkaVO/6dzw6GrGoGyo1vTmk9p7OfBX
        z12ADELA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXfam-001SEc-BC; Fri, 25 Mar 2022 08:46:44 +0000
Date:   Fri, 25 Mar 2022 01:46:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, mpatocka@redhat.com, snitzer@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH 1/3] block: don't show disk stats if io accounting is
 disabled
Message-ID: <Yj2BdMoSc2rvWo4p@infradead.org>
References: <20220317112653.1019490-1-yukuai3@huawei.com>
 <20220317112653.1019490-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317112653.1019490-2-yukuai3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 17, 2022 at 07:26:51PM +0800, Yu Kuai wrote:
> If io accounting is disabled, there is no point to handle such device
> in diskstats_show(), and it can be confused for users because all fields
> in iostat are zero while the disk is handling io.

But changing the output will break existing users looking at it.
