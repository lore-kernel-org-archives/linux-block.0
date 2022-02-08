Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764BFC433EF
	for <linux-block@archiver.kernel.org>; Tue,  8 Feb 2022 13:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbiBHNqK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiBHNqJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Feb 2022 08:46:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F600C03FED0
        for <linux-block@vger.kernel.org>; Tue,  8 Feb 2022 05:46:04 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EA9AC210F9;
        Tue,  8 Feb 2022 13:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644327962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H9mTDHRn4rDCTFNm9LKmE5lKyDRh9x5V5ssHBvtyW2U=;
        b=RtfLojFkrxrhMGCt/qb2RhzN5DCywcfZX7wAs8sOn9CMTIP88bE1kW5qyYPmd2tWL7oAw6
        PXpGxqmoNbqdlx7LQvjyACKBfBynQHVhlMDwLOpHkMcyuW9clCbYDEXDYiwj8jC1nNpxR+
        Dfy8ePgizai6PgH4eRPwMXzqLe/XRuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644327962;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H9mTDHRn4rDCTFNm9LKmE5lKyDRh9x5V5ssHBvtyW2U=;
        b=YdZaR9JKL09/8SN+SvEc9M/fgWZZocEe3SipDQBMMkLtAfNpm6Iu+G73z+ZrGcbeGcbF+O
        VduXr+bJ/5n9ovAQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D86D2A3B88;
        Tue,  8 Feb 2022 13:46:02 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5128BA05C7; Tue,  8 Feb 2022 14:45:59 +0100 (CET)
Date:   Tue, 8 Feb 2022 14:45:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 5/8] loop: only take lo_mutex for the first reference in
 lo_open
Message-ID: <20220208134559.qfs4pkukdzkuh2rg@quack3.lan>
References: <20220128130022.1750906-1-hch@lst.de>
 <20220128130022.1750906-6-hch@lst.de>
 <397e50c7-ae46-8834-1632-7bac1ad7df99@I-love.SAKURA.ne.jp>
 <10d156e7-4347-4ccd-51f4-ea5febd1b1ee@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10d156e7-4347-4ccd-51f4-ea5febd1b1ee@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat 05-02-22 09:28:33, Tetsuo Handa wrote:
> Ping?
> 
> I sent https://lkml.kernel.org/r/20220129071500.3566-1-penguin-kernel@I-love.SAKURA.ne.jp
> based on ideas from your series.
> 
> Since automated kernel tests are failing, can't we apply
> [PATCH 1/7] loop: revert "make autoclear operation asynchronous"
> for now if we can't come to a conclusion?

That's certainly a good start so feel free to add my Acked-by to the
revert. I agree it should be merged quickly as I think it is better to have
a theoretical deadlock in the code than userspace breakage hit in the wild.
I'll find some more time to look into this but it will take a while.

								Honza

> 
> On 2022/01/28 22:13, Tetsuo Handa wrote:
> > On 2022/01/28 22:00, Christoph Hellwig wrote:
> >> +	if (atomic_inc_return(&lo->lo_refcnt) > 1)
> >> +		return 0;
> >> +
> >>  	err = mutex_lock_killable(&lo->lo_mutex);
> >>  	if (err)
> > 
> > You did not notice my diff here...
> 
> You need to drop lo->lo_refcnt before return.
> 
> But my latest series no longer uses task work context and no longer
> holds lo->lo_mutex from lo_open()/lo_release().
> 
> > 
> >>  		return err;
> >> -	if (lo->lo_state == Lo_deleting)
> >> +	if (lo->lo_state == Lo_deleting) {
> >> +		atomic_dec(&lo->lo_refcnt);
> >>  		err = -ENXIO;
> >> -	else
> >> -		atomic_inc(&lo->lo_refcnt);
> >> +	}
> > 
> > Why do we need [PATCH 1/8] [PATCH 2/8] [PATCH 3/8] in this series?
> > Shouldn't we first make a clean revert, and keep the changes for
> > this release cycle as small as possible?
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
