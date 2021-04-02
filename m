Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAC1C433ED
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 10:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FFE56112F
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 10:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBKA4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Apr 2021 06:00:56 -0400
Received: from verein.lst.de ([213.95.11.211]:43159 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229605AbhDBKA4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Apr 2021 06:00:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7BD1F68BEB; Fri,  2 Apr 2021 12:00:53 +0200 (CEST)
Date:   Fri, 2 Apr 2021 12:00:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 0/3] blk-mq: Fix a race between iterating over
 requests and freeing requests
Message-ID: <20210402100053.GA14047@lst.de>
References: <20210329020028.18241-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329020028.18241-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
