Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834CEC433FE
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 15:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiJRPvQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 11:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJRPu7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 11:50:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FEE27DF7;
        Tue, 18 Oct 2022 08:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=tux+L/E0jkd+uNgceQ0B0yk+15
        nqJgyhn0PcEXYub8RFYxr4wLDdEoBvWPUXnhTbob4TCb8rUz+nlaPyfi1mvH01kYEve4QhJz19++O
        jPJ66yCJz2BPG05FIZG2X6qDPIkbwnzXXobERZL1KSP/Jrg+w0eq1slkD48O7cam4z3g/ux1b1S36
        xJQEpeaHw3uxMhLceQnIn+aNLlutPCIalGG3tfzdwQ/4+MgRJSKY6I6KBfpRGZugZKHn5N330d/dx
        OMA3TozUOr3YfY4tT3am6HDSr2I2c/Xy8hRaccoXJ4zitybKI3xQ6clAeJOkBxGgdEMcMx3X26L5A
        AAj68xOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okor0-007yBu-Hs; Tue, 18 Oct 2022 15:50:06 +0000
Date:   Tue, 18 Oct 2022 08:50:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, hch@infradead.org, ebiggers@kernel.org,
        paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH v4 6/6] blk-wbt: don't enable throttling if default
 elevator is bfq
Message-ID: <Y07LLrWPZe4C8TZC@infradead.org>
References: <20220930031906.4164306-1-yukuai1@huaweicloud.com>
 <20220930031906.4164306-7-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930031906.4164306-7-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
