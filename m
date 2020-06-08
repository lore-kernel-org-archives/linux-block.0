Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BD1C433DF
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 08:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6403206A4
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 08:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgFHIZa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:25:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:33908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbgFHIZ3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Jun 2020 04:25:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 66833AA7C;
        Mon,  8 Jun 2020 08:25:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3EF0E1E1283; Mon,  8 Jun 2020 10:25:28 +0200 (CEST)
Date:   Mon, 8 Jun 2020 10:25:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2 v3] blktrace: Fix sparse annotations and warn if
 enabling multiple traces
Message-ID: <20200608082528.GK13248@quack2.suse.cz>
References: <20200605145349.18454-1-jack@suse.cz>
 <20200605150350.GM11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605150350.GM11244@42.do-not-panic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Luis!

On Fri 05-06-20 15:03:50, Luis Chamberlain wrote:
> On Fri, Jun 05, 2020 at 04:58:35PM +0200, Jan Kara wrote:
> > Hello Jens,
> > 
> > this series contains a patch from Luis' blktrace series and then my patch
> > to fix sparse warnings in blktrace. Luis' patch stands on its own, was
> > reviewed, and changes what I need to change as well so I've decided it's just
> > simplest to pull it in with my patch.
> 
> Hey Jan,
> 
> Since these patches have contexts which can affect other patches in the
> series of fixes I have, if possible I'd prefer if these get addressed in
> order. I was just waiting for 0-day to finish grinding on the series.
> I already have a successful build results, but just waiting on the
> series of other tests, part of which include blktests.
> 
> If this is agreeable, I hope to post that series later today.

Whatever... I wasn't sure how long it's going to take to finish your series
and since Jens was asking about the sparse fixes, I've just sent them
along. BTW the two patches applied just fine separately from the rest of
the series so I don't think there's any dependency to the rest of your
series even in context.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
