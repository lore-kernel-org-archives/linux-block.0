Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3E2C433EF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 15:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344983AbiFAPYE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 11:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244971AbiFAPYB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 11:24:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432888AE68
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 08:24:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D8ACC21A8E;
        Wed,  1 Jun 2022 15:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654097038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AyiT2oY+gB2FqHOjV2PgkuF9lOwFJLDJwS+MjU2NrCM=;
        b=iphn/I5MH113a6BFUBA/+oVNO/C+TTWD3JamEJgESDfdrk+8gCE9xSFFMhnZbBJo2DxgFk
        A7c/TZ9XML2b8iTG4iHuU1H4BV+JgJ1bZHaM6l9UknZsHwVQWSv43oPrPmFp/NFoKkMrN1
        pBIqqCZ6BEXzjTKnRRgYS7cQefCHr5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654097038;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AyiT2oY+gB2FqHOjV2PgkuF9lOwFJLDJwS+MjU2NrCM=;
        b=+nzmVBYUen1TCYNLwiEK2H6j9L8Aw+aBDCMmI+XHPmeGLznJqEqdQ7+RrtAGCaeqcclxKd
        tMEaj/r7NQTXhSBg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9ED622C141;
        Wed,  1 Jun 2022 15:23:58 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 56981A0633; Wed,  1 Jun 2022 17:23:58 +0200 (CEST)
Date:   Wed, 1 Jun 2022 17:23:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] block: Fix handling of tasks without ioprio in
 ioprio_get(2)
Message-ID: <20220601152358.lgmn52cpwdfa7mxq@quack3.lan>
References: <20220601132347.13543-1-jack@suse.cz>
 <20220601145110.18162-1-jack@suse.cz>
 <6d40bebc-2880-5290-16dc-2807e1db9e77@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d40bebc-2880-5290-16dc-2807e1db9e77@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 02-06-22 00:11:29, Damien Le Moal wrote:
> On 2022/06/01 23:51, Jan Kara wrote:
> > ioprio_get(2) can be asked to return the best IO priority from several
> > tasks (IOPRIO_WHO_PGRP, IOPRIO_WHO_USER). Currently the call treats
> > tasks without set IO priority as having priority
> > IOPRIO_CLASS_BE/IOPRIO_BE_NORM however this does not really reflect the
> > IO priority the task will get (which depends on task's nice value) and
> > with the following fix it will not even match returned IO priority for a
> > single task. So fix IO priority comparison to treat unset IO priority as
> > the lowest possible one. This way we will return IOPRIO_CLASS_NONE
> > priority only if none of the considered tasks has explicitely set IO
> > priority, otherwise we return the highest set IO priority. This changes
> > userspace visible behavior but hopefully the results are clearer and
> > nothing breaks.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  block/ioprio.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/ioprio.c b/block/ioprio.c
> > index 2fe068fcaad5..62890391fc80 100644
> > --- a/block/ioprio.c
> > +++ b/block/ioprio.c
> > @@ -157,10 +157,9 @@ static int get_task_ioprio(struct task_struct *p)
> >  int ioprio_best(unsigned short aprio, unsigned short bprio)
> >  {
> >  	if (!ioprio_valid(aprio))
> > -		aprio = IOPRIO_DEFAULT;
> > +		return bprio;
> 
> bprio may not be valid...

Yes, bprio may be from IOPRIO_CLASS_NONE as well and IMHO that is a
desirable return in that case. ioprio_valid() is IMHO a bit of a misnomer
because IOPRIO_CLASS_NONE is a valid class and can be even set by
userspace. It actually means, set IO priority based on task's CPU priority.
But lets first settle on the desired meaning of ioprio in the discussion
over patch 3/3. How we should behave in this case is a detail we can sort
out after the general meaning is clear.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
