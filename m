Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2683FC433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E67E561278
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238467AbhDLJqj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 05:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243542AbhDLJmY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 05:42:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8058AC061372
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 02:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wc1obG7oQbtBmhuM6MkYMF2AyXJCF0Lo7DtwxbYymnc=; b=dtx3FFSEYJm1Xg5VsOVvMt/Wak
        H8EwQiZNLXMGvg7sPm6yH/jqE/f23LM4nDa+vxHyzj6a2L9h3UmRQLrPbQRkzCMuJ6emjiz/TYdRq
        ob9YluiFNQzRG9ySFkiXq0N0NiGBt2EwPg9fPqAtlrec+cfME7ZhnrwIfbL1yFcfhHja/EzEvXkb4
        ehTPBtP+N4ww756oEaJLxaCdxFuqfU4EgzJ8uvMSgsxGDFAO2bi7e6KPrHcP+QXPDd83iCx+CLrBb
        pbPk6oRyJYyfM9Wb20pmuBSTji/C1jJ6WPkJWU9Ijzg9/1y2Cz1AL9ePIaT/jTUMBOS6Y7MQNGbM4
        U652BXpg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lVt20-00474E-Sm; Mon, 12 Apr 2021 09:39:04 +0000
Date:   Mon, 12 Apr 2021 10:38:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 11/12] block: add poll_capable method to support
 bio-based IO polling
Message-ID: <20210412093856.GA978201@infradead.org>
References: <20210401021927.343727-1-ming.lei@redhat.com>
 <20210401021927.343727-12-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401021927.343727-12-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 01, 2021 at 10:19:26AM +0800, Ming Lei wrote:
> From: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> This method can be used to check if bio-based device supports IO polling
> or not. For mq devices, checking for hw queue in polling mode is
> adequate, while the sanity check shall be implementation specific for
> bio-based devices. For example, dm device needs to check if all
> underlying devices are capable of IO polling.
> 
> Though bio-based device may have done the sanity check during the
> device initialization phase, cacheing the result of this sanity check
> (such as by cacheing in the queue_flags) may not work. Because for dm
> devices, users could change the state of the underlying devices through
> '/sys/block/<dev>/io_poll', bypassing the dm device above. In this case,
> the cached result of the very beginning sanity check could be
> out-of-date. Thus the sanity check needs to be done every time 'io_poll'
> is to be modified.

I really don't think thi should be a method, and I really do dislike
how we have all this "if (is_mq)" junk.  Why can't we have a flag on
the gendisk that signals if the device can support polling that
is autoamtically set for blk-mq and as-needed by bio based drivers?
And please move everything that significantly hanges things for the
mq based path to separate prep patches early in th series.
