Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA8AC4320E
	for <linux-block@archiver.kernel.org>; Tue, 31 Aug 2021 02:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4288B6102A
	for <linux-block@archiver.kernel.org>; Tue, 31 Aug 2021 02:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbhHaCPW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Aug 2021 22:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239339AbhHaCPV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 22:15:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5B14E60240;
        Tue, 31 Aug 2021 02:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630376067;
        bh=5epJVIDMeaZVJ/8bIsyarLFq2miPHII6oywsVOeygQk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nE+6NvIo4pmu18LqnMRaf6lgtwCiomrVacZV0iqOhc+xzQzjd6DlQ2aS6ha12dtmg
         yfPXsZ9TahEVBOmfunzkN9QWRfJVQkinv+v135vQX+7tKrW8Beyvis9B9XE6Z58Lzb
         KVnMDYfdQgcLs3Oua+7ix8Cpli3iSShaFqLqpXTyrieP2h20YJNOwOyrt0xWQ3qcH3
         okJ2dk4hy4PtM0WtjVKXlRcKllLrhO26RC+ZYrULHeATDjSnokHEaPevL3fZWG80nO
         Nrwh209E5w5fkkEKa6y5lg4AaGfSIux0iJhGrRQMwiqFKqruguE1XvxweffFF+/0lt
         fi8i4lEPuTbGg==
Subject: Re: [GIT PULL] Block changes for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e1a3e2aa-ad96-c9c6-af38-16b7300a5612@kernel.dk>
References: <e1a3e2aa-ad96-c9c6-af38-16b7300a5612@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <e1a3e2aa-ad96-c9c6-af38-16b7300a5612@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.15/block-2021-08-30
X-PR-Tracked-Commit-Id: 1d1cf156dc176e30eeaced5cf1450d582d387b81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 679369114e55f422dc593d0628cfde1d04ae59b3
Message-Id: <163037606724.28323.13062568411793516059.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 02:14:27 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 08:32:27 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.15/block-2021-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/679369114e55f422dc593d0628cfde1d04ae59b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
