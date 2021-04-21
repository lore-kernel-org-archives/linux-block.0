Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B49C433B4
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 14:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0C9861453
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 14:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243501AbhDUOYv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 10:24:51 -0400
Received: from verein.lst.de ([213.95.11.211]:54838 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243506AbhDUOXt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 10:23:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E203F67373; Wed, 21 Apr 2021 16:23:14 +0200 (CEST)
Date:   Wed, 21 Apr 2021 16:23:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] ataflop: fix off by one in ataflop_probe()
Message-ID: <20210421142314.GB29072@lst.de>
References: <YH/7+65JruUO/wsg@mwanda> <YH/8QdfDxhjGjXHG@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH/8QdfDxhjGjXHG@mwanda>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 21, 2021 at 01:19:45PM +0300, Dan Carpenter wrote:
> Smatch complains that the "type > NUM_DISK_MINORS" should be >=
> instead of >.  We also need to subtract one from "type" at the start.
> 
> Fixes: bf9c0538e485 ("ataflop: use a separate gendisk for each media format")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
