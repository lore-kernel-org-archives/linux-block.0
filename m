Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6137AC04A94
	for <linux-block@archiver.kernel.org>; Mon, 31 Jul 2023 06:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjGaGUb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jul 2023 02:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGaGUa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 02:20:30 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99D4B0;
        Sun, 30 Jul 2023 23:20:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C887D67373; Mon, 31 Jul 2023 08:20:26 +0200 (CEST)
Date:   Mon, 31 Jul 2023 08:20:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: Re: [PATCH v2 4/4] blk-flush: don't need to end rq twice for non
 postflush
Message-ID: <20230731062026.GD30409@lst.de>
References: <20230725130102.3030032-1-chengming.zhou@linux.dev> <20230725130102.3030032-5-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725130102.3030032-5-chengming.zhou@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

