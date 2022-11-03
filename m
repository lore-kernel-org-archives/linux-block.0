Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691C7C433FE
	for <linux-block@archiver.kernel.org>; Thu,  3 Nov 2022 09:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiKCJ5J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Nov 2022 05:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKCJ5I (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Nov 2022 05:57:08 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4A89596;
        Thu,  3 Nov 2022 02:57:07 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4CC2268AA6; Thu,  3 Nov 2022 10:57:03 +0100 (CET)
Date:   Thu, 3 Nov 2022 10:57:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 2/2] block: fix use after free for bd_holder_dir
Message-ID: <20221103095702.GA11154@lst.de>
References: <20221103025541.1875809-1-yukuai1@huaweicloud.com> <20221103025541.1875809-3-yukuai1@huaweicloud.com> <20221103081211.GB3346@lst.de> <d4b7c2c7-7da5-9814-e934-174cb8cd5740@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b7c2c7-7da5-9814-e934-174cb8cd5740@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 03, 2022 at 05:45:25PM +0800, Yu Kuai wrote:
> This lock is different from current 'out_unlock', add a new lable will
> make the code more complex, I think.

Of course, same mistake as last time..
