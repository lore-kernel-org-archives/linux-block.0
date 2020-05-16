Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5E2C433DF
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 16:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA5D2065C
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 16:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgEPQNt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 12:13:49 -0400
Received: from verein.lst.de ([213.95.11.211]:60969 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgEPQNt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 12:13:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 219CA68C4E; Sat, 16 May 2020 18:13:46 +0200 (CEST)
Date:   Sat, 16 May 2020 18:13:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-mq: remove the bio argument to ->prepare_request
Message-ID: <20200516161346.GA17642@lst.de>
References: <20200516154059.328211-1-hch@lst.de> <ffaa84e5-8878-84a9-5c52-a04fc3016cfe@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffaa84e5-8878-84a9-5c52-a04fc3016cfe@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 16, 2020 at 09:12:10AM -0700, Bart Van Assche wrote:
> On 2020-05-16 08:40, Christoph Hellwig wrote:
> > None of the I/O schedulers actually needs it.
> 
> Is the next step perhaps to remove the bio argument from
> blk_mq_get_request()? Anyway:

Yes, but that is a bigger surgery :)
