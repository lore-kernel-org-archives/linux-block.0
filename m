Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9586C433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 11:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380924AbiFQLts (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 07:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380744AbiFQLtr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 07:49:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201886CF63
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 04:49:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D18FD21E41;
        Fri, 17 Jun 2022 11:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655466584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2gN3b/XeduOP6lGjfat/dqXGbjxBoa47AZQul9x4E9Y=;
        b=1dzSs4qHwxQiFlK6nvtTsvQ8qib06/sm4kJXPYmW1Xwk1vg0vGAAo202FhdzApQ+doBfW2
        W4Imqjt1TT5EizY/QqmUbZ6991Dy8z2Pze5+2SFByAljCFcRsT78yxZqF5Rvs6Xcz4L9BF
        be8HrQz86TTl4SUD2cYz4O8uJUnBeOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655466584;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2gN3b/XeduOP6lGjfat/dqXGbjxBoa47AZQul9x4E9Y=;
        b=WAKLGDDpzYoZwZ64g2CqtWUTGTxQKELXDUnP1frp2NKVt/+XS6tF3Q8QvbWhDYO94hXbTL
        +QCU+p2C1SbuQTDQ==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4C9F82C141;
        Fri, 17 Jun 2022 11:49:44 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6F8D8A0632; Fri, 17 Jun 2022 13:49:33 +0200 (CEST)
Date:   Fri, 17 Jun 2022 13:49:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 8/8] block: Always initialize bio IO priority on submit
Message-ID: <20220617114933.vn3ffx5vqmjcbnsp@quack3>
References: <20220615160437.5478-1-jack@suse.cz>
 <20220615161616.5055-8-jack@suse.cz>
 <ece0af04-80c8-e0c3-702b-0d0d17f61ea9@opensource.wdc.com>
 <20220616112303.wywyhkvyr74ipdls@quack3.lan>
 <20220616122405.qifuahpn2mhzogwd@quack3.lan>
 <6dc7d961-7129-e143-01be-5d086bf7be43@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dc7d961-7129-e143-01be-5d086bf7be43@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 17-06-22 09:04:34, Damien Le Moal wrote:
> On 6/16/22 21:24, Jan Kara wrote:
> > On Thu 16-06-22 13:23:03, Jan Kara wrote:
> >> On Thu 16-06-22 12:15:25, Damien Le Moal wrote:
> >>> On 6/16/22 01:16, Jan Kara wrote:
> >>>> +	if (ioprio_class == IOPRIO_CLASS_NONE)
> >>>> +		bio->bi_ioprio = get_current_ioprio();
> >>>>   }
> >>>>   /**
> >>>
> >>> Beside this comment, I am still scratching my head regarding what the user
> >>> gets with ioprio_get(). If I understood your patches correctly, the user may
> >>> still see IOPRIO_CLASS_NONE ?
> >>> For that case, to be in sync with the man page, I thought the returned
> >>> ioprio should be the effective one based on the task io nice value, that is,
> >>> the value returned by get_current_ioprio(). Am I missing something... ?
> >>
> >> The trouble with returning "effective ioprio" is that with IOPRIO_WHO_PGRP
> >> or IOPRIO_WHO_USER the effective IO priority may be different for different
> >> processes considered and it can be also further influenced by blk-ioprio
> >> settings. But thinking about it now after things have settled I agree that
> >> what you suggests makes more sense. I'll fix that. Thanks for suggestion!
> > 
> > Oh, now I've remembered why I've done it that way. With IOPRIO_WHO_PROCESS
> > (which is probably the most used and the best defined variant), we were
> > returning IOPRIO_CLASS_NONE if the task didn't have set IO priority until
> > commit e70344c05995 ("block: fix default IO priority handling"). So my
> > patch was just making behavior of IOPRIO_WHO_PGRP & IOPRIO_WHO_USER
> > consistent with the behavior of IOPRIO_WHO_PROCESS. I'd be reluctant to
> > change the behavior of IOPRIO_WHO_PROCESS because that has the biggest
> > chances for userspace regressions. But perhaps it makes sense to keep
> > IOPRIO_WHO_PGRP & IOPRIO_WHO_USER inconsistent with IOPRIO_WHO_PROCESS and
> > just use effective IO priority in those two variants. That looks like the
> > smallest API change to make things at least somewhat sensible...
> 
> Still bit lost. Let me try to summarize your goal:
> 
> 1) If IOPRIO_WHO_PGRP is not set, ioprio_get(IOPRIO_WHO_PGRP) will return
> the effective priority

You make it sound here like IOPRIO_WHO_PGRP would be some different type of
IO priority. For record it is not, there's just one IO priority per task,
if you set ioprio with IOPRIO_WHO_PGRP, it will just iterate all the tasks
in PGRP and set IO priority for each task. After my patches,
ioprio_get(IOPRIO_WHO_PGRPIO) will return the best of the effective IO
priorities of tasks within PGRP. Before my patch it was doing the same but
if IO priority was unset for some task it considered it to be CLASS_BE,4.

> 2) If IOPRIO_WHO_USER is not set, ioprio_get(IOPRIO_WHO_USER) will also
> return the effective priority.

This is the same as above. Just the calls iterate over all tasks of the
given user...

> 3) if IOPRIO_WHO_PROCESS is not set, return ? I am lost for this one. Do
> you want to go back to IOPRIO_CLASS_NONE ? Keep default (IOPRIO_CLASS_BE)
> ? Or switch to using the effective IO priority ? Not that the last 2
> choices are actually equivalent if the user did not IO nice the process
> (the default for the effective IO prio is class BE)
 
I want to go back to returning IOPRIO_CLASS_NONE for tasks with unset IO
priority.

> For (1) and (2), I am not sure. Given that my last changes to the ioprio
> default did not seem to have bothered anyone (nobody screamed at me :)) I
> am tempted to say: any choice is OK. So we should try to get as close as
> the man page defined behavior as possible.

I also don't find (1) and (2) too important. (3) is IMHO somewhat important
and I think that the reason why nobody complained about the change there is
because your change is relatively new so it didn't propagate yet to any
widely used distro kernel...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
