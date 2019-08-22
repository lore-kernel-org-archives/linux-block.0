Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA026C3A59E
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 00:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A7D206BA
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 00:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfHVA6i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 20:58:38 -0400
Received: from verein.lst.de ([213.95.11.211]:42345 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbfHVA6i (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 20:58:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 24F8C68BFE; Thu, 22 Aug 2019 02:58:35 +0200 (CEST)
Date:   Thu, 22 Aug 2019 02:58:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCH V3 5/6] null_blk: create a helper for zoned devices
Message-ID: <20190822005834.GF10938@lst.de>
References: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com> <20190821061314.3262-6-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821061314.3262-6-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static inline blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
> +					     enum req_opf op, sector_t sector,
> +					     sector_t nr_sectors)
> +{

Shouldn't this go into null_blk_zoned.c?  Also the indentation for the
here seems odd.

> +	blk_status_t sts = BLK_STS_OK;
> +
> +	switch (op) {
> +	case REQ_OP_WRITE:
> +		sts = null_zone_write(cmd, sector, nr_sectors);
> +		break;
> +	case REQ_OP_ZONE_RESET:
> +		sts = null_zone_reset(cmd, sector);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return sts;

Why not:

	switch (op) {
	case REQ_OP_WRITE:
		return null_zone_write(cmd, sector, nr_sectors);
	case REQ_OP_ZONE_RESET:
		return null_zone_reset(cmd, sector);
	default:
		return BLK_STS_OK;
}
