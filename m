Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442A0C43461
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 19:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E776147D
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 19:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhEGTIp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 May 2021 15:08:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229724AbhEGTIn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 May 2021 15:08:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6538A61004;
        Fri,  7 May 2021 19:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620414463;
        bh=oqs/ZvbTJErmaz+MFkQAuPooEP0qPKkp/wpadcgdY6U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n4rT+KYhFlVwR/hThdlt79p/F4uyM3PIC80mAbke7FmNxKavX7KgfmEjL89Gj/P+G
         WyGpEkMPitWy6t7PKfH35/adMlpC2uwUvi6uGQh1n9cZbBSITajT2E4zG/Bd0PpqoQ
         sTu3ffon/eiKh/onAmtph/yert9sDBLU7FwOZyMjvU4SlEc2lzksUqXxH7NqGxed3S
         z1cY3k98Egc1I9sS1V2Weq3d8oY8R+LOyJS7noxUJQS84CzhS24vNesWH9HEpj0eSt
         0FvUWNmVRKHMwRiJWNUOzN3N+H7FvnjZv3Z3ERrouPnPU0DRC90fZm8G3QSY86gnuH
         ID0Apn3u+3pTg==
Subject: Re: [GIT PULL] Block fixes for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <237ad54a-fa95-fbb7-a7b7-0a7540928289@kernel.dk>
References: <237ad54a-fa95-fbb7-a7b7-0a7540928289@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <237ad54a-fa95-fbb7-a7b7-0a7540928289@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.13-2021-05-07
X-PR-Tracked-Commit-Id: cf7b39a0cbf6bf57aa07a008d46cf695add05b4c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd313968fd22f9e20b858e80424fa04bbcca7467
Message-Id: <162041446338.12532.6122425631562962096.pr-tracker-bot@kernel.org>
Date:   Fri, 07 May 2021 19:07:43 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 7 May 2021 09:59:48 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.13-2021-05-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd313968fd22f9e20b858e80424fa04bbcca7467

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
