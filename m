Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA038C77B7C
	for <linux-block@archiver.kernel.org>; Thu, 11 May 2023 15:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbjEKPUI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 May 2023 11:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbjEKPUF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2023 11:20:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081B7272D;
        Thu, 11 May 2023 08:19:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6C96668D08; Thu, 11 May 2023 17:19:51 +0200 (CEST)
Date:   Thu, 11 May 2023 17:19:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next 2/6] blk-wbt: don't create wbt sysfs entry if
 CONFIG_BLK_WBT is disabled
Message-ID: <20230511151951.GB7880@lst.de>
References: <20230511014509.679482-1-yukuai1@huaweicloud.com> <20230511014509.679482-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511014509.679482-3-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
