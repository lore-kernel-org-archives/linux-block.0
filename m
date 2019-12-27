Return-Path: <SRS0=cIu3=2R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA0FC2D0CE
	for <linux-block@archiver.kernel.org>; Fri, 27 Dec 2019 19:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79A020838
	for <linux-block@archiver.kernel.org>; Fri, 27 Dec 2019 19:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577475911;
	bh=jYueGD1i+k9BitJk8mTdHGzov62duh18sfC5hbZcR/Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WEMFKI4PTGcmSvXXvutlIHWmNEORzmDVUFZXa5YS998h048biSIJ/BTa0zyZPhiDE
	 XoHp6uojEGY404wHoCRgX6s3tG3KQ1XEUADS90En1kh1K3wnUEPmFDhDvWZx2SKLuN
	 tVS9JLZKX6uTDfIT75jq7p4A+KWz0nkE0MuUTjsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfL0TpK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Dec 2019 14:45:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbfL0TpK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Dec 2019 14:45:10 -0500
Subject: Re: [GIT PULL] libata fixes for 5.5-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577475909;
        bh=jYueGD1i+k9BitJk8mTdHGzov62duh18sfC5hbZcR/Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=veUrBADatWAIPMC7qRYLKqOOsIYFo2PfEA1rQTOE3kyLwLYoZe2pahs98YOuJQ+4U
         3L3STuP/cXaCmQQQuZsMnFh9RxG5EpgE22jdyiyb765by6dC83TBXCSo1epezT/tUN
         53lJtko7ZhIN6c11Z8HR5RzyM8fvPdFhj05uHctg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <465cf62f-2e8e-de03-fd02-f82e756db91c@kernel.dk>
References: <465cf62f-2e8e-de03-fd02-f82e756db91c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <465cf62f-2e8e-de03-fd02-f82e756db91c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/libata-5.5-20191226
X-PR-Tracked-Commit-Id: bf0e5013bc2dcac205417e1252205dca39dfc005
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f710a5572ea3a0fec36ad0b613f72144d99e830
Message-Id: <157747590992.1730.14864688430132517466.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Dec 2019 19:45:09 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 26 Dec 2019 11:19:02 -0700:

> git://git.kernel.dk/linux-block.git tags/libata-5.5-20191226

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f710a5572ea3a0fec36ad0b613f72144d99e830

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
