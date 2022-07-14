Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73940C43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 13:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbiGNN6F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 09:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240250AbiGNN5w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 09:57:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC58562494
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 06:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WbzgFSQGJW6mZ9ZsJbXSdNDPKLScIdsXcnUTp4GAcuk=; b=d3MpfBPK92c+B1rIfnL7OpuzT3
        HaP64PPxVxnJgEap7E+drjb91jWHRAqPCdml017SSL1OwsAyuuMfKZOkwRVqhxuDaxiNeGctZ/0+t
        0yiY2x2vI8rZOgAyHRZMBKk/xuXVyhlEEQPN9IpI280MF9I4H4s0y1Apnvb68UUhFSEiz0/HIIwTO
        MUG5oHXVztMaNgDWgRTagySvWvokleYtQIYWjZh2fnS9HlMEi5Vh1HIewoTSsgGT2yv+BGDwPsII6
        zs2cgV3YlFlhqUJK0hvfxhGUgfmi+dHZlP4UJ/Ti2ytG2Mhtb7okpPxjvD7/TvaVLHGxf+y9qjx0A
        JYQRGHBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBzJQ-00Ex76-J1; Thu, 14 Jul 2022 13:55:28 +0000
Date:   Thu, 14 Jul 2022 06:55:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk_drv: fix request queue leak
Message-ID: <YtAgUFZgEONO3P3s@infradead.org>
References: <20220714103201.131648-1-ming.lei@redhat.com>
 <YtAWhRdXrumYEsU+@infradead.org>
 <YtAYGMvQ+N4RsJRG@T590>
 <YtAYwH45Ewy3+aLr@infradead.org>
 <YtAZgYh54V/CDNG+@T590>
 <YtAcBnGodvCUtaRP@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtAcBnGodvCUtaRP@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 14, 2022 at 09:37:10PM +0800, Ming Lei wrote:
> It is actually one big problem of 6f8191fdf41d ("block: simplify disk shutdown")
> since blk_put_queue() can't do what blk_cleanup_queue() did.
> 
> Anywhere using blk_put_queue() to release blk-mq queue before adding
> disk has the same issue.

And the reason why blk_put_queue can't do is seems to be mostly because
queues don't hold a reference on the tag set (and tag_sets don't have
a reference at all).  Which has caused us a bunch of issues before, so
let me see if I can fix that properly.
