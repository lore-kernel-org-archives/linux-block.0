Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F78C2D0A3
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 17:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC65820773
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 17:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JvYae3ck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgKPRA0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Nov 2020 12:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbgKPRA0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 12:00:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4EEC0613CF
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2020 09:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q425XsmxIVWaY/TThw0PrwAFqLqqRORqEPDBGSLFi58=; b=JvYae3ckKtghTSXYclKywltU4Z
        6Q2tTfhzGeeDJmqsUyq9FHrxbs66HN0PL8KhzgrhgGU9auLaiFZyr40h4ODSyfxBLW7Cv7CFXb6Mw
        70ivrlE2ZHuSPJPaFw0fwpbyQP05hnox4GXIfMrXDevCdHB/WfFj5qskHej/VRHBOe8QZOrvrI8xQ
        GfeJM1CRYnJPHcDt7Mfx4W0mFU53192ut10sZAJ+4aZxNKRBG/EFtij/74/zwMaP3feNA7Plu4stG
        MKd8D0jttrLmHfjuD+tftn9XDEP/RsuIpKEMrJnpBU2TiQg6Rb2vWAXhQj9rKjpzX5wL5TdfW9yYI
        MkmOyMig==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kehrc-0006Xz-BP; Mon, 16 Nov 2020 17:00:24 +0000
Date:   Mon, 16 Nov 2020 17:00:24 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 4/9] null_blk: improve zone locking
Message-ID: <20201116170024.GB24227@infradead.org>
References: <20201111130049.967902-1-damien.lemoal@wdc.com>
 <20201111130049.967902-5-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111130049.967902-5-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 11, 2020 at 10:00:44PM +0900, Damien Le Moal wrote:
> +#define null_unlock_zone_res(dev, flags)				\
> +	do {								\
> +		if ((dev)->need_zone_res_mgmt)				\
> +			spin_unlock_irqrestore(&(dev)->zone_res_lock,	\
> +					       (flags));		\
> +	} while (0)

Can you use inline functions here?

Otherwise this looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
