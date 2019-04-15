Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382E8C10F0E
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 20:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E1D20651
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 20:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfDOUw4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:52:56 -0400
Received: from verein.lst.de ([213.95.11.211]:59485 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbfDOUw4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 16:52:56 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 759D168AFE; Mon, 15 Apr 2019 22:52:42 +0200 (CEST)
Date:   Mon, 15 Apr 2019 22:52:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] block: rewrite blk_bvec_map_sg to avoid a nth_page
 call
Message-ID: <20190415205242.GA6380@lst.de>
References: <20190408104641.4905-1-hch@lst.de> <20190408104641.4905-2-hch@lst.de> <20190415194435.GA23676@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415194435.GA23676@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 15, 2019 at 12:44:35PM -0700, Guenter Roeck wrote:
> This patch causes crashes with various boot tests. Most sparc tests crash, as
> well as several arm tests. Bisect results in both cases point to this patch.

That just means we trigger an existing bug more easily now.  I'll see
if I can help with the issues.
