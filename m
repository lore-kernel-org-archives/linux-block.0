Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2606C433EF
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 07:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243983AbiC3IAH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 04:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243958AbiC3IAE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 04:00:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE88201BA
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 00:58:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6FABD210E3;
        Wed, 30 Mar 2022 07:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648627095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=btc3lxSUn9PcVitjKrtXKpgwEopvHljRAuljTFIUVlI=;
        b=Cc2PWxFsbVm023/0/w5hnMdoxtxyqBlgFUq+B92S4OCTzZsyTytTYrYqt0gCwZn6J0sAF5
        D6uPXUS65xESZfg9ZIHgKJodPZwl9aF9X1kIzpJK93O1YyaeXD2GiBtG7q+hGAluKwmc1R
        naMnPN76xSEY1dt1Onfp3ws2Q3Xfwns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648627095;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=btc3lxSUn9PcVitjKrtXKpgwEopvHljRAuljTFIUVlI=;
        b=RnrEnTIKj0ddOaGg++fbm9v8wc+F0UsBJQd/HFqoN7r/RI6GzKX2vmZlG0WKAi/bXpXKkF
        Br8d7xJ540nfQ8Bg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1408BA3B83;
        Wed, 30 Mar 2022 07:58:15 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5A529A0610; Wed, 30 Mar 2022 09:58:09 +0200 (CEST)
Date:   Wed, 30 Mar 2022 09:58:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH 12/13] loop: remove lo_refcount and avoid lo_mutex in
 ->open / ->release
Message-ID: <20220330075809.f7676hejthuwcyk6@quack3.lan>
References: <20220324075119.1556334-13-hch@lst.de>
 <20220324141321.pqesnshaswwk3svk@quack3.lan>
 <96a4e2e7-e16e-7e89-255d-8aa29ffca68b@I-love.SAKURA.ne.jp>
 <20220324172335.GA28299@lst.de>
 <0b47dbee-ce17-7502-6bf3-fad939f89bb7@I-love.SAKURA.ne.jp>
 <20220325162331.GA16355@lst.de>
 <20220328083045.ryoh7rbhauxgezgn@quack3.lan>
 <20220329063921.GA19778@lst.de>
 <20220329094203.zkgkqtumix7nygs2@quack3.lan>
 <20220329131427.GA1848@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329131427.GA1848@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 29-03-22 15:14:27, Christoph Hellwig wrote:
> On Tue, Mar 29, 2022 at 11:42:03AM +0200, Jan Kara wrote:
> > > entirely, as loop_clr_fd now is safe against concurrent users - it
> > > has to anyway as there can be other users even without an open.
> > 
> > Ah, OK, so you'd always set LO_AUTOCLEAR and leave cleanup to happen
> > from lo_release()? That makes sense to me.
> 
> No, my idea was to never set LO_AUTOCLEAR.  We have a frozen queue and
> all protections in place to make clearing the file perfectly safe.
> In fact the change_fd case also allows this.

I see, thanks for explanation. But then there's the risk of userspace
regressions if someone relies on the current behavior that LOOP_CLR_FD
ioctl does only delayed teardown of the device if someone is using it.
Personally I don't think the risk of regression is worth the benefit of the
cleanup but maybe it's worth trying. At least I know that for loop device
handling inside mount(8) (which plays tricks with reusing existing bound
loop devices), this change should be safe.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
