Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CA3C433EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B23461216
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhKDSiE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbhKDSiC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 14:38:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C916C061203
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 11:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=1l2im3iO2V3aLTfzGYAveJF0nk
        bxjrWM7K3j9mtt4LB/Ga/mUxI2KznMe4JzQXLG3t39Hp/KuLNtysfz4uMkP42it48+2aBESNyV7FO
        mzWrX9JrHaemZ6Gz0jmwhHrmWs3++uZfhQcd/XP5GFZ8934fb8YbbSQD7Ym58xl/3k+t3q/SEcy/f
        rocuDFImebqJJWCv9EE8/bcJcsEudaB6v8fNGISya3PCaCvbvSLmaVhuUSsbpqvWkQ3Tb1P/oH7TT
        39pkM4sxFsijmnhLVHP8GEc5e2ceSpVj1mOYTM1DmeSPDPNjD905bim4IMS8ooxdBCZjaYC1Myo2Z
        VZKlzAGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miha7-009new-Mf; Thu, 04 Nov 2021 18:35:23 +0000
Date:   Thu, 4 Nov 2021 11:35:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 2/5] block: split request allocation components into
 helpers
Message-ID: <YYQn65SD/CPt++gy@infradead.org>
References: <20211104182201.83906-1-axboe@kernel.dk>
 <20211104182201.83906-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104182201.83906-3-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
