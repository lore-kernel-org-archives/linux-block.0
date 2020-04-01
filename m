Return-Path: <SRS0=ADX+=5R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B661C43331
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 22:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9912078C
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 22:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585780530;
	bh=/5FpmWlMWmICyWRxNs0RcYPAIMNzs/gCOCOM8eYX+G4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JqfBdVPSV0P1+8nXmP+ITa4VOngtdJvHW8owznFX5szd+VZmUk+kcuJEH+Uz1Af+m
	 S2sFv3NK9WH2ERlIYBEjWU3oqtXeHgrOItRaZYrSO4NxMTzwtiY3kuOOS3H/hhguD7
	 dojpXHb7zX4ZucbpszKBZEr4Jhu5/9hmEVUS627Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733254AbgDAWf3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733264AbgDAWfW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Apr 2020 18:35:22 -0400
Subject: Re: [git pull] device mapper changes for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585780522;
        bh=/5FpmWlMWmICyWRxNs0RcYPAIMNzs/gCOCOM8eYX+G4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JZGDys/wgLZ1vH6JjBl438w2VjT74lJp34aH0N2ufoaei6UxzzgVmej9kT9WOzQox
         oFZFiCkVGgPQg4/x+yqFYG+FsTbi8/GjDy+8Ssb8Pebmpa2uhqfMxAOKj8+xSmfvPJ
         ZyyNOSWobscV1Xa6vj/IPSyq9OFJjjcCUEEsKY48=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200401165628.GA22107@redhat.com>
References: <20200401165628.GA22107@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200401165628.GA22107@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.7/dm-changes
X-PR-Tracked-Commit-Id: 81d5553d1288c2ec0390f02f84d71ca0f0f9f137
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffc1c20c46f74e24c3f03147688b4af6e429654a
Message-Id: <158578052225.24680.1741801346035155894.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Apr 2020 22:35:22 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Bob Liu <bob.liu@oracle.com>, Erich Eckner <git@eckner.net>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Harshini X Shetty <Harshini.X.Shetty@sony.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 1 Apr 2020 12:57:54 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.7/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffc1c20c46f74e24c3f03147688b4af6e429654a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
