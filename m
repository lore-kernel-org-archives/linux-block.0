Return-Path: <SRS0=7zlQ=R2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE37C10F05
	for <linux-block@archiver.kernel.org>; Sat, 23 Mar 2019 18:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E2720880
	for <linux-block@archiver.kernel.org>; Sat, 23 Mar 2019 18:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553364015;
	bh=cqLE7s3YsePeCLbR9OXyn5HkRrFtF0J/8mynhYFojvk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=i+3cUJUDeRdvC+0Fzvjp9fhvuoZdaL5xKqzY7dEiEBmW3I8kICoMKfTZO4f6HvUy6
	 YmQTJ/e2bnTlt7VD1ZxcFnyo9f9F/jf2pyxsjtMWitwX3OHrOGCxc4w3KUGFCVGUZ+
	 YbJTjZlD1aqaaYA2FalOHpR2rYTj3XmNHofskWDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfCWSAN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Mar 2019 14:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbfCWSAN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Mar 2019 14:00:13 -0400
Subject: Re: [GIT PULL] Block fixes for 5.1-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553364012;
        bh=cqLE7s3YsePeCLbR9OXyn5HkRrFtF0J/8mynhYFojvk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XBd9UBxHJRVoXfy2Yh3tsK1PUgf8QP8Lb4+0HEPum35KHbIVsyVe5MitkrlrIHMBE
         SZvRirIeajyjfD/lwKkGTZPS5YR3RhF7wN4IECcl8c8j2EwE4jRG49jocShfIjDta0
         M+pgK9N9Ch+6EAnsDjSyq9ei+F5XFlVeuqos1C4w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <88dc23a0-2baf-6a56-36b4-6c8144d1ed7a@kernel.dk>
References: <88dc23a0-2baf-6a56-36b4-6c8144d1ed7a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <88dc23a0-2baf-6a56-36b4-6c8144d1ed7a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190323
X-PR-Tracked-Commit-Id: 1e4471e74c75acb3f89959ffa02a241227937ae2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2335cbe648e7163e78b3f85cd61816271d1a4313
Message-Id: <155336401258.30785.2699623196785390844.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Mar 2019 18:00:12 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 23 Mar 2019 09:55:40 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190323

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2335cbe648e7163e78b3f85cd61816271d1a4313

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
