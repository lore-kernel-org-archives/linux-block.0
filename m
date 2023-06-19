Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522A2EB64D9
	for <linux-block@archiver.kernel.org>; Mon, 19 Jun 2023 04:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjFSE7a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jun 2023 00:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFSE73 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2023 00:59:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB9FE49;
        Sun, 18 Jun 2023 21:59:28 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1F13F6732A; Mon, 19 Jun 2023 06:59:24 +0200 (CEST)
Date:   Mon, 19 Jun 2023 06:59:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, brauner@kernel.org, dsterba@suse.com,
        hare@suse.de, jinpu.wang@ionos.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next v2] block: fix wrong mode for blkdev_get_by_dev()
 from disk_scan_partitions()
Message-ID: <20230619045923.GA10741@lst.de>
References: <20230618140402.7556-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230618140402.7556-1-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
