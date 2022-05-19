Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C535C433F5
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 07:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiESHdX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 03:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbiESHdP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 03:33:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912289347C;
        Thu, 19 May 2022 00:33:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CFACF68AFE; Thu, 19 May 2022 09:33:11 +0200 (CEST)
Date:   Thu, 19 May 2022 09:33:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/3] block: export dma_alignment attribute
Message-ID: <20220519073311.GD22301@lst.de>
References: <20220518171131.3525293-1-kbusch@fb.com> <20220518171131.3525293-3-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518171131.3525293-3-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 18, 2022 at 10:11:30AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> User space may want to know how to align their buffers to avoid
> bouncing. Export the queue attribute.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
