Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2804C7EE23
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 06:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbjEWGUZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 02:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbjEWGUU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 02:20:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8131E192;
        Mon, 22 May 2023 23:20:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 75CB967373; Tue, 23 May 2023 08:20:03 +0200 (CEST)
Date:   Tue, 23 May 2023 08:20:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     regressions@leemhuis.info, chengming.zhou@linux.dev, hch@lst.de,
        axboe@kernel.dk, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH RESEND] blk-wbt: fix that wbt can't be disabled by
 default
Message-ID: <20230523062002.GA6413@lst.de>
References: <20230522121854.2928880-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522121854.2928880-1-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
