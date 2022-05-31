Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D61C433F5
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 06:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbiEaG1K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 02:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244257AbiEaG1F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 02:27:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26613AE40;
        Mon, 30 May 2022 23:27:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 228E368AFE; Tue, 31 May 2022 08:26:58 +0200 (CEST)
Date:   Tue, 31 May 2022 08:26:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, pankydev8@gmail.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 7/9] block/bounce: count bytes instead of sectors
Message-ID: <20220531062657.GD21098@lst.de>
References: <20220526010613.4016118-1-kbusch@fb.com> <20220526010613.4016118-8-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526010613.4016118-8-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 25, 2022 at 06:06:11PM -0700, Keith Busch wrote:
> +	/*
> +	 * If the original has more than BIO_MAX_VECS biovecs, the total bytes
> +	 * may not be block size aligned. Align down to ensure both sides of
> +	 * the split bio are appropriately sized.
> +	 */

Same comment on the comment as fo the previous patch.

> +	sectors = ALIGN_DOWN(bytes, queue_logical_block_size(q)) >> SECTOR_SHIFT;

Overly long line here.
