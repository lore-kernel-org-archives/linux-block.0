Return-Path: <SRS0=nOxH=S6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDA0C43218
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 18:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18A52063F
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 18:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556474710;
	bh=oSIqgtp9YV/ESsG6iW8b+AvrdU6fhr5hQ4mQW1DFAjM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QRmArnDZuxOZqpaw93mBEOs/8/mrltVFjncV5sRiSmRr5hVi3mxrFaKasSPTm1clG
	 /d2VO0vb8ZwyZwKgDf3rQsOSu64wPT3ViOb7cNp5HBc238jIMtuL6A8IHaYColjgTe
	 t6DU4gOMF7V4edRnGQXgBnfT2CxFL3cMdM0V6TIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfD1SFJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Apr 2019 14:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfD1SFG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Apr 2019 14:05:06 -0400
Subject: Re: [GIT PULL] Storage fixes for 5.1-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556474705;
        bh=oSIqgtp9YV/ESsG6iW8b+AvrdU6fhr5hQ4mQW1DFAjM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NpxqbM0REqja6Jw/lfg9egeJ1aMl76OiHBh1Mg/Dz8eOjFoBK+EFDYZOIMfzLhcMJ
         D9+rO4zrFh+t6oRLWT+KyLZGlNhVV63266SEgdtzWzqgTnJ8wASkwG0khgvBA8joOc
         2CH4cRfiHA6eV0RfX8MCC/6rPyUP4WjnuuDyETdo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <32d1cc79-7db1-6017-9626-2eb1845dd9e0@kernel.dk>
References: <32d1cc79-7db1-6017-9626-2eb1845dd9e0@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <32d1cc79-7db1-6017-9626-2eb1845dd9e0@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190428
X-PR-Tracked-Commit-Id: 8358e3a8264a228cf2dfb6f3a05c0328f4118f12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 975a0f400f2e1b5f585fec0b8b4c5942c3b05792
Message-Id: <155647470576.13942.11617822409534084138.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Apr 2019 18:05:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 28 Apr 2019 07:55:03 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190428

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/975a0f400f2e1b5f585fec0b8b4c5942c3b05792

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
