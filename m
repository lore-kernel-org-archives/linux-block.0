Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678CBC433EF
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 06:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244214AbiEaGTz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 02:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbiEaGTz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 02:19:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F9D8CCD0;
        Mon, 30 May 2022 23:19:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5BC9468AFE; Tue, 31 May 2022 08:19:50 +0200 (CEST)
Date:   Tue, 31 May 2022 08:19:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, pankydev8@gmail.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 1/9] block: fix infiniate loop for invalid zone append
Message-ID: <20220531061950.GA21098@lst.de>
References: <20220526010613.4016118-1-kbusch@fb.com> <20220526010613.4016118-2-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526010613.4016118-2-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 25, 2022 at 06:06:05PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Returning 0 early from __bio_iov_append_get_pages() for the
> max_append_sectors warning just creates an infinite loop since 0 means
> success, and the bio will never fill from the unadvancing iov_iter. We
> could turn the return into an error value, but it will already be turned
> into an error value later on, so just remove the warning. Clearly no one
> ever hit it anyway.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
