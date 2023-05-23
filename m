Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7525C77B75
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 07:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbjEWHW6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 03:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjEWHW5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 03:22:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97C0109
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 00:22:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 93CF367373; Tue, 23 May 2023 09:22:16 +0200 (CEST)
Date:   Tue, 23 May 2023 09:22:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v3 0/7] Submit zoned writes in order
Message-ID: <20230523072216.GE8758@lst.de>
References: <20230522183845.354920-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522183845.354920-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 22, 2023 at 11:38:35AM -0700, Bart Van Assche wrote:
> - Changed the approach from one requeue list per hctx into preserving one
>   requeue list per request queue.

Can you explain why?  The resulting code looks rather odd to me as we
now reach out to a global list from the per-hctx run_queue helper,
which seems a bit awkware.
