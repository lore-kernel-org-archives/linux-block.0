Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93B3C433EF
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 13:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiC2NQQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 09:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbiC2NQP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 09:16:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B33639B
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 06:14:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 72D9767373; Tue, 29 Mar 2022 15:14:27 +0200 (CEST)
Date:   Tue, 29 Mar 2022 15:14:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20220329131427.GA1848@lst.de>
References: <20220324075119.1556334-1-hch@lst.de> <20220324075119.1556334-13-hch@lst.de> <20220324141321.pqesnshaswwk3svk@quack3.lan> <96a4e2e7-e16e-7e89-255d-8aa29ffca68b@I-love.SAKURA.ne.jp> <20220324172335.GA28299@lst.de> <0b47dbee-ce17-7502-6bf3-fad939f89bb7@I-love.SAKURA.ne.jp> <20220325162331.GA16355@lst.de> <20220328083045.ryoh7rbhauxgezgn@quack3.lan> <20220329063921.GA19778@lst.de> <20220329094203.zkgkqtumix7nygs2@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329094203.zkgkqtumix7nygs2@quack3.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 29, 2022 at 11:42:03AM +0200, Jan Kara wrote:
> > entirely, as loop_clr_fd now is safe against concurrent users - it
> > has to anyway as there can be other users even without an open.
> 
> Ah, OK, so you'd always set LO_AUTOCLEAR and leave cleanup to happen
> from lo_release()? That makes sense to me.

No, my idea was to never set LO_AUTOCLEAR.  We have a frozen queue and
all protections in place to make clearing the file perfectly safe.
In fact the change_fd case also allows this.
