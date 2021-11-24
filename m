Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047EEC433FE
	for <linux-block@archiver.kernel.org>; Wed, 24 Nov 2021 07:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhKXHpz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Nov 2021 02:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhKXHpy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Nov 2021 02:45:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCFFC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 23:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=kP3KCBER8VCWSV+5qxAOpohbwr
        PdLJCgq5nJeAZimspqF7UK6APqW/x8ruci1+6AwwfP1k2Kr52rWmkm2jydLPNrVwsamoQQmB+lb2W
        BzgkHsYiPNaJEGlANaKpSTFESvqT3Y32CDXx7nlpREut1SdYB+daoDAdzyWtgdS5Yjvw+vfQv3bG8
        g8VBGAFecAukFDuMhLibJkFnbUGACtrLbgLfTTFSSrMxdUboH8HwFV9b484yiziLWAb/YLVXJJqTM
        zlNI6Z8igMh7yNMo5jEdW1kHhRiss8kxDnwQ4usNZ0l8gr5lbaIHVkBQ/PRCKSWrictQY3y+yuof4
        0Kz2xgvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpmvV-0049KS-2s; Wed, 24 Nov 2021 07:42:45 +0000
Date:   Tue, 23 Nov 2021 23:42:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: only allocate poll_stats if there's a user of
 them
Message-ID: <YZ3s9ZGG3cLB08LM@infradead.org>
References: <20211123191518.413917-1-axboe@kernel.dk>
 <20211123191518.413917-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123191518.413917-2-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
