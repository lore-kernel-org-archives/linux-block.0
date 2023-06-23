Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A8DEB64D7
	for <linux-block@archiver.kernel.org>; Fri, 23 Jun 2023 05:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjFWFpV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jun 2023 01:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjFWFpT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jun 2023 01:45:19 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C951BF7
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 22:45:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AFE2767373; Fri, 23 Jun 2023 07:45:16 +0200 (CEST)
Date:   Fri, 23 Jun 2023 07:45:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v4 2/7] block: Simplify blk_mq_requeue_work()
Message-ID: <20230623054516.GC9085@lst.de>
References: <20230621201237.796902-1-bvanassche@acm.org> <20230621201237.796902-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621201237.796902-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 21, 2023 at 01:12:29PM -0700, Bart Van Assche wrote:
> Move common code in front of the if-statement.

This mechanical change looks ok to me, it's more the existing
ad prevailing logic here I'm worried about..

Reviewed-by: Christoph Hellwig <hch@lst.de>

