Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4A2C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB39C60F14
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhH0Qlm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 12:41:42 -0400
Received: from verein.lst.de ([213.95.11.211]:34539 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbhH0Qlm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 12:41:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 85A1467373; Fri, 27 Aug 2021 18:40:51 +0200 (CEST)
Date:   Fri, 27 Aug 2021 18:40:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH for-5.14] cryptoloop: add a deprecation warning
Message-ID: <20210827164051.GA26147@lst.de>
References: <20210827163250.255325-1-hch@lst.de> <59808096-34ff-151f-b7a2-f53d4262f00a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59808096-34ff-151f-b7a2-f53d4262f00a@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 27, 2021 at 10:37:41AM -0600, Jens Axboe wrote:
> On 8/27/21 10:32 AM, Christoph Hellwig wrote:
> > Support for cryptoloop has been officially marked broken and deprecated
> > in favor of dm-crypt (which supports the same broken algorithms if
> > needed) in Linux 2.6.4 (released in March 2004), and support for it has
> > been entirely removed from losetup in util-linux 2.23 (released in April
> > 2013).  Add a warning and a deprecation schedule.
> 
> Would probably look better to queue with the 5.15 patches at this point.
> Which then begs the question of whether we want to make the removal
> target 5.17 instead.

File locking also just managed to sneak in a short-term deprecation for
a very similar situation.
