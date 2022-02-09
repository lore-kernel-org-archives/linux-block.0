Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92D3C433F5
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 14:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiBIOC0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 09:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiBIOC0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 09:02:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77E4C05CB88
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 06:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VFqaSxDI6tF9A7LlxYVS7skt8YIrwxkdBL6OquFvKJk=; b=yI8OeNSSf03opaqgEMdWgccl22
        Vecle5m64nWrpPzFkKsmEV3/rIqbZydTDDMILEHTdCRRTcz2VLjr6kKWZQXqUXU56mzWESG66rUN1
        oaNz/0qU3KFP4umUvfOEQ2+wh9YNQxyfqx25rxe45Z/OlCis1KgFX+tdaNebD433eLP9oUBNgCa5I
        tHtVN2koOMVtaY6P01iM50AGJuzsDhz+/Arlhij+6Gz2Yk8DnrojmV9oNuF2n64mc181L/zTk+SYB
        WjteUzmImZXGajkuH9m/yuQ1+pVV+25xwFU0YmX7766lJj4ljtLms3KBV23Egxk9zAsR6hh4Ih7qu
        dX1o4vRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHnY2-000Hnj-Oe; Wed, 09 Feb 2022 14:02:18 +0000
Date:   Wed, 9 Feb 2022 06:02:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Li Ning <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH V2 2/7] block: move blk_crypto_bio_prep() out of blk-mq.c
Message-ID: <YgPJaqTkonBQmOIA@infradead.org>
References: <20220209091429.1929728-1-ming.lei@redhat.com>
 <20220209091429.1929728-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209091429.1929728-3-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  	if (blk_crypto_bio_prep(&bio)) {

I'd just do an early return if tis fails, but otherwise it looks fine
to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
