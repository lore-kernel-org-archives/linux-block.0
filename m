Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575F5C433E0
	for <linux-block@archiver.kernel.org>; Wed, 20 Jan 2021 11:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BBE023139
	for <linux-block@archiver.kernel.org>; Wed, 20 Jan 2021 11:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbhATLWz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jan 2021 06:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbhATKH5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jan 2021 05:07:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB7AC061757;
        Wed, 20 Jan 2021 02:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oB6bOagXwR+k0i3DKoNOg46fE73bVdDB9v4Xz01POuQ=; b=EVNlUbvsyxqz5qg4y5PHqciTcs
        aJ3nFOgPgn673dOeTWK+YLdm6xtvRKr9Ctf/KsErx1ADRcoRYlKIAXeJD8DtsqNLlg+etbJSZS1+Z
        oPBYO6KZ5Q00Tk2k1soTqzThgCIOOHVICCyrMAEq+wpGbXHCzZTDVZX5nfMCyarG/JXkJlqmWDM0a
        BuGgQjFhk+lM5HXOPjdScBvBRSt+4tZHhGCCzAAC45Stng/h+fn8G+iP+VzD3uOUWW6igWgfbqjhr
        bY4tFIB835dX6SIYaVtr2iNePPRv7V74BKXOxFvZx69/MeaP64p82w/q7q+FOanKgnVZbAl31NfNK
        9x/9IXzw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2AMy-00FVxQ-LR; Wed, 20 Jan 2021 10:05:51 +0000
Date:   Wed, 20 Jan 2021 10:05:44 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Fix an error handling in add_partition
Message-ID: <20210120100544.GC3694085@infradead.org>
References: <20210117085023.24352-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117085023.24352-1-dinghao.liu@zju.edu.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jan 17, 2021 at 04:50:17PM +0800, Dinghao Liu wrote:
> Once we have called device_initialize(), we should use put_device() to
> give up the reference on error, just like what we have done on failure
> of device_add().
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
