Return-Path: <SRS0=s1xr=SI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA4DC282DC
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 01:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAA4218AC
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 01:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554514811;
	bh=pDVlXSToFgSK2myrT72rlLGN7uu/g6xD4cyoatKIv5E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PWNsNpdN7jNVwsu5fAnUY8sxr0Fay7J+0fhFmflE11I7SO5quqUIasjj+2ZXaFjO4
	 iMYcykm9TdvFLIJWjZqYAXd99EHZHx90hQ1858MUv1lf0rMHmVSAvbAlzm2et5dIk+
	 nGDnhG8JPROcyjxNKUkUWIlCDZ4l3lQmy9y84NK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfDFBkI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 21:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbfDFBkI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Apr 2019 21:40:08 -0400
Subject: Re: [git pull] device mapper fixes for 5.1-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554514807;
        bh=pDVlXSToFgSK2myrT72rlLGN7uu/g6xD4cyoatKIv5E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tsZVhTHCH7RONffVg9I026/wFBb5Jn5hWTiDY3uyCOZ5aIZ8wRgdn3pjB4AFUqS6Z
         Shkcy5LqnJ2TtFFe3B3CjOEygaMsPMZ4jbZvUVhBcfZpZVzIHvfSaeEfj1VrMS3s4f
         n5s6dFoWQKBLgKoIMHzLrU7Ut99qCF6AQmqKRUSI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190405225928.GB26473@redhat.com>
References: <20190405225928.GB26473@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190405225928.GB26473@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.1/dm-fixes
X-PR-Tracked-Commit-Id: 4ed319c6ac08e9a28fca7ac188181ac122f4de84
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f1cbe078546914538d8aabba04db984da68dcbf
Message-Id: <155451480788.21678.8266707604256803825.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Apr 2019 01:40:07 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 5 Apr 2019 18:59:29 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.1/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f1cbe078546914538d8aabba04db984da68dcbf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
