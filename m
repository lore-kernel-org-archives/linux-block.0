Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE1EC64E75
	for <linux-block@archiver.kernel.org>; Sat, 14 Nov 2020 00:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 833302224D
	for <linux-block@archiver.kernel.org>; Sat, 14 Nov 2020 00:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgWPWkiw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgKNAPL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 19:15:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgKNAPJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 19:15:09 -0500
Subject: Re: [GIT PULL] block fixes for 5.10-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605312909;
        bh=k+SL45Dp9JFN8z4KiG3MLsbKg6tFwX1quCw7GfyoByg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IgWPWkiwrufnNsAJyEtxCR7IOf/Y0nXzlSIBpe4t8YoU7/GMEhgjOiSrrU5JPm2k1
         0KUnCPhqEnI6mlKBBue9SG43lA7Aiz/2BlmAVsvHmn9lgWIB9l1CyabKsDNqpbXEOY
         sMUF2tBpG/VZ5s8BRY2/cTctgvXflbnD9SG0t4wI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <dfbd8f5c-f72b-2341-0c26-546d924d5e4e@kernel.dk>
References: <dfbd8f5c-f72b-2341-0c26-546d924d5e4e@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <dfbd8f5c-f72b-2341-0c26-546d924d5e4e@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.10-2020-11-13
X-PR-Tracked-Commit-Id: c01a21b77722db0474bbcc4eafc8c4e0d8fed6d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5dea9c0ab62a11bb52e6fa91c7d7e26d6ae8ec1
Message-Id: <160531290914.27270.18404234507672472560.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Nov 2020 00:15:09 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 13 Nov 2020 14:21:15 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.10-2020-11-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5dea9c0ab62a11bb52e6fa91c7d7e26d6ae8ec1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
