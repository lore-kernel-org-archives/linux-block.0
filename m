Return-Path: <SRS0=+PfW=PG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03131C43387
	for <linux-block@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72EF21903
	for <linux-block@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546047016;
	bh=VNjgzw9ytK4dBXhZj7dHkBAf8//YIgZ5xeNVY8ERcCk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Sc5Wg8MuW1enjGrFHnCcTVizqRVflopG1EL9zVBGRWvpuCGWZpnOYuctu8BUyvRyj
	 8nARLNhfTQdwtLUr3gz0M4avu13rwf8y2+ATb7ansCrVCCxiEPLgY0F3Wy/tvZ9Mjh
	 85gt6ZVlyZ6Qdqhyp04d0UD5MZqXM3h1DiEKYGhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeL2BaO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Dec 2018 20:30:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbeL2BaG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Dec 2018 20:30:06 -0500
Subject: Re: [git pull] device mapper changes for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546047006;
        bh=VNjgzw9ytK4dBXhZj7dHkBAf8//YIgZ5xeNVY8ERcCk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jBNonkRojvlH9+A07mtifYL9RaZrCn0qSpbMTEHp20EsTBIjnRnRCQHF3ywDdU+8b
         yp2IzhtnxcLnEyjMV1ibNBoxsnFLRrcPjJqQ+WuHJ9KFDNPO26DAlXkvFZDyBlRjQJ
         W54QToAg/t9MoLeMq6I6EzpH/MLfaFSJ3tCfETME=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181227160944.GA12190@redhat.com>
References: <20181227160944.GA12190@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181227160944.GA12190@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-4.21/dm-changes
X-PR-Tracked-Commit-Id: c6d6e9b0f6b4201c77f2cea3964dd122697e3543
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ed7bdc1eb4c82cf4bfdf6a94dd36fd695f6f387
Message-Id: <20181229013006.17208.70533.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 01:30:06 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        AliOS system security <alios_sys_security@linux.alibaba.com>,
        Colin Ian King <colin.king@canonical.com>,
        Eric Biggers <ebiggers@google.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shenghui Wang <shhuiw@foxmail.com>,
        Sweet Tea <sweettea@redhat.com>,
        wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 27 Dec 2018 11:09:44 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-4.21/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ed7bdc1eb4c82cf4bfdf6a94dd36fd695f6f387

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
