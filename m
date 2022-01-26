Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4E5C2BA4C
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 13:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiAZNLw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:11:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44534 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiAZNLv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 08:11:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 917731F397;
        Wed, 26 Jan 2022 13:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643202710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hMWUGON7+qf9LukktHJUl+NX/SHkqoqJLOuI5liatFs=;
        b=IiYr+Wwxhk43GNQdyV8oOEpZkQZhfy4mnkxZnhc8SdpiKTAdKEjokPL20gk0WVr7vScKBI
        vqJKLk8f/19A8ZUwvodoj66syUW/4g5NPUEw7Ps7l9AfSLBVNu0CF6iPW6jnEN9TRzIl6d
        2Vjsir6ElcyfLRL5HnVwS06RvYUafFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643202710;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hMWUGON7+qf9LukktHJUl+NX/SHkqoqJLOuI5liatFs=;
        b=0XzifV7qoQld2Jf5oJElT+m9ezj9h+CllvSocZkartOLSTvEP8ceCDJ49FHoa01fDP1pFc
        gBDVByA/AGcCyYDg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 426DCA3B87;
        Wed, 26 Jan 2022 13:11:50 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A763DA05E6; Wed, 26 Jan 2022 14:11:48 +0100 (CET)
Date:   Wed, 26 Jan 2022 14:11:48 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3 1/5] task_work: export task_work_add()
Message-ID: <20220126131148.k5byj6p7fmgsmebw@quack3.lan>
References: <20220121114006.3633-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20220125154730.GA4611@lst.de>
 <ec15d9ef-a659-e4f0-fc3f-c75acaa0be2a@I-love.SAKURA.ne.jp>
 <20220126052159.GA20838@lst.de>
 <YfD1xo/bepV17ggx@T590>
 <bdb74587-c688-c326-332a-be0b3f2db844@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdb74587-c688-c326-332a-be0b3f2db844@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 26-01-22 19:27:17, Tetsuo Handa wrote:
> On 2022/01/26 16:18, Ming Lei wrote:
> > I remember it was to replace original loop_flush() which uses
> > wait_for_completion() for draining all inflight bios, but seems
> > the flush isn't needed in lo_release().
> 
> Even if we can remove blk_mq_freeze_queue()/blk_mq_unfreeze_queue() from
> lo_release(), we cannot remove
> blk_mq_freeze_queue()/blk_mq_unfreeze_queue() from e.g.
> loop_set_status(), right?

Correct AFAICT.

> Then, lo_release() which is called with disk->open_mutex held can be
> still blocked at mutex_lock(&lo->lo_mutex) waiting for e.g.
> loop_set_status() to call mutex_unlock(&lo->lo_mutex).  That is,
> lo_open() from e.g. /sys/power/resume can still wait for I/O completion
> with disk->open_mutex held.

I don't think this is a real problem. If someone is calling
loop_set_status() it means the loop device is open and thus lo_release()
cannot be running in parallel, can it?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
