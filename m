Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBD6C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 08:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D8D60F9E
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 08:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhJRIpa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 04:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhJRIp3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 04:45:29 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D25AC06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 01:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=Cm3gUEG+LsJr9cKWdDVDmTHFjE
        +UsvXQsjpkdQXW7kksng0Xzs0SVE/D0JEAvnI9/aiANNdm+XWD+4qbDo+V0zxMEmIXkghRbM5J1g4
        Yhv/QeH72yjYm/3H1nxlaqtTZmg9+/XfUiDT1Z2irmvscPZBToNrHps7VwoEtNI9YvlN8V6qwSOZw
        tHPL83lXBDpyAF3FeAvXvrIo3vvFH1/BfE1Ngb+47RgQnp+TYjrcopzj44C0Pzw+WaZRq101ZOf+r
        goNb2IaB8QyE94+YCqR+EoA8qj9Y5Qyiw25keaj7N/E0zwXcqBVMyRKa2cteYGWixrxgbYunzrUwI
        usQSrybA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcOEn-00EgML-8Z; Mon, 18 Oct 2021 08:43:17 +0000
Date:   Mon, 18 Oct 2021 01:43:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 04/14] block: move update request helpers into blk-mq.c
Message-ID: <YW0zpXOPY+dESGrt@infradead.org>
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017013748.76461-5-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
