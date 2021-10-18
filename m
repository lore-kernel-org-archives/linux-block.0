Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC15C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 15:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 072C760F94
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 15:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhJRPQg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 11:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbhJRPQf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 11:16:35 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902D9C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 08:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ryypfXrLRJUDK+kEqG81b5z1GwPkHoKG5hns0/ngR68=; b=q4tZlQsgIy3JwMLmap1TxcshNZ
        VKSAgJYLBmeB2wRbApmCs8RI+/SfZwo9KdCs69IK5AB3JTZMQI96Y54wtBBArMnfv75NQAc20MzF4
        E9TfzIGJaHoXdmP6FThoE1tOBg4le5dkmfIZnRXWGNVVBmqrxuSk0g4cgMiC3pPBc+D5iZ8X97OI7
        aDDz67RBscMK64MHEzoqOlBEO3CA5sOQb4NcEClDnXgRWFFUKkWGnScaBa0IuLkERbceFszfNkoQ1
        9N4mARFzfeEAV68Wjob6nXFiuT58swaFzYheYJE/tFaawrxHLJwVIyF9mrnhxDNY9dZOCz4014lcf
        pUgqvGDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcULI-00GFwM-45; Mon, 18 Oct 2021 15:14:24 +0000
Date:   Mon, 18 Oct 2021 08:14:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 6/6] nvme: wire up completion batching for the IRQ path
Message-ID: <YW2PULGTYHdb/PoP@infradead.org>
References: <20211017020623.77815-1-axboe@kernel.dk>
 <20211017020623.77815-7-axboe@kernel.dk>
 <YW1K7RR2F+dL9ntI@infradead.org>
 <458fdc6d-e006-48fb-b66c-c4c2b631b236@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458fdc6d-e006-48fb-b66c-c4c2b631b236@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 18, 2021 at 07:41:30AM -0600, Jens Axboe wrote:
> > Ok, here the splitt makes sense.  That being said I'd rather only add
> > what is nvme_poll_cq as a separate function here, and I'd probably
> > name it __nvme_process_cq as the poll name could create some confusion.
> 
> Sure, I can shuffle that around. Can I add your reviewed/acked by with
> that for those two, or do you want the series resent?

I'm fine with that change included:

Reviewed-by: Christoph Hellwig <hch@lst.de>
