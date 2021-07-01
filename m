Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E46C11F64
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 19:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9D53613FE
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 19:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhGATWf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jul 2021 15:22:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhGATWf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Jul 2021 15:22:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D4840613EC;
        Thu,  1 Jul 2021 19:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625167204;
        bh=VLJT2Xdoqc0I3Jrro/T15S4midXJ9xHTznWPbEmYHGM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sT+JGiTRRZtg1i99/Q4EBeYVyDYSmubjtSj8pMiAJbyMj4/VUv9ZBqgVFmVZq3PUu
         +0ysfcahM31XZ0ypQrmMK1szOt45op36i4UF/KyQwIPcWLztkttLSGzp9yIBw38Dlx
         EcGSzRkUUr8+s6fD5gEbmZRftxZRo78QTTCQXTJV63Fl1/OGpgFA0NnRJInf5dQpv1
         /bEr9gkJqb2IuLFpjxUmUpD+JfaZhzAPm/MRkpgdM+YeRvySzH/cqJ1BdWQW6X46k5
         Q6WIfT6Ih3iOpR8TOR7s4ITK8Kq5NqYnphPLzuFVj1/1DYA1q87Cy7K+VJ1IgV3Q7x
         lsdL6IJfmvenw==
Subject: Re: [dm-devel] [git pull] device mapper changes for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNyparaGoPleiSxX@redhat.com>
References: <YNyparaGoPleiSxX@redhat.com>
X-PR-Tracked-List-Id: device-mapper development <dm-devel.redhat.com>
X-PR-Tracked-Message-Id: <YNyparaGoPleiSxX@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.14/dm-changes
X-PR-Tracked-Commit-Id: 5c0de3d72f8c05678ed769bea24e98128f7ab570
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2cfa582be80081fb8db02d4d9b44bff34b82ac54
Message-Id: <162516720470.9429.1516660542564400927.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Jul 2021 19:20:04 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Joe Thornber <ejt@redhat.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Baokun Li <libaokun1@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        Alasdair G Kergon <agk@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 30 Jun 2021 13:27:06 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.14/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2cfa582be80081fb8db02d4d9b44bff34b82ac54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
