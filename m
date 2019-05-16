Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F916C04AB4
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 07:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A68720862
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 07:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E6P/lvqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfEPHCu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 03:02:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfEPHCu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 03:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nQZsfZEsNmAUcrc4kgNa2FS1L0xALpWun6k0vKcPCwk=; b=E6P/lvqMzZOH3GIaVt48mvWhz
        RHcRdWaIC0sYWQ8Nrnx7BzjAqzKCO5VmPC75DYkf6+B3OmbKR9KTg5051B6XCEzxYY0D+evkYecsY
        AdBust7UkpdWRhRlWfnmSzG7Pz8GfbvoOAVA8FHJAxFAbC5jWq6XS39wyiHvlvr7h9xP1tAiW3xCR
        6KTVqggVhxETALiSkkfZmOGbQwNkaC1sZk0OBop/voRT/tBxS1VrlS4v0T4vjBMNiucJAbXJ94VTV
        62QMdfyCQDoe8fXxW+QVIO+tbeadoD+Y8Nqb2fnJTZ2p2uNX4KULQlgX3jVQkBdFHt6UXcPXD7uRh
        ShFv5r78A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRAPf-00062D-Qw; Thu, 16 May 2019 07:02:47 +0000
Date:   Thu, 16 May 2019 00:02:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        hare@suse.de
Subject: Re: [PATCH] block: Don't revalidate bdev of hidden gendisk
Message-ID: <20190516070247.GA22264@infradead.org>
References: <20190515065740.12397-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515065740.12397-1-jack@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 15, 2019 at 08:57:40AM +0200, Jan Kara wrote:
> When hidden gendisk is revalidated, there's no point in revalidating
> associated block device as there's none. We would thus just create new
> bdev inode, report "detected capacity change from 0 to XXX" message and
> evict the bdev inode again. Avoid this pointless dance and confusing
> message in the kernel log.

Personally I'd do an early return instead of the indent, but
functionally this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
