Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10A4C433F5
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 06:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbiFAGS7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243882AbiFAGS6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 02:18:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF27356C00
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 23:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3C+6WzgEOxD3Th3lbBMw2iqkkXvLHiw6iB/fnEH+cRU=; b=AzrBlc0/9f06o/RXllSaaZmP6w
        EkP5jjoEaq6TA3GA0uPJppx/4kzrgoRR6Y9tpJ5NdW5sxDF+JQVAN7XXi2GsoemhFYu/ocH6SZEYm
        7JbbNXq31laVCKNhhWVIZgr0k0iAx3JXZfG20LR8SyJUndD0sDNBJXeMBBWOafPcTzE5X2pdZGAOU
        0SOkJBGsF9DgKsFgltRBVgCYGFi82Fvs6UQNjI4Ym9bePT/q17MYw6HajA/xgeFv0OlO8XbANzPbU
        F/1OQC5wtGnxO2rJf2SjVaVXLOjrZT7VcmjAKglCKF9iNlobSLhnFgf0U+XrFYFbi4W26W/h6jn9f
        JMJXuEUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwHgz-00E5mV-3C; Wed, 01 Jun 2022 06:18:53 +0000
Date:   Tue, 31 May 2022 23:18:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, david@fromorbit.com
Subject: Re: bioset_exit poison from dm_destroy
Message-ID: <YpcEzU11WS52gpmk@infradead.org>
References: <YpK7m+14A+pZKs5k@casper.infradead.org>
 <2523e5b0-d89c-552e-40a6-6d414418749d@kernel.dk>
 <YpZlOCMept7wFjOw@redhat.com>
 <YpcBgY9MMgumEjTL@infradead.org>
 <08625f5f-4781-52c5-46fc-d1250f70626c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08625f5f-4781-52c5-46fc-d1250f70626c@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 01, 2022 at 12:08:57AM -0600, Jens Axboe wrote:
> Yes, that was my point in the previous email - get rid of
> bioset_initialized() and just fixup dm, which is the only user of it.
> There really should be no need to have this kind of conditional checking
> and initialization.

dm and md, but yes, we should not really use this check anywhere.
