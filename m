Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F49EEB580
	for <linux-block@archiver.kernel.org>; Sat,  9 Sep 2023 05:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242468AbjIIFFw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Sep 2023 01:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241968AbjIIFFv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Sep 2023 01:05:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD4A1BD3
        for <linux-block@vger.kernel.org>; Fri,  8 Sep 2023 22:05:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBE7BC433C9;
        Sat,  9 Sep 2023 05:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694235946;
        bh=k0BtkRgWP34dCML/ciKkRcs6t4JUb2KFfjnnB3ZDVtU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WPa+ucn3X3ctkOLWGba6sJaZDyCSkLXhP68nBcHrKoqb+mubUbRkNltvHrhkkFqUX
         N1z/bHWrw6e5TFk04cY3ABBgUi1PxFUcMq3GwUwnho4q8q5WfUqyZyjKsTTPtPy01J
         wY9IGI76R0hPvp0gTtzRUG4mpcSyDwO42z4ZHjJ+7jsPbHFuhcFZ/Hx+Mq9Z26Tba3
         5dJJaGHbMHzRrj/2JQdVi56gcnRDzP3qjG3N2QwYN4l4TAuxGMp6QXdVOVljclew9U
         ZthYLZHcrT4ziPKz0CCR25hjI32NoQCPfmQpLYHJAevH6LzWV9vPs0gpi9CJyjEHJa
         mWajVKc//jauw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA368E22AFC;
        Sat,  9 Sep 2023 05:05:46 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4cb29a92-f386-4ab1-b7c7-56aef11e35f2@kernel.dk>
References: <4cb29a92-f386-4ab1-b7c7-56aef11e35f2@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4cb29a92-f386-4ab1-b7c7-56aef11e35f2@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.6-2023-09-08
X-PR-Tracked-Commit-Id: 4b9c2edaf7282d60e069551b4b28abc2932cd3e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7402e635edb9b430125017d2489974c9a10b069c
Message-Id: <169423594669.31372.15535186619216258747.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Sep 2023 05:05:46 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 8 Sep 2023 09:08:53 -0600:

> git://git.kernel.dk/linux.git tags/block-6.6-2023-09-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7402e635edb9b430125017d2489974c9a10b069c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
