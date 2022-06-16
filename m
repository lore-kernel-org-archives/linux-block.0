Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B67C433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 06:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358985AbiFPGSy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 02:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358690AbiFPGSx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 02:18:53 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B2B522C6
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 23:18:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4B9A468AA6; Thu, 16 Jun 2022 08:18:50 +0200 (CEST)
Date:   Thu, 16 Jun 2022 08:18:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] block: Fix handling of offline queues in
 blk_mq_alloc_request_hctx()
Message-ID: <20220616061850.GA5247@lst.de>
References: <20220615210004.1031820-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615210004.1031820-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
