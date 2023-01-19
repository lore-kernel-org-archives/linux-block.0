Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216DAC004D4
	for <linux-block@archiver.kernel.org>; Thu, 19 Jan 2023 16:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjASQlm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Jan 2023 11:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjASQlk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Jan 2023 11:41:40 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BA95B5B2;
        Thu, 19 Jan 2023 08:41:34 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 951C868D0D; Thu, 19 Jan 2023 17:41:30 +0100 (CET)
Date:   Thu, 19 Jan 2023 17:41:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     tj@kernel.org, hch@lst.de, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next v3 1/3] blk-cgroup: dropping parent refcount
 after pd_free_fn() is done
Message-ID: <20230119164130.GA3332@lst.de>
References: <20230119110350.2287325-1-yukuai1@huaweicloud.com> <20230119110350.2287325-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119110350.2287325-2-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
