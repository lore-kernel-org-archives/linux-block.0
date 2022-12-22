Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64555C10F1B
	for <linux-block@archiver.kernel.org>; Thu, 22 Dec 2022 03:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiLVDHe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 22:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbiLVDHd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 22:07:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEEA1181E
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 19:07:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F139619C6
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 03:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13FE6C433D2;
        Thu, 22 Dec 2022 03:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671678452;
        bh=dthrsJy1CDx6XemMvwwzAW1QzJjaEHsOjKN6xNcRaUc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kn3gfbixW9mLinABHTdWp4FDZZtXihws06gFme1wtXouXSrq/brzYdW9c8+Igi55L
         XmWEE0by5Xqyr1lYFCPsbrzV2KNSVxnR5JAo4MWxHFwyQWbIZXRrm0AySwGonta0q4
         FsayRkUmxv/FID14ISFQpT39sDJHORSbU6EGfQkcrjYiulqup1sK5eHyso+st47HGx
         5yH0sYUIMyAAevPHonMEjrM17Gat1/OYqyRZ6HCzeZ10BNI4AglgQvTGJdeMPzCEfi
         pI5qw3ytvHRTQ9Ms9FT6aaiuVHnHLer6i2ot/8xiV32im03IlGFUxBTKTH2HGZ8GkV
         4tupoKHQtZuwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02BEDC43141;
        Thu, 22 Dec 2022 03:07:32 +0000 (UTC)
Subject: Re: [GIT PULL] Followup block fixes for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b4f6146f-6bbf-c58a-21fd-a03acb28c4a0@kernel.dk>
References: <b4f6146f-6bbf-c58a-21fd-a03acb28c4a0@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <b4f6146f-6bbf-c58a-21fd-a03acb28c4a0@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.2-2022-12-19
X-PR-Tracked-Commit-Id: 53eab8e76667b124615a943a033cdf97c80c242a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 569c3a283c96a9efbf7ee32dda10905b8684de07
Message-Id: <167167845200.12654.6861677566544805638.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Dec 2022 03:07:32 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 20 Dec 2022 08:17:32 -0700:

> git://git.kernel.dk/linux.git tags/block-6.2-2022-12-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/569c3a283c96a9efbf7ee32dda10905b8684de07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
