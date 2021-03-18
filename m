Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFA6C433DB
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 12:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84D9364EED
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 12:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhCRM4s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Mar 2021 08:56:48 -0400
Received: from verein.lst.de ([213.95.11.211]:41586 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhCRM4T (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 08:56:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D84DC68C4E; Thu, 18 Mar 2021 13:56:17 +0100 (CET)
Date:   Thu, 18 Mar 2021 13:56:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        keescook@chromium.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: do not copy data to user when bi_status is error
Message-ID: <20210318125617.GC21262@lst.de>
References: <20210318122621.330010-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318122621.330010-1-yanaijie@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 18, 2021 at 08:26:21PM +0800, Jason Yan wrote:
> When the user submitted a request with unaligned buffer, we will
> allocate a new page and try to copy data to or from the new page.
> If it is a reading request, we always copy back the data to user's
> buffer, whether the result is good or error. So if the driver or
> hardware returns an error, garbage data is copied to the user space.
> This is a potential security issue which makes kernel info leaks.
> 
> So do not copy the uninitalized data to user's buffer if the
> bio->bi_status is not BLK_STS_OK in bio_copy_kern_endio_read().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
