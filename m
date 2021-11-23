Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB3BC433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 18:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhKWSyK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhKWSyK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 13:54:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31B4C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 10:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J8ZpJ7IEUIssWYiGn4JUZV8YSFiAwMHHgkpgEGYWdV8=; b=t3R5VhJtMAm5/4lm7TlzmwwDjY
        fZPl+ydWtMFlJ00ro3dVb7Cw4DY4PSl7bzcneJByzrP9vgDFdrxtbJEVMuZmuT3v8uxHhWCRf4LKu
        qVlad9qc4poEnXBWutMoCjS55RGOpX39JdarQXaAyfQxxDJfLiM8jy93/GdI8K04pskufYCB6K7YT
        EdrdURi2pZ24SH7SS5J7Oton54Ud3wZPknxu0xOt3n3jGuz/eFcdE9r4l2pqRYDV5oxCxepKa16fk
        V3oKwdOAw0QfVq1h2meFHSkvIMT/MYNPDs6LLCPW9oUXZ+urcqpiJuM1/0CcQwlsXiW4em9l8+wj6
        0pRKzEkg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpasf-003F7T-Eq; Tue, 23 Nov 2021 18:51:01 +0000
Date:   Tue, 23 Nov 2021 10:51:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] blk-ioprio: don't set bio priority if not needed
Message-ID: <YZ04FVYwI5NXpV+H@infradead.org>
References: <20211123171058.346084-1-axboe@kernel.dk>
 <20211123171058.346084-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123171058.346084-3-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
