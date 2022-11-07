Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17998C4332F
	for <linux-block@archiver.kernel.org>; Mon,  7 Nov 2022 05:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiKGF4i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 00:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiKGF4h (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 00:56:37 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B73BCAF;
        Sun,  6 Nov 2022 21:56:36 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1441468BFE; Mon,  7 Nov 2022 06:56:33 +0100 (CET)
Date:   Mon, 7 Nov 2022 06:56:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v2 4/5] blk-iocost: fix sleeping in atomic context
 warnning
Message-ID: <20221107055633.GG28873@lst.de>
References: <20221104023938.2346986-1-yukuai1@huaweicloud.com> <20221104023938.2346986-5-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104023938.2346986-5-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
