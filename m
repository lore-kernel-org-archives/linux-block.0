Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C5AC433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54FA9610E7
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhJRJXp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 05:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhJRJXm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 05:23:42 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF5DC06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 02:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tgy1h5TJ8TlKjmAsMEGlUr73VGZIUVyhssa1de3G8Rw=; b=q1Vh/Sotas1e2WH0dSGt8GBv2w
        1RNo4a4Ls4xilpyXHPqA/cXhYOBZVKkR94zjwki5jmHkWrnl5AtJHG5N3Bo6bC5NqYYa/KQTld/lu
        ORplOPWtYguKgDP374kwpQ+1BJxm6XFxtlC+n5dJufyxk0PVAxFeW+jlezZjX1g+6ipNOLse1C5/X
        0xw+wF06Ddvf8SBhqAageoR7GmKSGcosaQ3ithejhNQ8qwGt9ELuVjEnMyUxiNEtvDVully+LnPu/
        X965auY0pXQip/DyaIvLTBA8Mli77eJFHy+OOuaS+JxDgcuq3dPre84h+CHpD7hL4O55/KuNsj7+A
        rik8rPsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcOpm-00Emxw-S2; Mon, 18 Oct 2021 09:21:30 +0000
Date:   Mon, 18 Oct 2021 02:21:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 12/14] block: align blkdev_dio inlined bio to a cacheline
Message-ID: <YW08mkgxKdqM4cEs@infradead.org>
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-13-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017013748.76461-13-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 16, 2021 at 07:37:46PM -0600, Jens Axboe wrote:
> We get all sorts of unreliable and funky results since the bio is
> designed to align on a cacheline, which it does not when inlined like
> this.

Well, I guess you'll need to audit all the front_pad users for
something like this then?
