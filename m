Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8E2C38A02
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 09:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiJ3J5f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 05:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJ3J5e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 05:57:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087A4D102;
        Sun, 30 Oct 2022 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Es72KeOaZpA6K+UBk66htKhwB9
        W16d4I0c25YGEypJc1CsX9tlzt8WNYTve1nYKGuq1mt9zPKwtp7hZitNTVY1RNTG0Ls7E9wqHg9S6
        pQgWJcSUlfDCzLAeJQmGYKynuRWeIlTw//Tbtn49qSiHp1zv8GzpQKDwXkkFaC7tJ7jMAn77IhSi/
        MQmbe91y4hDAA9t0kJ87Y99nEe1Bz7S7rlnK50UG0OAfHEi8IcrQNV6wSostj0SI56g1IWW8p6A1P
        NrokoSNKiXYwOvnupCBH+XuzANKDQqGfAryxK+9Zrq3OaNrIWMCW/u3hA7aBa4qA9/+zD8Z3M0xH9
        F4KdFRjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op54M-00F4ld-Ot; Sun, 30 Oct 2022 09:57:30 +0000
Date:   Sun, 30 Oct 2022 02:57:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: move queue_is_mq out of blk_mq_cancel_work_sync
Message-ID: <Y15Kiq+Y5r63RLR3@infradead.org>
References: <20221030094730.1275463-1-nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030094730.1275463-1-nickyc975@zju.edu.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
