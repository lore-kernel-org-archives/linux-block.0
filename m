Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CECC433DF
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 16:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F351920829
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 16:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405088AbgE1QnB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 12:43:01 -0400
Received: from verein.lst.de ([213.95.11.211]:57285 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405075AbgE1QnA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 12:43:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DE5B068AFE; Thu, 28 May 2020 18:42:56 +0200 (CEST)
Date:   Thu, 28 May 2020 18:42:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCHv2 1/2] blk-mq: export __blk_mq_complete_request
Message-ID: <20200528164256.GA25651@lst.de>
References: <20200528151931.3501506-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528151931.3501506-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 08:19:30AM -0700, Keith Busch wrote:
> For when drivers have a need to bypass error injection.

EXPORT_SYMBOL_GPL, and as hinted I think this needs a better name.
It also absolutely needs a kerneldoc comment describing the use case.
