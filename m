Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19EDC2BBCA
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 21:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E3823A63
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 21:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgLPVSv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Dec 2020 16:18:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbgLPVSv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Dec 2020 16:18:51 -0500
Subject: Re: [GIT PULL] Block driver changes for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608153490;
        bh=8vtBPh7VxNFbrDU//9/1PpH6GOLltlQWHcdt7iyYP08=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=omIeMvmaEjo7MSMvXtBoZZq7A4WwnxSYm6jFfqkLm9kd6o7iMjQm4tDCM46Plj30g
         LpjLG26Svpbf/keSw9XKJ2BKMjjaOndKG+fvjWlR/XrBfvk4kMJgMyocfEKCyKLSmn
         jkMCMyM8qniICblfiOcXMjMYYPfoaCIbp09EIsqSKblGAT7Vg+HPzsBTNZS1I1Mand
         ZcjsF2q4TzpZG2ROWmmz6gvfQ0BntsWLGdqY2/vG4Mu4kHjQY4B7FlYM5dsN3SLSrX
         xHSRqroSmx57Iatf5wAlxtaixzvbELoDfOhVQ5p6TnhIajQeQRbU34IN4zzyqNxnby
         LvPDUbdLrkOaA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8238bb43-756b-e0dc-2484-7e1e21928c0c@kernel.dk>
References: <8238bb43-756b-e0dc-2484-7e1e21928c0c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <8238bb43-756b-e0dc-2484-7e1e21928c0c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.11/drivers-2020-12-14
X-PR-Tracked-Commit-Id: aeb2b0b1a3da5791d3b216e71ec72db7570f3571
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69f637c33560b02ae7313e0c142d847361cc723a
Message-Id: <160815349067.27795.335880625354481718.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 21:18:10 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 08:30:44 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.11/drivers-2020-12-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69f637c33560b02ae7313e0c142d847361cc723a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
