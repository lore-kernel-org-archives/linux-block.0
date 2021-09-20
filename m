Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E36CC433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 08:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E197F6115C
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 08:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbhITImF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 04:42:05 -0400
Received: from verein.lst.de ([213.95.11.211]:50553 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235456AbhITImD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 04:42:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C592E67373; Mon, 20 Sep 2021 10:40:34 +0200 (CEST)
Date:   Mon, 20 Sep 2021 10:40:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] block: genhd: fix double kfree() in
 __alloc_disk_node()
Message-ID: <20210920084034.GA467@lst.de>
References: <0000000000004a5adf05cc593ca9@google.com> <41766564-08cb-e7f2-4cb2-9ad102f21324@I-love.SAKURA.ne.jp> <3999c511-cd27-1554-d3a6-4288c3eca298@i-love.sakura.ne.jp> <20210920064028.GB26999@lst.de> <c5b78df8-1ab7-04fa-d6e8-c7270c3bc373@i-love.sakura.ne.jp> <20210920080547.GA30362@lst.de> <692fdc1a-6396-dcf4-c700-2d822f161053@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <692fdc1a-6396-dcf4-c700-2d822f161053@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
