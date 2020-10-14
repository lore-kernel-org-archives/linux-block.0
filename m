Return-Path: <SRS0=vf5w=DV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693EBC433DF
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 23:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1801F2145D
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 23:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602716531;
	bh=fQ83MExNUBVx7iZYFIo32GiSVLRlsqbZPTKoOCNQVDc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=THWNMhSztCpqa/gp3OzK87L/QjdoukPFC4Zf8OjkAfAq+YQxHnK5xBhhHyBlC3O1d
	 dpQnd+fwule2jglHQNexVwQqdR/+rTQvWG9dXGWjMgoxvTPnxYZhtd3ijERx9W9oDq
	 f/W2UW7AD3U8//e6hdgIAsdYwE8y6INQIvFkQjUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgJNXCK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Oct 2020 19:02:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgJNXCK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Oct 2020 19:02:10 -0400
Subject: Re: [git pull] device mapper changes for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602716529;
        bh=fQ83MExNUBVx7iZYFIo32GiSVLRlsqbZPTKoOCNQVDc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=L2ltkoi5dv/y0wCB9idmZU+kZjSlzT9R3kHPJIAnX1mBbZoO8yN6BVXkfLrgAQrqs
         qe8HP0gOEqNehGoZ8DR+mZli6FRNRIqFgFWGX6yOuOIAPrYxkPElEyXx4eABfiLo8N
         xqGB33qULNQKO15k0MgP+KKZHA1QT5BleJ1VJNWg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201013154000.GA53766@lobo>
References: <20201013154000.GA53766@lobo>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201013154000.GA53766@lobo>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.10/dm-changes
X-PR-Tracked-Commit-Id: 681cc5e8667e8579a2da8fa4090c48a2d73fc3bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4815519ed0af833884ce9c288183bf1ae3cb9caa
Message-Id: <160271652985.18101.15440005975175979893.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 23:02:09 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Qinglang Miao <miaoqinglang@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 13 Oct 2020 11:40:00 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.10/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4815519ed0af833884ce9c288183bf1ae3cb9caa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
