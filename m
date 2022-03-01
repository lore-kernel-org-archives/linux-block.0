Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7281FC433F5
	for <linux-block@archiver.kernel.org>; Tue,  1 Mar 2022 13:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiCANau (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Mar 2022 08:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiCANat (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 08:30:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8898A6C2
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 05:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=dA6SG2c4ukofm4O8gGY+AmSGCJ
        /pM0pTcefDLCJcpIaqN+ozKkztYhynr5tdW7qp/SI9O6rxvHH6f22+/x4oS6u2uWmteEoXJJ2rxXG
        QehYCpubsKqlDQcwOtPhgFeN6g3OuK5JB29QhASlYqaehKTOl4HbkrODlcZOaEPPY3oltIBJvO8lN
        6an9asdyM7LiDj1rdxHLYuC6syrW9TfHd+3qhDP//ViPG8oe7mlTic2qUwXMpLF/koMWDrCMwRUTl
        kRbw/ika54lfGYYTVcNnossNE/QMSWx+3M/yzNs58JJCdB8HQeUgLjH55Rzhcb2u0r/86vFXbcjkj
        vpjo4jgQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP2Zq-00GugW-QZ; Tue, 01 Mar 2022 13:30:06 +0000
Date:   Tue, 1 Mar 2022 05:30:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 1/6] blk-mq: figure out correct numa node for hw queue
Message-ID: <Yh4f3tIXRSsCs2Op@infradead.org>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
 <20220228090430.1064267-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228090430.1064267-2-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
