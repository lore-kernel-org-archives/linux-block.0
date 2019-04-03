Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A9CC4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 19:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4826D206B7
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 19:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfDCTvD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:51:03 -0400
Received: from verein.lst.de ([213.95.11.211]:35352 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCTvD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Apr 2019 15:51:03 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 998D468AFE; Wed,  3 Apr 2019 21:50:52 +0200 (CEST)
Date:   Wed, 3 Apr 2019 21:50:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] block: bio: ensure newly added bio flags don't
 override BVEC_POOL_IDX
Message-ID: <20190403195052.GA30560@lst.de>
References: <20190403091519.13376-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403091519.13376-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
