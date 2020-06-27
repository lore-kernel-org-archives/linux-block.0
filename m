Return-Path: <SRS0=phs8=AI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B05BC433DF
	for <linux-block@archiver.kernel.org>; Sat, 27 Jun 2020 16:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA3F520702
	for <linux-block@archiver.kernel.org>; Sat, 27 Jun 2020 16:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593273918;
	bh=LvXTsPdSp+bVnYeWQWLd/30sbOsD/vLr06RSXaJmN9s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=p7lVVFgvZY4V2dPo+vLO9SGMr1SGLmA5wnG05+WBkyDmvmGVYQxg4JJT0N66RPYrm
	 Sca06FHq2YxY/R1q0Lscna1GqmEoUxzcUcHTzWGLcgicGWsGZBMM7wZrIUPlPw0fGT
	 t5Wv1Uv0+YMWONrjJdkQypd8s36PhhZ+uyNSEE/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgF0QFQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Jun 2020 12:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgF0QFO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Jun 2020 12:05:14 -0400
Subject: Re: [git pull] device mapper fixes for 5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593273913;
        bh=LvXTsPdSp+bVnYeWQWLd/30sbOsD/vLr06RSXaJmN9s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qEE2HSoG7PoZHL6rHclB2MXvaaYaKBFUwQda876M7cy2ZgIb2jhr5446+tNekhZDw
         43OvLw6rUMCX1U++dcnDBqi4yTysw0KQm6ayxf6a7JGQ+suI+nw6+Qp9ZjB767I1uj
         KIc1Bobfsa8T/LePVIJo8ubYmUlAdc1OYjzRx+E0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200626192847.GA11459@redhat.com>
References: <20200626192847.GA11459@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200626192847.GA11459@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.8/dm-fixes
X-PR-Tracked-Commit-Id: d35bd764e6899a7bea71958f08d16cea5bfa1919
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e8eed279f280d6ad4cf59b3330d5d6d7b9de733
Message-Id: <159327391366.13835.5012151205727257026.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jun 2020 16:05:13 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hou Tao <houtao1@huawei.com>, Huaisheng Ye <yehs1@lenovo.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 26 Jun 2020 15:28:47 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.8/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e8eed279f280d6ad4cf59b3330d5d6d7b9de733

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
