Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2C8C433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 20:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25C220776
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 20:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592598336;
	bh=ZQok6hFw08bHEaCWxXCOl6IJa0RpRLBHOGqSvYfBhAA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=U5mXlH//NwO5ubjR6vgiAcoaNtRuyn1dJQihKePQQx/5VG2yDmllpMQ7Q7JKzpZv1
	 UKwXuX8Q/wZU18ireJO/tWkabuYpgsBO/KStJFPz2aA32rMXk7OFe224rneVJEVtjy
	 e1QsYC7NmhiP+dxkdrU7nyUz5K7D119vhimtn+ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbgFSUZg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 16:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389127AbgFSUZe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 16:25:34 -0400
Subject: Re: [GIT PULL] Block fixes for 5.8-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592598334;
        bh=ZQok6hFw08bHEaCWxXCOl6IJa0RpRLBHOGqSvYfBhAA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=M+OL3rFvmFdiwcwXoYO0gsg7gFML6sSlwRQPDF08vB03Uj33ABsGV/SDWEGGhL1Zy
         mxuWnttaeJvJ+6tnTdZ/ZaePWV9Crk2gtY/G8rYzhoAZjUrFesUQHKWGV+QByNhjQy
         lZ+8P3EEYh96EPNKND86a3jlUMEarRGAZJc1Kn0g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a0978751-6105-a269-2c58-de4d7229a646@kernel.dk>
References: <a0978751-6105-a269-2c58-de4d7229a646@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <a0978751-6105-a269-2c58-de4d7229a646@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.8-2020-06-19
X-PR-Tracked-Commit-Id: 3373a3461aa15b7f9a871fa4cb2c9ef21ac20b47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2b1c81f5f6c3427bd900be5fed306ca83d649d4
Message-Id: <159259833432.1498.6900938422581358347.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Jun 2020 20:25:34 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 19 Jun 2020 08:55:28 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.8-2020-06-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2b1c81f5f6c3427bd900be5fed306ca83d649d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
