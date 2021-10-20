Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EE5C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A346113D
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhJTGcN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 02:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJTGcM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 02:32:12 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18D8C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 23:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tkm8kBVz6lbP+ryJqIeypUwYWUnl5NMxevSBkRvliIk=; b=l/+Rxg1oxRcSNPH0oJRM5ng4t2
        PMwhDsZF+vAA/Q9yQR6pBg4kV0j1XPUYVKzGUOh/KtG+GkJrKg6j+XaIeywqhY5tqnP9a6ZWEONMV
        ldLNqbhS0Vt1pD6bkKqnlR7tD2Hhg15Lw9pNhC9iqMhdX60orxLuBeU3klLF9wb2ZGIV8alsrqona
        bXNPEx/rv0MWXwYyeV9inK3I7Awlmz8cqmau3WkX6ezK7BqXN3dvgmx0SonAr3yRtW34pQtsQNBzu
        PK5MOumDk7yBVM9oEF8GYdNCWs+yvW0Db0mvDvYBgw1W9P1Fy1OT4Pm0IvOokiEjRH+nU89E/Bllx
        JP/9YFcQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md56s-003Toe-LU; Wed, 20 Oct 2021 06:29:58 +0000
Date:   Tue, 19 Oct 2021 23:29:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 09/16] block: optimise boundary blkdev_read_iter's checks
Message-ID: <YW+3ZjJX6I8HaLBA@infradead.org>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <d8660b783e2237063a00f671afcf17a30c2e2c76.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8660b783e2237063a00f671afcf17a30c2e2c76.1634676157.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 10:24:18PM +0100, Pavel Begunkov wrote:
> Combine pos and len checks and mark unlikely. Also, don't reexpand if
> it's not truncated.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
