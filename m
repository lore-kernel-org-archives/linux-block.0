Return-Path: <SRS0=f2tN=46=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AC1C2BB1D
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 20:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FD020767
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 20:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584131110;
	bh=/CYn906CJsKokav2lZU6Xqnlgc461PnPTUnGXuZYvC0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nOJXi+/pbek0KT6mPFSTFoDUvltgCoDFQfXifQ4BKpQqpadb0NjmjSp7UXmk9n1It
	 CdLKVqV+cZ3MytMfF6EzZtjQddvqucSnQ/HFZ+04qV6ojTkBBZ51sX5eKREi+mcf9v
	 QlQJDpiOURSYTYdmqzSMWQtBFjmFQlE1CmEnBEuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgCMUZJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Mar 2020 16:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgCMUZJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Mar 2020 16:25:09 -0400
Subject: Re: [GIT PULL] Block fixes for 5.6-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584131108;
        bh=/CYn906CJsKokav2lZU6Xqnlgc461PnPTUnGXuZYvC0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iBF+rVPzOnQpmSsTopo34I2IdQbMxm538OEX7nu1LtDiafqYYuJdGXDwzcZd43/iE
         qaIrI+tmuoy5zuTq+R4941wVDdP6bElzOdURqHI+C68WJEXVmDbEwsC5X6564tin4k
         ffO+G2H6r0h/O5QFbEA7wT4hjLVB1K+z5I4z6Uxc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <37c30445-fd2a-f0a0-ae8b-f32c90f8c993@fb.com>
References: <37c30445-fd2a-f0a0-ae8b-f32c90f8c993@fb.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <37c30445-fd2a-f0a0-ae8b-f32c90f8c993@fb.com>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.6-2020-03-13
X-PR-Tracked-Commit-Id: b53df2e7442c73a932fb74228147fb946e531585
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17829c5a42f776463b305f8a9ccac55a3f473e1d
Message-Id: <158413110872.9951.1009626123211574261.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Mar 2020 20:25:08 +0000
To:     Jens Axboe <axboe@fb.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 13 Mar 2020 11:48:53 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.6-2020-03-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17829c5a42f776463b305f8a9ccac55a3f473e1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
