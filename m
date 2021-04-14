Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DEEC433B4
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 20:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7316E61158
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 20:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhDNU0S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 16:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349848AbhDNU0N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 16:26:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3A7FE6044F;
        Wed, 14 Apr 2021 20:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618431952;
        bh=fxoMNQ9XDS7ExZPWw4OwHrgiReYPu8Je32YKTJSO4iI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AN6TMABNZASvP+oJu6uPquobmDGlS+c+fJVsDAvVur3aEh4vwzkVyUwy7lcB0YerK
         3QInfgikonuLFjHPgcnhaaFtcFp0Wo0rF9iVzn5Y3TXu0ZTTeHFs59eva+rm/rnULn
         v1IvW5w29+Aso2TkEzPFsLxLTCZ7yKbwbTJi52cFPyJoWBqtYRuBaJ/HU+kQe1gY/P
         eNenR1jV1YW8jneUDeD7SNyMbC67kRH6DsAzAenrubyIlKBdXAXYBpp92KMmdrjm6l
         AfAEJYumrYhgqshRBXxxCH+0ParExSEDbi6rye6G6f6NsHp7hcnf2GfqB/0oZ4lDx+
         R1GRPslkq8LMA==
Subject: Re: [git pull] device mapper fix for 5.12 final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210414184007.GA8824@redhat.com>
References: <20210414184007.GA8824@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210414184007.GA8824@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.12/dm-fixes-3
X-PR-Tracked-Commit-Id: 8ca7cab82bda4eb0b8064befeeeaa38106cac637
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f75285ca572eaabc028cf78c6ab5473d0d160be
Message-Id: <161843195211.17968.8724252519934154319.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Apr 2021 20:25:52 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Jaegeuk Kim <jaegeuk@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 14 Apr 2021 14:40:07 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.12/dm-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f75285ca572eaabc028cf78c6ab5473d0d160be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
