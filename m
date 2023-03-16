Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6279C6FD19
	for <linux-block@archiver.kernel.org>; Thu, 16 Mar 2023 15:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjCPPCC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Mar 2023 11:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjCPPCB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Mar 2023 11:02:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E051BAFB9B;
        Thu, 16 Mar 2023 08:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=43atnf0HvvtYQ2NZYS52mr5cQd3U5Rmxej8AA1crrQQ=; b=AxAhp9rHF2fg2nnrsy6Oy064r7
        D+V6tkT21VF0m1mzYGmGT95gCfd3pQMLlgjqAnihoUwQ+CrzimNyugOtLTr5LTgVdcvs/wsKOYpiz
        jIN04ZYc6cDwrgTkU03voXAErhDi99pJVBVuxAhu+6HHjeUaO6az+qLZgxk8G9RlVx9O6mo0FNvGX
        xItbZRRK8fvcOnEUkhdDPvSf3JqoK/0KHY07alg71vQ17u2+eIacHQkHRPkEnvwYxEXgDyyhZZSGu
        q6NwN/JVx2E4P0+zoAqUBgENarsmVmcCJiXJgrj12b55VPoEUT6IrCmQqj8esBOSIHH9bwna5rFGC
        J96vmnwQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcp78-00GlEy-0f;
        Thu, 16 Mar 2023 15:01:58 +0000
Date:   Thu, 16 Mar 2023 08:01:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     linux-block@vger.kernel.org,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] block: ublk: enable zoned storage support
Message-ID: <ZBMvZvYSSsEZzn8L@infradead.org>
References: <20230316145539.300523-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316145539.300523-1-nmi@metaspace.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 16, 2023 at 03:55:38PM +0100, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> Add zoned storage support to ublk: report_zones and operations:
>  - REQ_OP_ZONE_OPEN
>  - REQ_OP_ZONE_CLOSE
>  - REQ_OP_ZONE_FINISH
>  - REQ_OP_ZONE_RESET

Without ZONE_APPEND support this is incomplete and broken.
