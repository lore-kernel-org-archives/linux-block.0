Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AEEC433B4
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 05:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D8C610E5
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 05:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344706AbhDGFR7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 01:17:59 -0400
Received: from verein.lst.de ([213.95.11.211]:57407 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhDGFR7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Apr 2021 01:17:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E8E2968B05; Wed,  7 Apr 2021 07:17:48 +0200 (CEST)
Date:   Wed, 7 Apr 2021 07:17:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH] blk-zoned: Remove the definition of blk_zone_start()
Message-ID: <20210407051748.GA18319@lst.de>
References: <20210406200820.15180-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406200820.15180-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
