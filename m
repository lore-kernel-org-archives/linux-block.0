Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1B3C04AAA
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 18:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF7320C01
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556821213;
	bh=ygfOKVpsP9sGXbrComAV1HNuXdLYGsbw5m3Cyf12VFY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IeEpYmXIebH5yJSFVg1+DoTd0u4dSmoXk9f4JwNre9EHGefAvnWG8qC+axudED58A
	 S0CI4Qs+wpwKRsMDgKDb2hHRYo8q1ak1rcPa1rm05XxIOpuqYQ+OgyDplF/YcOIns/
	 LURaq2JjYaqB0P8fVidKEZKrszdi2yyThfOQUfc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfEBSUH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 14:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfEBSUG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 May 2019 14:20:06 -0400
Subject: Re: [GIT PULL] Final fixes for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556821203;
        bh=ygfOKVpsP9sGXbrComAV1HNuXdLYGsbw5m3Cyf12VFY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bqJ7Qdu+glkuP5M+h27TCjzpCQ/EwQS7V69RnVME51eOW5RM1ikncXx1dXrHrJHxk
         WDuE+kvjikZkLL3cKgANJ+aXLX+Tfemnktg0sbIz+6aP7XNniCPeZK3HX6ksPUmHXJ
         JsKFIj1aNbWQG9bFXKUdqTvABXiwB7iPkbt/TMLc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3c185429-ae45-3152-572e-772d7bd54720@kernel.dk>
References: <3c185429-ae45-3152-572e-772d7bd54720@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <3c185429-ae45-3152-572e-772d7bd54720@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190502
X-PR-Tracked-Commit-Id: d4ef647510b1200fe1c996ff1cbf5ac47eb930cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ce3307b6d9d25fe3c62e4749821f5e58f9161db
Message-Id: <155682120372.31369.15279316065554688762.pr-tracker-bot@kernel.org>
Date:   Thu, 02 May 2019 18:20:03 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 2 May 2019 09:01:25 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190502

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ce3307b6d9d25fe3c62e4749821f5e58f9161db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
