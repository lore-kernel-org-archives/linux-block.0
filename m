Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0E9C433FE
	for <linux-block@archiver.kernel.org>; Tue, 22 Nov 2022 11:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbiKVLz6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Nov 2022 06:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbiKVLzz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 06:55:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E27827B23
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 03:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=tlV+4Mlft9M4nt3vVsL0IEuuy3
        JIFqYYBnPhv7iX5z29dAtuTRGBIidXwvhYtLG7lU94rGwbad3GNrpV/HPIq7o4FxwwgCdu3O9uSub
        pPA5AJ4eqt2SSvGN0BVM1NG04eQeEgVr+6Gkkf/zPjlQRvSQ4Z6Ba6N4px716IlOkr8zkPigXpe+y
        sF50KdjhsobkuGz3ypMbIbvFH9K7ybMKJ1y6ojIHT9vlrevVEhFDE376Pf+a2fzD10bg4J/43ehxo
        CEzE91ZJptDnpN2UkOgzX09MyF3u5kGp7aZmRIXGiqgMQPiR+r51W4ja60Og/LYavt+icCzAnRZdi
        Yc1YLydw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxRsX-008eLI-Oa; Tue, 22 Nov 2022 11:55:53 +0000
Date:   Tue, 22 Nov 2022 03:55:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH for-next] block: fix missing nr_hw_queues update in
 blk_mq_realloc_tag_set_tags
Message-ID: <Y3y4ybNDEeN47SUJ@infradead.org>
References: <20221122084917.2034220-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122084917.2034220-1-shinichiro.kawasaki@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
