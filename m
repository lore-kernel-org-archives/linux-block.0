Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B34C433E0
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 22:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CB5207B6
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 22:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgLVWZY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Dec 2020 17:25:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728082AbgLVWZX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Dec 2020 17:25:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4843422AAF;
        Tue, 22 Dec 2020 22:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608675847;
        bh=LLWRexMic9hcgXSL/twghqJayLAgEN4QDR4cmxGokGc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GAPAGtl8N+hO3xGeeXE6Fw9/cipDpreItyvYwisMcZXofoeZgsraClwdGuGnlZtRU
         MHyfcxvkUVhtbNkzvlm906tMQ/qVP9rctjdvPycNpXMdmAFKAQIdJvOjmtDF/buc/A
         2HuWfpWUZg5HYZ1SLiXAQ9SQ82sSaKLjM1sNobbW8DZehn9Ar4Mqwm5QWVMzu8sjU1
         cBAF4ucZ3HgBbFyW7zO+9cNC0PvAfemglS5MWybn0x4uSA/uogZYi4BYFd7J0U4bpX
         1GsKDDKaLs22ondqGjMMIECzx3Yhjj8jue4ogdvkiELwPAdovkWkTIn6Vu+FkzzrzC
         N66FnefC6ANuA==
Subject: Re: [git pull] device mapper changes for 5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201222151823.GA17999@redhat.com>
References: <20201222151823.GA17999@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201222151823.GA17999@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.11/dm-changes
X-PR-Tracked-Commit-Id: b77709237e72d6467fb27bfbad163f7221ecd648
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8355e740f419a081796e869bafdfc0756b0bf2a
Message-Id: <160867584726.8550.13161305291113777694.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Dec 2020 22:24:07 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Antonio Quartulli <a@unstable.cc>,
        Hyeongseok Kim <hyeongseok@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Mike Christie <michael.christie@oracle.com>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 22 Dec 2020 10:18:24 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.11/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8355e740f419a081796e869bafdfc0756b0bf2a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
