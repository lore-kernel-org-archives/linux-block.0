Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF62C433ED
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 22:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FFE86143E
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 22:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhD1WZl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 18:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231607AbhD1WZk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 18:25:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4FE456143D;
        Wed, 28 Apr 2021 22:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619648695;
        bh=nVan7G1ch53kCV8IpWuQbmyPH7i0/QvhlV2WOGpybrY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oX/h32fsbA3hBYbPJ/uqM93VGvfAldDWiXYAaacUI9hfvbuy967U2kfU3jLK+7iBX
         BwYOfDiO03wr+1PqPKgAg5fXOw7MP13yYyCg/x6zvaDsi8utnXEHHrbkAANXO4i2Ku
         FLpUOvHncB5e7R44Rv0t4KGn4GcuaOWnfCXM4ZvJO6BaXpNaE4vehMS+e98bjORJ43
         lufWX/Zjv5lR7hohMZ2LN+nZWlYbmRUwq8QbrapCZeDxtARnnoSFq9Do6cwQSQpxM4
         PxnG9tUt02OkZ6yFVGnQSo/Ls3fX8qSI1AgJbvU8rL/vZVm6ehVl2aVfEuPKqs+r+f
         Jq8+mN5lLnX1A==
Subject: Re: [GIT PULL] libata changes for 5.13-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7a48da22-ec0b-f22a-bc0d-4ad76f712ef0@kernel.dk>
References: <7a48da22-ec0b-f22a-bc0d-4ad76f712ef0@kernel.dk>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <7a48da22-ec0b-f22a-bc0d-4ad76f712ef0@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.13/libata-2021-04-27
X-PR-Tracked-Commit-Id: e06abcc68cb555377efd5aa781c014d3d68498b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c05a182bf45681c5529a58c71ce5647535b3ae7a
Message-Id: <161964869517.18647.18031003209958254458.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 22:24:55 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 27 Apr 2021 11:00:09 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.13/libata-2021-04-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c05a182bf45681c5529a58c71ce5647535b3ae7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
