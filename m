Return-Path: <SRS0=HzVw=UO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D65C31E50
	for <linux-block@archiver.kernel.org>; Sat, 15 Jun 2019 15:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0AA20673
	for <linux-block@archiver.kernel.org>; Sat, 15 Jun 2019 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560613862;
	bh=VwEnFPebzPhfi2mwt6LUlCkM/lpE4dSRxYoSL75kKRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ygdwWux/HezdVJYc8gmqw9FywG0uFSb+zdoIMI1wE2h5+/whlzXP7P66ab/6A9mBJ
	 Lm97X9A9EcdpbR35rAIUvXAYLgN7rlbAcv0sH8Fp1aPaM6wdE/H6YcOqboCnP3PV09
	 l+vp61EbxdkZc7by3BytWUuZda8xkWr4fKiSr22A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfFOPvB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Jun 2019 11:51:01 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:45582 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfFOPvB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Jun 2019 11:51:01 -0400
Received: by mail-qt1-f175.google.com with SMTP id j19so6024945qtr.12;
        Sat, 15 Jun 2019 08:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FRzed5Hn746STY3Jn1Vo7AmbqOd5utzWg8eosdJW/6k=;
        b=JpNpW9yyNPMPd3JVLXskBsuaQGQXPcqQEzxepyVxim0aReQclp0mx6GTbHFViCTdjy
         aekVO97SE9eFL8c0GH+PBYc4L0qm0g9s4ul64DOCJeEgiubQVcbePuPDi2MVE4zFORlh
         UXA8VuGlFzNmy09xLrjviSIYCKcZE5Z5yUAfcYg303mgaE5vfbWWuV4rO/fnHScnRtq3
         SP7lMQieg+/hVSLMl6DDMLGfzKFF0Bc36bcu+5voP9bERAi3h5e3wsIuNXtpswhFw/7K
         kkyPDbAx5gKngVZYfnHTlidETdJHvmyv3mXlLPHRNEN3r4xunT1RSLIe1EhNxWXlgq9E
         SZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FRzed5Hn746STY3Jn1Vo7AmbqOd5utzWg8eosdJW/6k=;
        b=Cg3g4AqRVR1S1wBYuBTb0/1U+CEDjlINKxZ7JuKzhFcatRlrk2FYGBz9gsqb9yc3T+
         Xb/hypRNbnQhE7hoIc8hffzRvcksIsdyo8715MLH3LKq3XuK2issYBC/d3oB1LYHT0T7
         7LiWmUq6syJ64ll+nyXyJVlLTagkB8qQZm7Ihpy3MklthefxI+i5D2tcSnmOkrt9eyNc
         cURgaQDBEou6EM7uLLd6LQw1hXdVYGKI/tnCjvI1T37Y12Je9VfZzDqsjF5GIpd8K36s
         PjoLSj/JY+OYHXts4uEcI7+6JENoyx4m38DDPMisPyQo5Z83iFd4deAPAglTLUKFtql0
         FnmA==
X-Gm-Message-State: APjAAAVdzifTjczhLHu2lPOdMZUAaBXg2aimqpbpAp2Of61XKG0HiMaM
        /Ib8PrlqxgL8agAidNYpM/Y=
X-Google-Smtp-Source: APXvYqwSd08QU/s59USkejLBKf+YmKKH56HxmDM0ZXlLrhzdKfSCJWF0VhO8fcG438Nk1o55sB/TBA==
X-Received: by 2002:ac8:2d82:: with SMTP id p2mr9501333qta.130.1560613859979;
        Sat, 15 Jun 2019 08:50:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::673a])
        by smtp.gmail.com with ESMTPSA id n48sm3833013qtc.90.2019.06.15.08.50.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 08:50:58 -0700 (PDT)
Date:   Sat, 15 Jun 2019 08:50:55 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     jbacik@fb.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com, dennis@kernel.org,
        jack@suse.cz
Subject: Re: [PATCHSET block/for-linus] Assorted blkcg fixes
Message-ID: <20190615155055.GE657710@devbig004.ftw2.facebook.com>
References: <20190613223041.606735-1-tj@kernel.org>
 <5d5835d3-d0e4-f4cc-19b1-841b4ad46a9a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d5835d3-d0e4-f4cc-19b1-841b4ad46a9a@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Sat, Jun 15, 2019 at 01:40:50AM -0600, Jens Axboe wrote:
> > Please refer to each patch's description for details.  Patchset is
> > also available in the following git branch.
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-blkcg-fixes
> > 
> > Thanks.  diffstat follows.
> 
> Are you fine with these hitting 5.3?

Yeah, none of them are very urgent.  5.3 should be fine.

Thanks.

-- 
tejun
