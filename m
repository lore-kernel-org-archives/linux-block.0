Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F539C433E0
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 07:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F5622CA2
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 07:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732736AbhALHek (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 02:34:40 -0500
Received: from verein.lst.de ([213.95.11.211]:54168 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731157AbhALHek (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 02:34:40 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A891767373; Tue, 12 Jan 2021 08:33:58 +0100 (CET)
Date:   Tue, 12 Jan 2021 08:33:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com
Subject: Re: [PATCH V9 6/9] nvmet: add bio init helper for different
 backends
Message-ID: <20210112073358.GB24288@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com> <20210112042623.6316-7-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112042623.6316-7-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static inline void nvmet_bio_init(struct bio *bio, struct block_device *bdev,
> +				  unsigned int op, sector_t sect, void *private,
> +				  bio_end_io_t *bi_end_io)
> +{
> +	bio_set_dev(bio, bdev);
> +	bio->bi_opf = op;
> +	bio->bi_iter.bi_sector = sect;
> +	bio->bi_private = private;
> +	bio->bi_end_io = bi_end_io;
> +}

Nothing NVMe specific about this.  The helper also doesn't relaly contain
any logic either.
