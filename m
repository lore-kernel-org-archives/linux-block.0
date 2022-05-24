Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301F5C433F5
	for <linux-block@archiver.kernel.org>; Tue, 24 May 2022 06:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiEXGIB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 May 2022 02:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiEXGIA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 May 2022 02:08:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDCC6A07A;
        Mon, 23 May 2022 23:07:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 29D0568AFE; Tue, 24 May 2022 08:07:55 +0200 (CEST)
Date:   Tue, 24 May 2022 08:07:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 4/6] block/merge: count bytes instead of sectors
Message-ID: <20220524060754.GD24737@lst.de>
References: <20220523210119.2500150-1-kbusch@fb.com> <20220523210119.2500150-5-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523210119.2500150-5-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 23, 2022 at 02:01:17PM -0700, Keith Busch wrote:
> +	const unsigned max_bytes = get_max_io_size(q, bio) << 9;

> +	return bio_split(bio, bytes >> 9, GFP_NOIO, bs);

These should use SECTOR_SHIFT.

>  split:
>  	*segs = nsegs;
> +	bytes = ALIGN_DOWN(bytes, queue_logical_block_size(q));

Please add a comment explaining the added alignment here.
