Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9540EC433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A5F6103D
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhJTMj3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTMj3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 08:39:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FE4C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 05:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X7z/Ib/JI1l4VWTKFfy6IwULjQVco37PTfRMYnynCJ4=; b=eDBOPr9K2+Z+FZzTNAIUcASzwJ
        /tveqGmnUpgnTBTAEYLAyKKMHy6c9fLKWBL0LgWhuC0Ew6IckaploigOHdXiBSQ55skAiBs0cb5tl
        EWp0sZlTiJYB129GkfjrexxFFn42Q/YVhL45iE/W4YXb1qs3scZuKLB8+9ptfYVlWudJ8ZgrTBnvN
        eR68gU4RDPNRewO+0c0f+GzRXjjS5wMAjU7fjbxBIzMeOxR/wsdKz6xyTQ0Q8dEY1VNX7T/1B2n11
        lGicPs/r/TW3isbzYS6xFJLpbvxsGK0hVvrlsp2aFYywPvIOuUFbxwbuBmzUQUd2/4qJKUo6M6Iv9
        DzpaKQ9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdAqG-004UjY-1f; Wed, 20 Oct 2021 12:37:12 +0000
Date:   Wed, 20 Oct 2021 05:37:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 07/16] blocK: move plug flush functions to blk-mq.c
Message-ID: <YXANeFjY0Zw3e1vT@infradead.org>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <bb6fe6de2fe6bd69ccf9bc8af049ffedcf52bda0.1634676157.git.asml.silence@gmail.com>
 <YW+0h4nARoKeonn2@infradead.org>
 <366c2f9b-c255-7140-a2e0-d93856017bf2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366c2f9b-c255-7140-a2e0-d93856017bf2@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 20, 2021 at 01:23:05PM +0100, Pavel Begunkov wrote:
> How about leaving flush_plug_callbacks() in blk-core.c but moving
> everything else?

That's at least a little better.  I'd still prefer to keep the wrappers
out as well.  I've been wondering a bit if the whole callback handling
needs a rework.  Let me thing about this a bit more, maybe I'll have
patches later today.
