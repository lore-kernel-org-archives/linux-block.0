Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C676C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 21:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F09920851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 21:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544735727;
	bh=q/fbIsW50/A7eBH6HpAJgwi04LnHDMNyDMnzqj5/MEw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=f8q3E19BoCyF6rAUP7nb7ByuHnBSgyd/xla+87hR+NfB6jt7JDUATsZReFFdhRKAa
	 lIujReW7DXnZkAOlh1WvZfJDAxN70Hteib427/ResUtlM0mOzLD9RHCfMCIT8/yJ8p
	 se+P42rf9+WLqUUtC5R2tjizVvjQSzcenQ3lrX8k=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F09920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbeLMVPZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:15:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbeLMVPE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 16:15:04 -0500
Subject: Re: [git pull] device mapper fixes for 4.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544735703;
        bh=q/fbIsW50/A7eBH6HpAJgwi04LnHDMNyDMnzqj5/MEw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=w2eFGQwHVQfCjO9+xsmW1PBoCybA1JcRut4n4hugTP29EcZ1+YCvtBGp3kbM7lQUZ
         8h9hezGOaivnNtbEIOCCU1bJBvDlUxO9BsW5Hn9sK09AAo1juG2mD2eu2HTaMx5WKE
         MQQI6vJFqAmTpCofBC4LwVu7C222ISuIEuvS2vkc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181212175648.GA25049@redhat.com>
References: <20181212175648.GA25049@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181212175648.GA25049@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-4.20/dm-fixes
X-PR-Tracked-Commit-Id: 2af6c0703d75fc3ff2e6de19b4b3adab96acc12d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67f2a93099cca369c056e591c82f1d1bc726c945
Message-Id: <20181213211503.3163.75438.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 13 Dec 2018 21:15:03 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 12 Dec 2018 12:56:48 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-4.20/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67f2a93099cca369c056e591c82f1d1bc726c945

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
