Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C59DC7EE29
	for <linux-block@archiver.kernel.org>; Wed,  7 Jun 2023 05:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjFGFdv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jun 2023 01:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbjFGFdn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jun 2023 01:33:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AE119B1;
        Tue,  6 Jun 2023 22:33:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D9AE368B05; Wed,  7 Jun 2023 07:33:38 +0200 (CEST)
Date:   Wed, 7 Jun 2023 07:33:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next] blk-ioc: fix recursive spin_lock/unlock_irq() in
 ioc_clear_queue()
Message-ID: <20230607053338.GB20390@lst.de>
References: <20230606011438.3743440-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606011438.3743440-1-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
