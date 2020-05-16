Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8D3C433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 16:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B3EB206D8
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 16:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgEPQnd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 12:43:33 -0400
Received: from verein.lst.de ([213.95.11.211]:32823 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgEPQnd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 12:43:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 667C668B05; Sat, 16 May 2020 18:43:30 +0200 (CEST)
Date:   Sat, 16 May 2020 18:43:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-mq: remove the bio argument to ->prepare_request
Message-ID: <20200516164330.GA18772@lst.de>
References: <20200516154059.328211-1-hch@lst.de> <ffaa84e5-8878-84a9-5c52-a04fc3016cfe@acm.org> <20200516161346.GA17642@lst.de> <7d9889de-8078-0ea8-574a-586edf2c4e6b@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d9889de-8078-0ea8-574a-586edf2c4e6b@cloud.ionos.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 16, 2020 at 06:36:34PM +0200, Guoqing Jiang wrote:
> Hi Christoph,
>
> On 5/16/20 6:13 PM, Christoph Hellwig wrote:
>> On Sat, May 16, 2020 at 09:12:10AM -0700, Bart Van Assche wrote:
>>> On 2020-05-16 08:40, Christoph Hellwig wrote:
>>>> None of the I/O schedulers actually needs it.
>>> Is the next step perhaps to remove the bio argument from
>>> blk_mq_get_request()? Anyway:
>> Yes, but that is a bigger surgery :)
>
> I had local changes for it which was compiled test, and seems no new caller 
> of blk_mq_get_request.

Well, my plan was to sort out the calling conventions for real:

http://git.infradead.org/users/hch/block.git/commitdiff/bce839ff0799e398975c5a5c5a5123402ead6cc8
