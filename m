Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27B2C432BE
	for <linux-block@archiver.kernel.org>; Tue, 31 Aug 2021 22:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C45F561056
	for <linux-block@archiver.kernel.org>; Tue, 31 Aug 2021 22:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbhHaWum (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Aug 2021 18:50:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240492AbhHaWuk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Aug 2021 18:50:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A210B610A2;
        Tue, 31 Aug 2021 22:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630450184;
        bh=Li+/OY2/JxNT3svnasSUp9RCaY8cReM7pAD+dQdzN30=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AvDE9XN5LaUDeJ1tMHINYdsIkEbvNU2bsfOlLnmPw05RJnvQN2YwDzNApxBlhzIR6
         KTT0q6yuvpkgMnv3OrriVTLGngIQTFc/Zxre2JOK1/sOw5aYcHil4SOv7BD50pq2bD
         BTcxuJJRHNBAfMTyof8TnpvTbSNNshCXhj6ayTzwH/BOwxLIBcEH+d8uHBFb7JQSKB
         CcqxDgNlLcr50VEawZMFcyiqmgUVecKMzFOR/4lwSW4VjdWNgALzdflSxuOqDVf+11
         wPk2EDZ8XDT2WNuhEat/7Cepwkdi41APmo/scg4OPvv5WIkIKsgcyM9sPnkDoe2mkD
         YPxx1PcfwY9kw==
Subject: Re: [git pull] device mapper changes for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YS5aLC4FSqL31PLI@redhat.com>
References: <YS5aLC4FSqL31PLI@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <YS5aLC4FSqL31PLI@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.15/dm-changes
X-PR-Tracked-Commit-Id: d3703ef331297b6daa97f5228cbe2a657d0cfd21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efa916af13206eb15916e102c45c99a13ea78f33
Message-Id: <163045018463.32002.7512936844641360922.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 22:49:44 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Arne Welzel <arne.welzel@corelight.com>,
        Changbin Du <changbin.du@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 12:34:52 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.15/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efa916af13206eb15916e102c45c99a13ea78f33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
