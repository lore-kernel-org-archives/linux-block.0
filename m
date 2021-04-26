Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D0EC433B4
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 14:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5DDE6127A
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 14:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhDZOgm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:36:42 -0400
Received: from verein.lst.de ([213.95.11.211]:41532 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232575AbhDZOgl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 10:36:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 79A7668C4E; Mon, 26 Apr 2021 16:35:58 +0200 (CEST)
Date:   Mon, 26 Apr 2021 16:35:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 2/5] nvme: use blk_execute_rq() for passthrough
 commands
Message-ID: <20210426143558.GB20668@lst.de>
References: <20210423220558.40764-1-kbusch@kernel.org> <20210423220558.40764-3-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423220558.40764-3-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
