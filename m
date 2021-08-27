Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D27C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9458604D7
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhH0Q4W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 12:56:22 -0400
Received: from verein.lst.de ([213.95.11.211]:34602 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230021AbhH0Q4W (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 12:56:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DF13968B05; Fri, 27 Aug 2021 18:55:29 +0200 (CEST)
Date:   Fri, 27 Aug 2021 18:55:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH for-5.14] cryptoloop: add a deprecation warning
Message-ID: <20210827165528.GA27254@lst.de>
References: <20210827163250.255325-1-hch@lst.de> <59808096-34ff-151f-b7a2-f53d4262f00a@kernel.dk> <20210827164051.GA26147@lst.de> <cc2108b6-c688-cceb-a953-f156ad21c3a5@kernel.dk> <20210827164325.GA26364@lst.de> <c7e538b3-e669-1963-b6c5-475285e96784@kernel.dk> <20210827164637.GA26631@lst.de> <5724b5a9-e8e9-d05d-83fe-8a0920261573@kernel.dk> <20210827165019.GB26631@lst.de> <6332d413-291c-7b1a-504e-aa69d6bf300e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6332d413-291c-7b1a-504e-aa69d6bf300e@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 27, 2021 at 10:52:52AM -0600, Jens Axboe wrote:
> As I said, I don't really care that much about it, but it would be nice
> to have some actual justification for WHY it should go out asap. It's
> not really about risk.

Because as part of the overall huge loop discussion it has resurfaces
how broken it is, and how it is in the way of how the loop driver works.
Milan for example has argued for just removing it ASAP because of that,
but I guess providing at least a bit of time of deprecation would
be nice.  Then again given that state I'd be perfectly fine with just
removing it in 5.16 without much of a warning either.
