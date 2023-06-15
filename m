Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EBBEB64D9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 04:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242189AbjFOESG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 00:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243009AbjFOERr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 00:17:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39026269E;
        Wed, 14 Jun 2023 21:17:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DCE6D67373; Thu, 15 Jun 2023 06:17:42 +0200 (CEST)
Date:   Thu, 15 Jun 2023 06:17:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        martin@lichtvoll.de, fthain@linux-m68k.org, stable@vger.kernel.org
Subject: Re: [PATCH v10 2/3] block: change annotation of rdb_CylBlocks in
 affs_hardblocks.h
Message-ID: <20230615041742.GA4426@lst.de>
References: <20230615030837.8518-1-schmitzmic@gmail.com> <20230615030837.8518-3-schmitzmic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615030837.8518-3-schmitzmic@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 15, 2023 at 03:08:36PM +1200, Michael Schmitz wrote:
> +/* MSch 20230615: any field used by the Linux kernel must be
> + * annotated __be32! If any fields require increase to 64
> + * bit size, rdb_ID _must_ be changed!
> + */

This is a really weird comment.  If you change on-disk format it
is a different format and needs to be marked as such, sure.

And as far as I can tell everything that is a __u32 here should
be an __be32 because it is a big endian on-disk format.  Why
would you change only a single field?

