Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4568C38A02
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 09:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJ3Jkd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 05:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3Jkc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 05:40:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B09BE6;
        Sun, 30 Oct 2022 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=dw8Bcab+STkBnrLeOp10Rwn1tH
        v89M0oZzyJgeAXhvmw+L6/WbN/cxniF6Q9NeCi2/aiqwFlbZBjScEMTx4a+1hlf+pgKGuWRCer8CD
        0vYnNUWkbfLp2v9s3wMzEf8IFWTwysJHE/qcffWZB8s0CPFSwj3E/s/Ca2+T5RxCLNUKsiiQXu3zW
        kpKCNfW87R4tcajAOUbd1VCsoZeDxI6K/ADOf0L434OpxYrOMjT+xxeeFIfyOgaxmTWfzfxneqnbF
        2Y+hDf/dOGn4ACgBka7QHbLrz+pO1u5mL6PTPorlf+uRG+Pqi/rZYJAzj9WPouiIoqGrjBx+w4FYF
        Ssl4Uzyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op4ne-00EuiV-Em; Sun, 30 Oct 2022 09:40:14 +0000
Date:   Sun, 30 Oct 2022 02:40:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 1/5] blk-iocost: cleanup ioc_qos_write() and
 ioc_cost_model_write()
Message-ID: <Y15GfkfPNF7koVIa@infradead.org>
References: <20221028101056.1971715-1-yukuai1@huaweicloud.com>
 <20221028101056.1971715-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028101056.1971715-2-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
