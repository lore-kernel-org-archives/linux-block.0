Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B00FC32772
	for <linux-block@archiver.kernel.org>; Tue, 23 Aug 2022 18:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbiHWSXP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Aug 2022 14:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbiHWSWt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Aug 2022 14:22:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA46B107AEB
        for <linux-block@vger.kernel.org>; Tue, 23 Aug 2022 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=a3csCWHK6ENaDU5p6SJmoOCGY7
        dpd17+r1W0s07BUX9TEXJmUMVyqz2u44QG7rS4BLHmEwjvftOCavjr9pm6sVB/ulUxERm17z4Dr5e
        o1I56dsInio7JpDWUs/HtOd0n0lp9h+FuhuWE6HuCsMfPrZo030FkS0dlMozejNDU4w63ocO4aSAA
        Fgq40pxDwBXuqX8/2XGetdZAFeLT/b6AJRbkFYatYFzCKjMsSi1bkJ6wOQzg86DE6getEBIgvCER6
        xGDQ6EdNukgHgIs6T8dH9NFP2fJJstCyZbpC6EjXnHpK9JfraVo0Qe034yzDstZKN76T+HY92EHRX
        jnIxsxxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQWw7-007M4a-OH; Tue, 23 Aug 2022 16:39:31 +0000
Date:   Tue, 23 Aug 2022 09:39:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, acourbot@chromium.org,
        linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()
Message-ID: <YwUCwxSiu1ktU2NI@infradead.org>
References: <20220823145005.26356-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823145005.26356-1-suwan.kim027@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
