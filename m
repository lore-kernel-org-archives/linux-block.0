Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E252C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 16:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbiDMQt5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiDMQt4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 12:49:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CD0692A9
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 09:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C7HddZ8+UobgGPOXvKXv+8kApHHXESKGsEN+LTzMtrc=; b=3Wrx9iqkgYEyYJB4VL8tn9CXLd
        osHTfuevIWSmabQOaE866PSuj9Lh+j+K75jAQFuLITxHqNLGQguirE3N0mpoWRbI5Y9wrPGPvjB0w
        x1rZzjQD9N8MFxfOMclep2aTuIMtRZA1XSjXsIAVt27+PYhrQ/ta4PhlC+Gkb4PTe9tycT1FRLpe2
        Wr/CD1Gvj5WvIEM+o8cofN7F1HdFbdPkOnxraK9hUlacPBCUX7RUYdwc4xygvyY/98JfTxZqkLRTS
        W46jktAbJtsimXdOOeKK/5NJU4+yDrpmLRRDJHffSZ1I8Jm3WfDAM2ZR6dr8UwlqpU2QZjC/sLOmY
        hz2lmQjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neg9V-001oPv-7p; Wed, 13 Apr 2022 16:47:33 +0000
Date:   Wed, 13 Apr 2022 09:47:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH] block: fix offset/size check in bio_trim()
Message-ID: <Ylb+pa0828efvdJz@infradead.org>
References: <20220412145814.1436505-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412145814.1436505-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 12, 2022 at 10:58:14PM +0800, Ming Lei wrote:
> Unit of bio->bi_iter.bi_size is bytes, but unit of offset/size
> is sector.
> 
> Fix the above issue in checking offset/size in bio_trim().

Just use bio_sectors() instead.
