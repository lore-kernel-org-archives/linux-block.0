Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C02EC433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 08:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiBVIai (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 03:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiBVIah (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 03:30:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C78E15878D;
        Tue, 22 Feb 2022 00:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=UxlK9A6NaJ2aUZOvAvZijjanZ7
        k4GRS+FP9n+hrsl0/gHy2RnH1MP4q/NKh8VejoX9LCENF0Oa6ez77y+lnlh2MQzgKs3PfBDu9zwQE
        /jyNKnlbG7cLitCvHCROl/SLOe2UupFM+5AYo1uU07DiWlmnwEMqlC/yvGtmjQ0lP0CzyWP1GSMix
        y8KtWuYfWgfcVJYdJbspHVOZO/T2UqpBqwsx1GiXrIcUwBErCp+O8YQ0YSDSo/u5CerKr4WGlGoof
        qJ4yklGvhJjlQ/R0u+ndI3TwCnVp0JNIeVzL527dc5Lhgnw6cZVUgwq/ccLDYlFwT5LAJ5By67v05
        fs2gpaAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMQYj-008X7e-Mg; Tue, 22 Feb 2022 08:30:09 +0000
Date:   Tue, 22 Feb 2022 00:30:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Zhang Wensheng <zhangwensheng5@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] block: update io_ticks when io hang
Message-ID: <YhSfEVATPe6fsKOR@infradead.org>
References: <20220217064247.4041435-1-zhangwensheng5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217064247.4041435-1-zhangwensheng5@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
