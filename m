Return-Path: <SRS0=5dBz=7E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31137C433E1
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 19:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0FC8206D5
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 19:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590174310;
	bh=/l9ug4RNNj6plam+mBNHqbuqaqTOrziJ7khyCHS6/wI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nTTjJKtk8p1U3uRTg80DnnuO9I11HyqtvZXomioFDZbKH2eYWA0pD/zPFQtp9y02l
	 hnbzRL+yWu3XALWSKxUD9rfWQiKxkjViVK27uOBmEAvggPYTCJ7KM3G9cdnROrzmy3
	 JyroFhLMpjdJW98W0UbWv5EQgIQqriIaVNadC/7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbgEVTFG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 May 2020 15:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730894AbgEVTFF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 15:05:05 -0400
Subject: Re: [GIT PULL] Block fixes for 5.7-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590174304;
        bh=/l9ug4RNNj6plam+mBNHqbuqaqTOrziJ7khyCHS6/wI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EBlIJVCmKHuW6vKhvpDhZrxMYL+iO8xIq7khMPMdbGfvCbIeN31SogYijjjPjJ0Mb
         EK5j7pTbvqZLewOqPnljPaGGQbzz4JJiNEZyxDgZjjlkZfRllEwYGQgYIkBncn2WZy
         KBM5osGaHj6qcVV4UiAX6cp7FBqvBPYF9TF7u0NU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6efa4314-0dc4-8d77-0b28-bf53287cf6d0@kernel.dk>
References: <6efa4314-0dc4-8d77-0b28-bf53287cf6d0@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <6efa4314-0dc4-8d77-0b28-bf53287cf6d0@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.7-2020-05-22
X-PR-Tracked-Commit-Id: 1592cd15eec6e2952453f9a82da6e8a53e2b8db5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db9f384785b15e8569910c8e2ea1ffc83aedbff6
Message-Id: <159017430461.18534.8929748884009365528.pr-tracker-bot@kernel.org>
Date:   Fri, 22 May 2020 19:05:04 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 22 May 2020 11:08:36 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.7-2020-05-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db9f384785b15e8569910c8e2ea1ffc83aedbff6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
