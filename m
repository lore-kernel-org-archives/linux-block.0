Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968ABC433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 00:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJUAlg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 20:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJUAlc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 20:41:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCB21929B5
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 17:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E30EDB82A12
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 00:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9401FC43470;
        Fri, 21 Oct 2022 00:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666312876;
        bh=sjMEJyfH8MWdNIYZBtQhG8y6swTrPmZOnLTHOCoi1iE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rNP0bkOZrHr83ao63e42yMdTUfbTlY05OMFAE2u3tSgL4WwWdTlI+Lsgwcp330clq
         ieiKH30gTFZs7YRhE+h5Hva4vsAzEkDLyHepqb/P6VpEnm1jo+jlcJIYOfQhQF+Bg0
         5Tb9v/X4s/srJDgLjDnmwDDjtX8ZSp8j2N9TsxXaRawNjY9THLlC+gD8ENazCA00V3
         4aXbljsE1yFdL8rmGZJI9RgfP8+puj7xvPBW9iEUVkkveEFpJO7V+3La5f7wR6ZtxR
         3ky0m+nL5xwRFIq9zTV6whIYSZhXyFpxM+oEktNIujvD7JQZmV/pxoxhQIUbez+X+p
         Vm+BGb3BmSoYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76F98E270E5;
        Fri, 21 Oct 2022 00:41:16 +0000 (UTC)
Subject: Re: [git pull v2] device mapper changes for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y08ckqIVOmGVVX5e@redhat.com>
References: <Y08ckqIVOmGVVX5e@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y08ckqIVOmGVVX5e@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.1/dm-changes-v2
X-PR-Tracked-Commit-Id: 5434ee8d28575b2e784bd5b4dbfc912e5da90759
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3ccea6ed80db39e8aaed22d896099be477e1f85
Message-Id: <166631287648.10394.2603349767567364339.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Oct 2022 00:41:16 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shaomin Deng <dengshaomin@cdjrlc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 18 Oct 2022 17:37:22 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.1/dm-changes-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3ccea6ed80db39e8aaed22d896099be477e1f85

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
