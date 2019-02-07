Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8544C282C4
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 23:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A502175B
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 23:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549580712;
	bh=PXgERrSuVj26mXJsL3MBKXl2A455inw5ogt++djUpfg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yjTqvDUTSsBXenS1saWO3Tk+aUsDX927SIRzKX1KEjCDJo9w4UjHuVyhC3hURlo1I
	 9P6we38F2r5oJVSTe9AnsGl6I4omy21C5Ioz/Fo4DLD09eSr75Trw/sFc/BHdva9Gk
	 rP8uMV+8pLcXn4YF4xWainxdaBDO6wampXpMZXHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfBGXFL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:05:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbfBGXFF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Feb 2019 18:05:05 -0500
Subject: Re: [git pull] device mapper fixes for 5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549580704;
        bh=PXgERrSuVj26mXJsL3MBKXl2A455inw5ogt++djUpfg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=H1aP+AywcbOofg/w3V1tBATu4M8ZrFYAspPWhCMwgAb70fmMF2vPQKwT8eNNZcER+
         JpH8jjw3qpgdZajn4q2tsuyOENi0sMYLG60vtLuGYkECpGpP5e/814Gg7Dd7nkzrZQ
         bVoSdRfXQ2ArinwTUWI3X3LTI5AkqvAUroLW8ISM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190207165840.GA62096@redhat.com>
References: <20190207165840.GA62096@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190207165840.GA62096@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.0/dm-fixes-2
X-PR-Tracked-Commit-Id: fa8db4948f5224dae33a0e783e7dec682e145f88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b5cdbe595a05b8c767d9fe779bd47e997f934c9
Message-Id: <154958070489.8830.7144310025479746826.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Feb 2019 23:05:04 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 7 Feb 2019 11:58:40 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.0/dm-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b5cdbe595a05b8c767d9fe779bd47e997f934c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
