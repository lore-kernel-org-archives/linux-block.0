Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF4DC433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 07:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiFNHrB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 03:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiFNHrB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 03:47:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57F42E0A2
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 00:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qcfTh1q0ptWWeKaY0xbezJSqcD/hOZ1txOnD4F9/jVQ=; b=BheFFXzuUKd35Am7CRXvdOXu4e
        lgi9z38f0MlWCr0zBMvuWG5GTm1noPOvfe1umjL0hJ4uXBdTuOqQ2/1qMOuTGd0k7AJ2s6Ifn6H4T
        6JbRLLVGWXJzhrv5zCimJGS1JToXMDi+P0V+euxbmMuFBrEW88qaZiJ4137i+MxSsAODMv/xmt7ni
        +tgU7JKfIlrgqYV6TOURu7Ior5O4nlCZuEgItgL7AXD/aaVrHOYlGBKkvntP1hdIYMswFHrKBasF2
        EdULG729n9pSHi56q85eCkAhJsXga+5EYkzup8zo/eo1JIj5h4zYJYYW+VddyiNUX+r8B5NEWNRi2
        nEpNJ9pw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o11GM-008269-0s; Tue, 14 Jun 2022 07:46:58 +0000
Date:   Tue, 14 Jun 2022 00:46:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] block: fix rq_qos leak for bio based queue
Message-ID: <Yqg88bQBxYLdf+8I@infradead.org>
References: <20220614064426.552843-1-ming.lei@redhat.com>
 <Yqg0w2tC6ac39ayJ@infradead.org>
 <Yqg7KqXs38G3i2YY@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqg7KqXs38G3i2YY@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 14, 2022 at 03:39:22PM +0800, Ming Lei wrote:
> Just checked my block mbox and lore, not see the patch sent from
> yesterday.

Hmm, weird.  vger had some odd hickups the last last days, but you
also were Cced personally.  I'll resend it.
