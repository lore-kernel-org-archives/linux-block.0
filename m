Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FB9C43334
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 08:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347418AbiFUIQH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 04:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348088AbiFUIQC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 04:16:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D0024950
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 01:16:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7EAA71F966;
        Tue, 21 Jun 2022 08:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655799359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2vdQBwCz2q+Hx4iCsPuHw/yCvlmFeUZdLaz5OsvV4d8=;
        b=WDag/8N0CDK8yHkx+RX+NOa/y4O3fygM2pgwnUbJDe6KEslYv4HbH1Yl4JNHWK2joEh1hk
        uo6pN2UwzyYm7opbxynSMwVMSo+fgJKKfWq5o+kgXqWA6A8zefZjPZmKYeRgrAPwVk4p2O
        tdA3z/VWue4Hsfkq9gm54KFO0hrLi6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655799359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2vdQBwCz2q+Hx4iCsPuHw/yCvlmFeUZdLaz5OsvV4d8=;
        b=XJyNgloQ9WpLRSV5fEiwHPW++50rNxiOXm/9K1KD6SiUsi7sSPczcfu+ZX0o0kWpmOsiVK
        MQNOMW/s1ZQ5/6Bg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2B2592C141;
        Tue, 21 Jun 2022 08:15:59 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3802DA062B; Tue, 21 Jun 2022 10:15:58 +0200 (CEST)
Date:   Tue, 21 Jun 2022 10:15:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH 4/8] block: Fix handling of tasks without ioprio in
 ioprio_get(2)
Message-ID: <20220621081558.6pzyqb67hgjncomm@quack3.lan>
References: <20220620160726.19798-1-jack@suse.cz>
 <20220620161153.11741-4-jack@suse.cz>
 <7124bdba-e295-83d4-6346-9e9420062a0f@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7124bdba-e295-83d4-6346-9e9420062a0f@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 21-06-22 08:57:29, Damien Le Moal wrote:
> On 6/21/22 01:11, Jan Kara wrote:
> > ioprio_get(2) can be asked to return the best IO priority from several
> > tasks (IOPRIO_WHO_PGRP, IOPRIO_WHO_USER). Currently the call treats
> > tasks without set IO priority as having priority
> > IOPRIO_CLASS_BE/IOPRIO_BE_NORM however this does not really reflect the
> > IO priority the task will get (which depends on task's nice value).
> > 
> > Fix the code to use the real IO priority task's IO will use. For this we
> > do some factoring out to share the code converting task's CPU priority
> > to IO priority and we also have to modify code for
> > ioprio_get(IOPRIO_WHO_PROCESS) to keep returning IOPRIO_CLASS_NONE
> > priority for tasks without set IO priority as a special case to maintain
> > userspace visible API.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>

...

> > +/*
> > + * Return raw IO priority value as set by userspace. We use this for
> > + * ioprio_get(pid, IOPRIO_WHO_PROCESS) so that we keep historical behavior and
> > + * also so that userspace can distinguish unset IO priority (which just gets
> > + * overriden based on task's nice value) from IO priority set to some value.
> > + */
> > +static int get_task_raw_ioprio(struct task_struct *p) { int ret;
> 
> The "int ret;" declaration is on the wrong line, so is the curly bracket.

Huh, don't know how that got messed up. Anyway fixed. Thanks for noticing.

> > +
> > +	ret = security_task_getioprio(p);
> > +	if (ret)
> > +		goto out;
> >  	task_lock(p);
> >  	if (p->io_context)
> >  		ret = p->io_context->ioprio;
> > +	else
> > +		ret = IOPRIO_DEFAULT;
> >  	task_unlock(p);
> >  out:
> >  	return ret;
> > @@ -156,11 +196,6 @@ static int get_task_ioprio(struct task_struct *p)
> >  
> >  static int ioprio_best(unsigned short aprio, unsigned short bprio)
> >  {
> > -	if (!ioprio_valid(aprio))
> > -		aprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM);
> > -	if (!ioprio_valid(bprio))
> > -		bprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM);
> > -
> >  	return min(aprio, bprio);
> >  }
> 
> This function could be declared as inline now...

Yeah, but compilers inline (or not inline!) static functions as they see
fit anyway. So 'inline' keyword for static functions is generally a noise
which is why I just avoid it. But please let me know if you feel strongly
about that.

> >  static inline int get_current_ioprio(void)
> >  {
> > -	struct io_context *ioc = current->io_context;
> > -	int prio;
> > -
> > -	if (ioc)
> > -		prio = ioc->ioprio;
> > -	else
> > -		prio = IOPRIO_DEFAULT;
> > -
> > -	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
> > -		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(current),
> > -					 task_nice_ioprio(current));
> > -	return prio;
> > +	return __get_task_ioprio(current);
> 
> The build bot complained about this one, but I do not understand why.
> Could it be because you do not have declared __get_task_ioprio() as "extern" ?

No, likely it is because !CONFIG_BLOCK kernel does not have ioprio support
but something uses the get_current_ioprio() anyway. I'll fix it up.

> Also, to reduce refactoring changes in this patch, you could introduce
> __get_task_ioprio() and make the above change in patch 2. No ?

OK, I will move some refactoring.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
