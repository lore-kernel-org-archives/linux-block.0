Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0399FC4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 15:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiJRPoH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 11:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiJRPoC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 11:44:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181B4BE2DF;
        Tue, 18 Oct 2022 08:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XmnQmv97M3C7SnzmjTn+cHZwGmf7phEiTs4Cl0P4PuE=; b=YuZbX5MWv2c7M3VzTtfJk0Ebwq
        UJXLYB3JP0ksjcF2limcGQvmDRKZDrQffpHgmwb3tyI5YBexZbWjLjZm7gidJ39MpU/hnLQfnvBra
        KgShFtpfv7ceOzUg+mp7a5Z+ixCcfm9ZIj3JI05kDGgvvKP2i79+YpKtfBsEINM5ebeyllwm3ocIv
        aLoevQQSgxsNRSI5S/1zEGl2I/jh7sFOv8w4w+6y0DflOg7Napc9qJkz6GOx72Rim90uPpAFg3k2w
        Vq/70sKb4nhwDEVrtxzbVxy0ikggoXZL7JcHZLlDpQNO8bRfalRCBVfl7oQxK46JTO8gAzdgW8cZU
        xp2Tl3Uw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okokv-007sDT-4Q; Tue, 18 Oct 2022 15:43:49 +0000
Date:   Tue, 18 Oct 2022 08:43:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, hch@infradead.org, ebiggers@kernel.org,
        paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH v4 2/6] blk-wbt: remove unnecessary check in
 wbt_enable_default()
Message-ID: <Y07JtR8EvApkrRM9@infradead.org>
References: <20220930031906.4164306-1-yukuai1@huaweicloud.com>
 <20220930031906.4164306-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930031906.4164306-3-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 30, 2022 at 11:19:02AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> If CONFIG_BLK_WBT_MQ is disabled, wbt_init() won't do anything.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
