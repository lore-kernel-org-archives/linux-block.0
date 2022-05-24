Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1B1C433EF
	for <linux-block@archiver.kernel.org>; Tue, 24 May 2022 06:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiEXGCs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 May 2022 02:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbiEXGCd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 May 2022 02:02:33 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAEB62130;
        Mon, 23 May 2022 23:02:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D0737227A87; Tue, 24 May 2022 08:02:29 +0200 (CEST)
Date:   Tue, 24 May 2022 08:02:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 3/6] block: introduce bdev_dma_alignment helper
Message-ID: <20220524060229.GC24737@lst.de>
References: <20220523210119.2500150-1-kbusch@fb.com> <20220523210119.2500150-4-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523210119.2500150-4-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 23, 2022 at 02:01:16PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Preparing for upcoming dma_alignment users that have a block_device, but
> don't need the request_queue.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
