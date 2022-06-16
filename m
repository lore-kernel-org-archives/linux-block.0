Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC381C433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 06:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358915AbiFPGSD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 02:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359091AbiFPGSB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 02:18:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2891624F24
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 23:18:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3B2F868AA6; Thu, 16 Jun 2022 08:17:57 +0200 (CEST)
Date:   Thu, 16 Jun 2022 08:17:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 3/3] block: Make blk_mq_get_sq_hctx() select the
 proper hardware queue type
Message-ID: <20220616061756.GA5184@lst.de>
References: <20220615225549.1054905-1-bvanassche@acm.org> <20220615225549.1054905-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615225549.1054905-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
