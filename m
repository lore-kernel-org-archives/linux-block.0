Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26309C04FF3
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 07:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0666A61209
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 07:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhEXHkR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 03:40:17 -0400
Received: from verein.lst.de ([213.95.11.211]:53582 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232266AbhEXHkQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 03:40:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E070167373; Mon, 24 May 2021 09:38:47 +0200 (CEST)
Date:   Mon, 24 May 2021 09:38:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv3 2/4] nvme: use blk_execute_rq() for passthrough
 commands
Message-ID: <20210524073847.GB24440@lst.de>
References: <20210521202145.3674904-1-kbusch@kernel.org> <20210521202145.3674904-3-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521202145.3674904-3-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 21, 2021 at 01:21:43PM -0700, Keith Busch wrote:
> The generic blk_execute_rq() knows how to handle polled completions. Use
> that instead of implementing an nvme specific handler.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
