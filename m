Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F58DEB64D0
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 13:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbjFMNt3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 09:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239886AbjFMNt2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 09:49:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95FD1B2;
        Tue, 13 Jun 2023 06:49:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 676B768AFE; Tue, 13 Jun 2023 15:49:15 +0200 (CEST)
Date:   Tue, 13 Jun 2023 15:49:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com,
        xiang@kernel.org, casey@schaufler-ca.com
Subject: Re: [PATCH v3 1/2] block: disallow Persistent Reservation on
 partitions
Message-ID: <20230613134915.GA23303@lst.de>
References: <20230613084008.93795-1-jefflexu@linux.alibaba.com> <20230613084008.93795-2-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613084008.93795-2-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 13, 2023 at 04:40:07PM +0800, Jingbo Xu wrote:
> Refuse Persistent Reservation operations on partitions as reservation
> on partitions doesn't make sense.
> 
> Besides, introduce blkdev_pr_allowed() helper, where more policies could
> be placed here later.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
