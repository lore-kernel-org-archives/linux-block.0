Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9D8C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 15:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3621920652
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 15:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfD3PFx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:05:53 -0400
Received: from verein.lst.de ([213.95.11.211]:47053 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfD3PFw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 11:05:52 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4D1B867358; Tue, 30 Apr 2019 17:05:36 +0200 (CEST)
Date:   Tue, 30 Apr 2019 17:05:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: bio_add_pc_page cleanups
Message-ID: <20190430150536.GA25358@lst.de>
References: <20190425070435.3478-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425070435.3478-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping?

On Thu, Apr 25, 2019 at 09:04:32AM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> please take a look at these trivial bio_add_pc_page cleanups.
---end quoted text---
