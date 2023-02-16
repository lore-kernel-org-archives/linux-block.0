Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFD8C636CC
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 20:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjBPUXi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 15:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjBPUXg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 15:23:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1752F39BBC
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 12:23:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD93DB829A5
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 20:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69B5CC433EF;
        Thu, 16 Feb 2023 20:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676579014;
        bh=rvQwcttV74HOlXA0JvIqJumUdgq1qaqv20x+WTPRL40=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qi/BWSvsiW7VtZKy3Udhe6HC6SOqOoZP4cuUnopvvn227EM8bqVIN5tZNos4Vkcqw
         k+6rZo+veN5P5r3igUDzJ07k51ps00GBOlYmXcnQXlBg4H8HZoUZkCGzofIi4lXlg8
         FLIGuYdRTPThPgHb+/LDz1OpCn1M50RRTgui7CZLB+v+JcAyCscUOySOZtriFZSU6q
         jed7721m/BEGfL01fKk7D68F7LJWkOTC+Z/gth/+oZZE9jJQf1Qbtt2eKOLXglzuBD
         O4R3+JacK7UCoVfWkKQEPTOHd5KTVx/Gih89nQ9SsBfD3wgDr/fo/Qun0Nm7LRO9QB
         e7dWLLWZ0YkWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56BE5E21ED0;
        Thu, 16 Feb 2023 20:23:34 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 6.2-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <16738d14-6c97-c344-e096-50f4f6cce0e7@kernel.dk>
References: <16738d14-6c97-c344-e096-50f4f6cce0e7@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <16738d14-6c97-c344-e096-50f4f6cce0e7@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.2-2023-02-16
X-PR-Tracked-Commit-Id: 9a28b92cc21e8445c25b18e46f41634539938a91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3d6f0eb086d3d68960ded479e846e7dcfcec2bb
Message-Id: <167657901434.10840.8639985546717090318.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Feb 2023 20:23:34 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 16 Feb 2023 12:26:48 -0700:

> git://git.kernel.dk/linux.git tags/block-6.2-2023-02-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3d6f0eb086d3d68960ded479e846e7dcfcec2bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
