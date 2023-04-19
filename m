Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BBFC6FD18
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 04:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjDSEKE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 00:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjDSEKD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 00:10:03 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89CD4C1E
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 21:10:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2117B6732D; Wed, 19 Apr 2023 06:09:58 +0200 (CEST)
Date:   Wed, 19 Apr 2023 06:09:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 01/11] block: Simplify
 blk_req_needs_zone_write_lock()
Message-ID: <20230419040957.GA25329@lst.de>
References: <20230418224002.1195163-1-bvanassche@acm.org> <20230418224002.1195163-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418224002.1195163-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
