Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBF6C433EF
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 08:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbiBIIWW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 03:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241055AbiBIIWU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 03:22:20 -0500
X-Greylist: delayed 343 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 00:22:24 PST
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39521C05CB85
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 00:22:23 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B3D6568AFE; Wed,  9 Feb 2022 09:16:36 +0100 (CET)
Date:   Wed, 9 Feb 2022 09:16:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH for 5.17] loop: revert "make autoclear operation
 asynchronous"
Message-ID: <20220209081636.GA9996@lst.de>
References: <20220129071500.3566-2-penguin-kernel@I-love.SAKURA.ne.jp> <28d54cac-f235-d041-5171-4efa8a954926@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28d54cac-f235-d041-5171-4efa8a954926@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
