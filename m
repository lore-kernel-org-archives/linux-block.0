Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3269EC433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 06:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiF2Gub (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 02:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiF2Gua (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 02:50:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AB22E680;
        Tue, 28 Jun 2022 23:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=YdGPIQkduWv/JBKsL1SsxsWv0Q
        YW6jDV43A3bxv8AGLRGBp5cOd6vLrv//X7bqWYuq3E9xfVRryqjp5AGMM174TD/eo5ZctV4bHX7BN
        Mzh5p2EU49aiR1VoeWUSxKeJjLcvCExlfROP2U8KgyBndxLE9BiUytWe7u/w2abyi7bkbn4Eh9j9A
        i2xA5wv1TegBSdbGiqfRjt9iN+xdQD8/XR46oKx0tkzmUMouSml1jXle4/E3ydPwVkMGOiuirL3Q+
        PSL2yIYJZ5nJtLguKIo/UpbUz05sI3tCvMZF3XCWfm43I3/ranfI9CwFgtr76exLJtvRbGVTMBTuD
        PSOfTSHQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6RWu-009tdl-79; Wed, 29 Jun 2022 06:50:28 +0000
Date:   Tue, 28 Jun 2022 23:50:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     sunying@nj.iscas.ac.cn
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: remove "select BLK_RQ_IO_DATA_LEN" from
 BLK_CGROUP_IOCOST dependency
Message-ID: <Yrv2NMWDb0A8w9BP@infradead.org>
References: <20220629062409.19458-1-sunying@nj.iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629062409.19458-1-sunying@nj.iscas.ac.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
