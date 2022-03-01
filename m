Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8266C433EF
	for <linux-block@archiver.kernel.org>; Tue,  1 Mar 2022 12:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiCANAJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Mar 2022 08:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiCANAI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 08:00:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042B4574BB
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 04:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=hiLqSin/KTgGp/pVfKA4oNOQBe
        yBIjl8paEb1t/eX0PsQnx7zim2rAivxjfJjFrlMwMRknc7Q/JJnUDEmhHJsaADJhVovcz965ZSAJs
        4u8nrVRnTD/+Bhkk3ETG1zDwCQdFeT3leQEvLWuqDS3XJCase+Pio7j0tSlloJdVxtatwWW2ixUCf
        Ta+RwFhNV8ZLYTHi41YZdWkexWvpTGOK/I/i7/3+eCvBy7nmrSEXN0wDTH6pWgbZ59Bhade+NnTuB
        EIFRB2ij0J/21YAVnk0HQ+3vN9NDVqLSWotbhJi5R5r8Vi5dSq8+FqT1oeNlsoBgRR8VfWZR+Doue
        6XRcwulg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP266-00GgOp-J9; Tue, 01 Mar 2022 12:59:22 +0000
Date:   Tue, 1 Mar 2022 04:59:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk,
        hch@infradead.org, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
Message-ID: <Yh4YqjqV0MasKde4@infradead.org>
References: <20220228065720.100-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228065720.100-1-xieyongji@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
