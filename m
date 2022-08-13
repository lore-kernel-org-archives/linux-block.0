Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD27C25B08
	for <linux-block@archiver.kernel.org>; Sat, 13 Aug 2022 06:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiHMGor (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Aug 2022 02:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMGoq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Aug 2022 02:44:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705C51031
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 23:44:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0EC3268AA6; Sat, 13 Aug 2022 08:44:42 +0200 (CEST)
Date:   Sat, 13 Aug 2022 08:44:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 0/6] Make blk_mq_map_queues() return void
Message-ID: <20220813064441.GA10835@lst.de>
References: <20220812210800.2253972-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812210800.2253972-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> The only block driver for which the .map_queues() callback can fail is null_blk. Since

Please fix your mailer to avoid overly long lines.

Otherwise the changes themselves look fine, but I think it would be
way easier to review as a single patch that changes both the method
signature and the common helpers.
