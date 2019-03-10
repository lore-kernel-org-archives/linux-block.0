Return-Path: <SRS0=4SCO=RN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8790C43381
	for <linux-block@archiver.kernel.org>; Sun, 10 Mar 2019 01:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917AC20815
	for <linux-block@archiver.kernel.org>; Sun, 10 Mar 2019 01:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552182320;
	bh=j7GczThTsgvTrsb9r/ecOeEWmA2qI9PDl2EnAIevtAs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nNBhF9u4X1p44wTMJaBnmfImMvlbX1JZQ3qZXnIxTuDMXnLXgpw1ChxRInctZ8G2O
	 g7t8nUBCFCd20UYz0XqInnPogeqyYsoEtH+QdB0c47dOmQulbh7hImqL6x+4rT/Nic
	 NXWqDyhkp3d/u7WSbnhC90+q8snmmW0HaBhOXUCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfCJBpT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Mar 2019 20:45:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbfCJBpT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 Mar 2019 20:45:19 -0500
Subject: Re: [git pull] device mapper changes for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552182319;
        bh=j7GczThTsgvTrsb9r/ecOeEWmA2qI9PDl2EnAIevtAs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QiXQLtvYj8/qJWL4vQsJubriW7yVpQsYRg3whMNnjbYvNJiG0LyOA+zYorVhNKtM4
         mobiMOm4KFRpQAR5qQGZYak1gNjSLTQzbp4L11EPIaQtfAVakSKtXAsvuDyUBOSKFG
         5MA7n2HC8YbOSuw9i92VIX+pBQbNWghzwOmWiR/U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190307162450.GA8985@redhat.com>
References: <20190307162450.GA8985@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190307162450.GA8985@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.1/dm-changes
X-PR-Tracked-Commit-Id: 225557446856448039a9e495da37b72c20071ef2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cdc577a18a616c331f57e268c97466171cfc45f
Message-Id: <155218231908.7195.12854925577578754305.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Mar 2019 01:45:19 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Chengguang Xu <cgxu519@gmx.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Helen Koike <helen.koike@collabora.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Jason Cai <jason.cai.kern@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        NeilBrown <neil@brown.name>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 7 Mar 2019 11:24:51 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.1/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cdc577a18a616c331f57e268c97466171cfc45f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
