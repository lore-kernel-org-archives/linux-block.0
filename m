Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4131C77B7F
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 14:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241651AbjELO7W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 10:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241664AbjELO7S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 10:59:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A033C03;
        Fri, 12 May 2023 07:58:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6392A68AFE; Fri, 12 May 2023 16:58:33 +0200 (CEST)
Date:   Fri, 12 May 2023 16:58:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, lukas.bulwahn@gmail.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH -next v2 5/6] blk-iocost: move
 wbt_enable/disable_default() out of spinlock
Message-ID: <20230512145832.GD5546@lst.de>
References: <20230512093554.911753-1-yukuai1@huaweicloud.com> <20230512093554.911753-6-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512093554.911753-6-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
