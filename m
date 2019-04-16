Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F24C10F13
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 17:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEAB20880
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 17:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbfDPRK3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:10:29 -0400
Received: from verein.lst.de ([213.95.11.211]:36993 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfDPRK2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 13:10:28 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A8C9168AFE; Tue, 16 Apr 2019 19:10:12 +0200 (CEST)
Date:   Tue, 16 Apr 2019 19:10:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] block: rewrite blk_bvec_map_sg to avoid a nth_page
 call
Message-ID: <20190416171011.GA4611@lst.de>
References: <20190408104641.4905-1-hch@lst.de> <20190408104641.4905-2-hch@lst.de> <20190415194435.GA23676@roeck-us.net> <20190415205242.GA6380@lst.de> <20190415210731.GA32723@roeck-us.net> <20190416063356.GA25763@lst.de> <20190416170847.GA5531@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416170847.GA5531@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 16, 2019 at 10:08:47AM -0700, Guenter Roeck wrote:
> That is besides the point. Your code changes an internal API to be more
> stringent and less forgiving. This causes failures, presumably because
> callers of that API took advantage (on purpose or not) of it.
> When changing an API, you are responsible for both ends. You can not claim
> that the callers of that API are buggy. Taking advangage of a forgiving
> API is not a bug. If you change an API, and that change causes a failure,
> that is a regression, not a bug on the side of the caller.

As said I offered to fix these, even if this isn't my fault.  I'm also
still waiting for the the other reports.
