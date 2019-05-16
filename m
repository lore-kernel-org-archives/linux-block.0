Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5536AC04AAF
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 23:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B7020862
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 23:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558049131;
	bh=a33eXdoPIV/rf1hMVq8mNzabQygu7Xb65PrKTrkKtuU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zU6IPLbG3+ZrQQV0PZE/JWMm2qOVpmpP8nT39gSsewuvoWFfORxYUvzx+BM0N8Cw6
	 dNHNRJsp0wvBCq9lLp22k8m5g9ZfHmycsZ+sqAcPHZs1AmvMZKEuNWxcnSAcW6y1Iv
	 iE8hy32YEyxHoeO8fNkVJOjiGZ7VbnwnyaIVliJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfEPXZa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 19:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbfEPXZa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 19:25:30 -0400
Subject: Re: [git pull] device mapper changes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558049129;
        bh=a33eXdoPIV/rf1hMVq8mNzabQygu7Xb65PrKTrkKtuU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GRUnnM2Jl9UsSqcHiQohR2TCW/nxF0uH573PnlLWsrNx60dgJ/qaEGp9YwGsGg8Vy
         Xlv+Ac4MD1RX8EX+roFU0XTtWn6yozTGfKiLafoFozBeWdK+zGXHaCEzHmLnTJ2Tuc
         xeC0WMzlmcMSwFoeUEL/dIz0jIappqVQHbevSRfM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190513185948.GA26710@redhat.com>
References: <20190513185948.GA26710@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190513185948.GA26710@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.2/dm-changes
X-PR-Tracked-Commit-Id: 05d6909ea9d62bb357846177a84842e09fc15914
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f41fcf78849c902ddca564f99a8e23ccfc80333
Message-Id: <155804912958.14244.15621348004778223895.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 23:25:29 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Bryan Gurney <bgurney@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Colin Ian King <colin.king@canonical.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Helen Koike <helen.koike@collabora.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Martin Wilck <mwilck@suse.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Peng Wang <rocking@whu.edu.cn>,
        YueHaibing <yuehaibing@huawei.com>, Yufen Yu <yuyufen@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 13 May 2019 14:59:48 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.2/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f41fcf78849c902ddca564f99a8e23ccfc80333

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
