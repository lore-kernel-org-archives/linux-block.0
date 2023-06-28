Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77D6EB64DA
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 08:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjF1Inj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 04:43:39 -0400
Received: from verein.lst.de ([213.95.11.211]:38934 "EHLO verein.lst.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S234010AbjF1Iin (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 04:38:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E214E67373; Wed, 28 Jun 2023 10:38:39 +0200 (CEST)
Date:   Wed, 28 Jun 2023 10:38:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Min Li <min15.li@samsung.com>
Cc:     hch@lst.de, axboe@kernel.dk, dlemoal@kernel.org,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@kernel.org,
        willy@infradead.org
Subject: Re: [PATCH v3] block: add check that partition length needs to be
 aligned with block size
Message-ID: <20230628083839.GA26606@lst.de>
References: <20230628073214.GA25314@lst.de> <CGME20230628083625epcas5p48b2728c6a160744ef628da9ecb49db25@epcas5p4.samsung.com> <20230628163442.2796-1-min15.li@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628163442.2796-1-min15.li@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 28, 2023 at 04:34:42PM +0000, Min Li wrote:
> I will modify the blksz to unsigned int.
> For pre-existing start/length, is it ok to change them to sector_t?

They are long long in the UAPI, which is weird but has been that way
for a long time.  So I think we need checks for negative values
before they are shifted and converted to a sector_t.
