Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E03C3A59E
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 00:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8479206BB
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 00:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbfHVAzL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 20:55:11 -0400
Received: from verein.lst.de ([213.95.11.211]:42324 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728724AbfHVAzL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 20:55:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 538FB68BFE; Thu, 22 Aug 2019 02:55:08 +0200 (CEST)
Date:   Thu, 22 Aug 2019 02:55:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCH V3 1/6] null_blk: move duplicate code to callers
Message-ID: <20190822005508.GB10938@lst.de>
References: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com> <20190821061314.3262-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821061314.3262-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 20, 2019 at 11:13:09PM -0700, Chaitanya Kulkarni wrote:
> This is a preparation patch which moves the duplicate code for sectors
> and nr_sectors calculations for bio vs request mode into their
> respective callers (null_queue_bio(), null_qeueue_req()). Now the core
> function only deals with the respective actions and commands instead of
> having to calculte the bio vs req operations and different sector
> related variables. We also move the flush command handling at the top
> which significantly simplifies the rest of the code.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
