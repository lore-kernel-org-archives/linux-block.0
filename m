Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3856CC43334
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 06:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiFXGHF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 02:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFXGHE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 02:07:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D5E45796
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 23:07:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 534E568AFE; Fri, 24 Jun 2022 08:07:00 +0200 (CEST)
Date:   Fri, 24 Jun 2022 08:06:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2 6/6] block/null_blk: Add support for pipelining
 zoned writes
Message-ID: <20220624060659.GA6494@lst.de>
References: <20220623232603.3751912-1-bvanassche@acm.org> <20220623232603.3751912-7-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623232603.3751912-7-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I don't think adding all the previous code just for null_blk is a good
idea.  We need a real user of it first.
