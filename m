Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BD1C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0C8610E7
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhJRJV5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 05:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhJRJV5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 05:21:57 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4256EC06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 02:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5H7W/ZiBLE6yRZTOVBsviHrBoKMoWLgM5COTHlW8/yk=; b=4870u2LTZhpxdJlAL13XUFijBg
        UwAwBOjxnrszh+Jkznfc0lbX1/GpVtDlx/HduC4Bi5tB6I22Ta9sfRHkpb6R/9QwWGifBeK5q3FNJ
        sU7A4nEEC6bNjOf5NtVT28zBNI6Td1+9vGP2UHqUJKNbPyXFjrQ75MVVPD9rezIn7I/g7K7YBc4Wl
        b8kVZ2H0VDt4P9OuX5vmSrwORt9Sl9QVz+8Qvn96ZBXSfx4ppSBpxQT0fMsHEzK2o0VLEYhzXOckn
        kApgY+JQ3c3oJNZU6qrUguSkFp44wyUVskde74BvBhJxx0qH57eCtDyn2RFAsAuFFzsP4tPnQ9ZvD
        8La1xP5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcOo5-00Emie-Ut; Mon, 18 Oct 2021 09:19:45 +0000
Date:   Mon, 18 Oct 2021 02:19:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 09/14] block: only mark bio as tracked if it really is
 tracked
Message-ID: <YW08MT32cS5CSjUW@infradead.org>
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-10-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017013748.76461-10-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 16, 2021 at 07:37:43PM -0600, Jens Axboe wrote:
> We set BIO_TRACKED unconditionally when rq_qos_throttle() is called, even
> though we may not even have an rq_qos handler. Only mark it as TRACKED if
> it really is potentially tracked.
> 
> This saves considerable time for the case where the bio isn't tracked:
> 
>      2.64%     -1.65%  [kernel.vmlinux]  [k] bio_endio
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
