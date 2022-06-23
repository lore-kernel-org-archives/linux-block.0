Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8F4C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 13:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiFWN70 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 09:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiFWN7Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 09:59:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CED3B031
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 06:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Jp/fsCKZpC8wW8NC5FKXZPAimok6MNYW8Ej9Rk0TjE=; b=phtI0Kg5MNwNPeT08sXbYtxyrf
        cZ4PHOk5JBBkNAz5e07kKXsljpICsaHEVnpozRqjp0XwelQpWKX4CBbknsQxqoxlClaXUeWVazQAh
        x5MVoYnFT2fk5orWIrl7KYZLZE8/MUtmyxWtEH8zGH42uCTqcRcFnK6mqJt0A87VR/bulYWyfZdpo
        I1MFPgztBekZW/vTcL/5GwLLR5r5PznylTKxjXGkfuGPF09PADGxyasuVOp9wgP42uQx/Kj8c71oJ
        e3LZLhE9Y5XsS2T+YK5LQMeRlFZtChWN37MoNy9fKHaASt674w7sgnf0ED4ZeyPtMQWvlFKmfNArX
        tczWShug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4NMh-00FRma-TN; Thu, 23 Jun 2022 13:59:23 +0000
Date:   Thu, 23 Jun 2022 06:59:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH 3/9] block: Generalize get_current_ioprio() for any task
Message-ID: <YrRxu+UiUCT9OABb@infradead.org>
References: <20220623074450.30550-1-jack@suse.cz>
 <20220623074840.5960-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623074840.5960-3-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 23, 2022 at 09:48:28AM +0200, Jan Kara wrote:
> get_current_ioprio() operates only on current task. We will need the
> same functionality for other tasks as well. Generalize
> get_current_ioprio() for that and also move the bulk out of the header
> file because it is large enough.

We don't really need the general version exported.  But if you
prefer an inline wrapper over a tail call I guess this is fine, too:

Reviewed-by: Christoph Hellwig <hch@lst.de>

