Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404C3C433EF
	for <linux-block@archiver.kernel.org>; Mon, 28 Mar 2022 08:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbiC1Ic2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Mar 2022 04:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239386AbiC1Ic1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Mar 2022 04:32:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5837B13D32
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 01:30:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0FDC71F385;
        Mon, 28 Mar 2022 08:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648456246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zTwNET6NFHGhSKFNWoO4/wxCz/Ohx5B7SlCtUBVlQec=;
        b=LN9Jptd9hAjIgEC4ZJmFQX/Z9N5TuwM0oNuHpyuekuzMosDdN1+zZQiQlk9wDeSDjvd2w6
        ZxFgWJEf/CWf2/8tIhQnBn/W8HtC/uyzq3SlpMwYxmRZpCMMYusgMHB6sxcdWXEiHHej60
        Cxrr6S6oSUaYbCkw3obQzRimu/FAwEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648456246;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zTwNET6NFHGhSKFNWoO4/wxCz/Ohx5B7SlCtUBVlQec=;
        b=seQ2j4KoWErxklMTXjF+mwYwb3/OrpqVESFpdXgFmwVUZOxc+X1TKBuIpVHUt68YYxe2YJ
        q2O2KFm4JeBQ1vBw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8993BA3B87;
        Mon, 28 Mar 2022 08:30:45 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3BB61A0610; Mon, 28 Mar 2022 10:30:45 +0200 (CEST)
Date:   Mon, 28 Mar 2022 10:30:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH 12/13] loop: remove lo_refcount and avoid lo_mutex in
 ->open / ->release
Message-ID: <20220328083045.ryoh7rbhauxgezgn@quack3.lan>
References: <20220324075119.1556334-1-hch@lst.de>
 <20220324075119.1556334-13-hch@lst.de>
 <20220324141321.pqesnshaswwk3svk@quack3.lan>
 <96a4e2e7-e16e-7e89-255d-8aa29ffca68b@I-love.SAKURA.ne.jp>
 <20220324172335.GA28299@lst.de>
 <0b47dbee-ce17-7502-6bf3-fad939f89bb7@I-love.SAKURA.ne.jp>
 <20220325162331.GA16355@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325162331.GA16355@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 25-03-22 17:23:31, Christoph Hellwig wrote:
> On Fri, Mar 25, 2022 at 07:54:15PM +0900, Tetsuo Handa wrote:
> > > But for now I'd really prefer to stop moving the goalpost further and
> > > further.
> > 
> > Then, why not kill this code?
> 
> I think we should eventually do that, and I've indeed tested a patch
> that is only cosmetically different.  I wasn't really convinced we
> should do it in this series, but if there is consensus that we should
> do it now I can respin the series with a patch like this included.

I'd defer it to a separate patchset. Because as much as the change to
disallow LOOP_CLR_FD ioctl for used loop device makes sense, I'm not sure
there isn't some framework using loop devices somewhere which relies on
this just getting magically translated to setting LO_AUTOCLEAR flag. So IMO
this has a big potential of userspace visible regression and as such I'd
prefer doing it separately from the bugfixes.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
