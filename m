Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6627C77B7C
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 23:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240335AbjELXMr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 19:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjELXMq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 19:12:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAC36E89
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 16:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ezqr9ZX/mRDjad2FRY6X9UMK7dDWGJ3GH+5lpQhXHyc=; b=jA+P+R4xDAIygPYFSdCH8c4uHz
        EJs9PpMbzD8tm2aCb8XCRg9wzEvaf702ktlmDphRk27l8Aj2G7eXHyd5ReRUUSyUwaErMfXRRBqxG
        ywOwWOdF8PLqO3HQV52u5MoWlEdYBDqTxr34Mq2xTXL4YTf6EXUklkcTBkvO6/J31eLS1UGno5EHg
        vhQpFtm5AiBYxMCDpdQwanOVfhQdADpf+YW7ripoOBzO8DXvt6rthZNsotHAgDcCbk/K1gP3QuTkR
        oSQtAdRXLpRndFzUO8y/v0c8vCWX6dXo8SeeknHP4KWNf86ZxF8d5LYsYvi2ByItmxXf4Cn+tUI3n
        zWf5i9bg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pxbwI-00DGJ9-2B;
        Fri, 12 May 2023 23:12:42 +0000
Date:   Fri, 12 May 2023 16:12:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH] blk-mq: don't queue passthrough request into scheduler
Message-ID: <ZF7H6hyXkSNfNZn9@infradead.org>
References: <20230512150328.192908-1-ming.lei@redhat.com>
 <70478f95-2852-9bf1-f8f7-630c74641c0f@kernel.dk>
 <ZF5ZB7QWPCF0ZKWN@ovpn-8-16.pek2.redhat.com>
 <b745f17b-088c-a72c-00f2-3c0a13cdead5@kernel.dk>
 <ZF5co5g2XLIw82DK@ovpn-8-16.pek2.redhat.com>
 <ca934bc6-651a-6c96-0598-105cd4a0b500@kernel.dk>
 <ZF6fyc/vFGm56mDO@infradead.org>
 <07d74584-1ea3-ef40-f0c7-7bc371fa633e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07d74584-1ea3-ef40-f0c7-7bc371fa633e@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 12, 2023 at 03:31:39PM -0600, Jens Axboe wrote:
> That's fine for telling error handling, probing etc apart from "normal"
> IO, but it doesn't solve the problem at hand which is assuming that
> anything inserted into the scheduler has a bio.

I think this is fine.  Passthrough requests should never go to the
scheduler, that's not where they blong.  Non-passthrough request always
have a bio.
