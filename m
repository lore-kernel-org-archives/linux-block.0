Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9352BC433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 08:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790286126A
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 08:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhJRIoR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 04:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhJRIoP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 04:44:15 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE04C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 01:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wlwDrutvXDkpve/AMxeKaRFhez0bV/CFsTIqA0NBx2M=; b=OjGlWtla/t7hCDaSrzPS4VJs9U
        mGLAW/iHvZ2EoD9gDGz0ZbrSvaRLgfGuASpx23j8uintSKojT9Rj/5T+MIpRfg/MJFfI/PtRpwjsE
        yChXESKWY9AnreSNexYOLtSkyD7AZ/tf09IWuDrQWiiHkPARKBwIC5xeAsbLTPu3pTASlbyihL7zB
        zD6sSs0i4H3af0/i7oN1Qfq7R5RCt3vHgiNayLY/CRPYq3dBPurtaGoGY0cuXN2wueeIyugkhlty4
        owvIOMpAeugai5PPjIiUBHEfQMNoylyTyM1RBC5EgU5VSjdL0Y8N3za9jcMEeylqO4D2jIVKzj+GO
        yq71auXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcODc-00Eg9k-Jy; Mon, 18 Oct 2021 08:42:04 +0000
Date:   Mon, 18 Oct 2021 01:42:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 01/14] block: inline fast path of driver tag allocation
Message-ID: <YW0zXEOcn/lkozM5@infradead.org>
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017013748.76461-2-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 16, 2021 at 07:37:35PM -0600, Jens Axboe wrote:
> If we don't use an IO scheduler or have shared tags, then we don't need
> to call into this external function at all. This saves ~2% for such
> a setup.

This looks correct, although the call chain gets a little confusing
now.  How much difference is this over basically inlining the
whole old blk_mq_get_driver_tag?
