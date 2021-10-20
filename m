Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D1AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F356115A
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhJTGbm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 02:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhJTGbl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 02:31:41 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDD3C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 23:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L4dPkIdZv0R+mNBIP//u28DXGMtSKUIpwqnxOF/igA8=; b=Pf3hPYwmesPuR0mBHX3Xoqm/Vq
        hMGDiuS/MxvV0xLpIgHq8ldT/b/NZ0IeAmgZmrJUFXob7gENiTMssXYsKpXaIYx9qu65McGNXJo6Q
        JzU2aG0MNdfgo3VAEZrTWSdBm4Cnz3hbOzsD2aFwvgAbZbsIdrHP+gPRNu/P/TpB7ME6p+ahScvxm
        2+msgJ5ID9vAsxQg1FS4lMWgGf7uNKfZaKc3Zd+6ZYSRcLniAtClW2Ra5SRLhyQdRzXh97VhuTTNz
        erQ6CcqsVwBw0d8ldWV5nh43pfAsfMqEt3LddUdVdVdMl5Qj6ntw2Ru1QxOx1ryDHnwM7rWWGYnpY
        BJSThQAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md56N-003Tmo-5B; Wed, 20 Oct 2021 06:29:27 +0000
Date:   Tue, 19 Oct 2021 23:29:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 08/16] block: optimise blk_flush_plug_list
Message-ID: <YW+3Rx5Rv/hIgvhU@infradead.org>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <a9127996b15a859a0041245b4a9507f97f155f7f.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9127996b15a859a0041245b4a9507f97f155f7f.1634676157.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 10:24:17PM +0100, Pavel Begunkov wrote:
> First, don't init a callback list if there are no plug callbacks. Also,
> replace internals of the function with do-while.

So the check to not call into the callback code when there are none,
which is the usual case, totally makes sense.  But what is the point of
the rest?
