Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53C3EB64D7
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 08:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjF1IKy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 04:10:54 -0400
Received: from verein.lst.de ([213.95.11.211]:38751 "EHLO verein.lst.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S232490AbjF1IIE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 04:08:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 89DA467373; Wed, 28 Jun 2023 09:32:14 +0200 (CEST)
Date:   Wed, 28 Jun 2023 09:32:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Min Li <min15.li@samsung.com>
Cc:     axboe@kernel.dk, willy@infradead.org, hch@lst.de,
        dlemoal@kernel.org, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH v3] block: add check that partition length needs to be
 aligned with block size
Message-ID: <20230628073214.GA25314@lst.de>
References: <CGME20230628051122epcas5p45d70f2c36ce91b60863f702de1534321@epcas5p4.samsung.com> <20230628130941.10690-1-min15.li@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628130941.10690-1-min15.li@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 28, 2023 at 01:09:41PM +0000, Min Li wrote:
> +	long long blksz = bdev_logical_block_size(bdev), start, length;

long long for the blocksize is a bit weird here, as the value is
an unsigned int.

Also while pre-existing the long long for start/length looks weird,
do we need to check for negative values somewhere?

Also don't forget the Cc stable that Greg requested.

