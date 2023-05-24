Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC40C77B7C
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 05:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjEXFxc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 01:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjEXFxb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 01:53:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0677B132
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 22:53:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0484B68CFE; Wed, 24 May 2023 07:53:28 +0200 (CEST)
Date:   Wed, 24 May 2023 07:53:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 4/7] blk-mq: use the I/O scheduler for writes from the
 flush state machine
Message-ID: <20230524055327.GA19543@lst.de>
References: <20230519044050.107790-1-hch@lst.de> <20230519044050.107790-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519044050.107790-5-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I turns out this causes some kind of hang I haven't been able to
debug yet in blktests' hotplug test.   Can you drop this and the
subsequent patches for now?

