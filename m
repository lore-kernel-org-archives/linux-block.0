Return-Path: <SRS0=tXSx=YT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD40CA9EB9
	for <linux-block@archiver.kernel.org>; Sat, 26 Oct 2019 20:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE7420867
	for <linux-block@archiver.kernel.org>; Sat, 26 Oct 2019 20:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572122710;
	bh=Pucs2DUuqHmoaUP9TNzX28mecgxFhqDafyUMS0iWH9g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TLJqN6JNFIjoyjDZQjDPoHHbPJFdmt1Ixu2xY2M0OvBX1GkyLliUYMIFjhyalAaIR
	 byjKk2vIZHCmpRFESy0qD6L2pAyIDJNA2o/Sj/CjEQKkLgjA3WPKjxgGNoe2nO2V0M
	 lFIxgEcg26vZTdCQXfNzM8MqE7EKSkpyq6KI8zPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfJZUpJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Oct 2019 16:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbfJZUpJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Oct 2019 16:45:09 -0400
Subject: Re: [GIT PULL] Fixes for 5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572122708;
        bh=Pucs2DUuqHmoaUP9TNzX28mecgxFhqDafyUMS0iWH9g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y162vmJaELEZD76mrA7QI7fqvVGiGajh9WgZmYvvGlFEhc8XSRi7Vmny31A+76fwu
         h2xyGAlscGIvha2SfZOo0/QT7M1ky9ZHQ1BBoZS8/RcWhWSHTEqR+CDCv1a6vrvzfh
         e+QwFXy0v2FRkse4P5swisftwYANPgi9kppC0Vq0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c62a7e99-e230-f879-12b6-934a60db346c@kernel.dk>
References: <c62a7e99-e230-f879-12b6-934a60db346c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c62a7e99-e230-f879-12b6-934a60db346c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-2019-10-26
X-PR-Tracked-Commit-Id: cf1b2326b734896734c6e167e41766f9cee7686a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: acf913b7fb89f4313806ceb317d3730067f84f20
Message-Id: <157212270863.6077.5457900126870324369.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Oct 2019 20:45:08 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 26 Oct 2019 07:29:47 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-2019-10-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/acf913b7fb89f4313806ceb317d3730067f84f20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
