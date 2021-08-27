Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB786C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968D760F92
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhH0QoQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 12:44:16 -0400
Received: from verein.lst.de ([213.95.11.211]:34548 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbhH0QoQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 12:44:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 40DCF67373; Fri, 27 Aug 2021 18:43:25 +0200 (CEST)
Date:   Fri, 27 Aug 2021 18:43:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH for-5.14] cryptoloop: add a deprecation warning
Message-ID: <20210827164325.GA26364@lst.de>
References: <20210827163250.255325-1-hch@lst.de> <59808096-34ff-151f-b7a2-f53d4262f00a@kernel.dk> <20210827164051.GA26147@lst.de> <cc2108b6-c688-cceb-a953-f156ad21c3a5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc2108b6-c688-cceb-a953-f156ad21c3a5@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 27, 2021 at 10:42:59AM -0600, Jens Axboe wrote:
> But what's the point? Why not just wait for 5.15, it's not like we're
> in a mad dash to get it removed.

Actually we kinda are :)
