Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734ACC43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 16:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B72E20644
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 16:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfD3Q1c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:27:32 -0400
Received: from verein.lst.de ([213.95.11.211]:47699 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfD3Q1c (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 12:27:32 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A1F6767358; Tue, 30 Apr 2019 18:27:15 +0200 (CEST)
Date:   Tue, 30 Apr 2019 18:27:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: remove the unused blk_queue_dma_pad function
Message-ID: <20190430162715.GA27074@lst.de>
References: <20190430161030.23150-1-hch@lst.de> <e595d372-aea1-64f9-dfe6-c80a1f04be7b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e595d372-aea1-64f9-dfe6-c80a1f04be7b@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 30, 2019 at 10:25:57AM -0600, Jens Axboe wrote:
> ??

Bah, that shouldn't have slipped into this patch..
