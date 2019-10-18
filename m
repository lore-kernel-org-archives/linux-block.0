Return-Path: <SRS0=h0yA=YL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E350CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 22:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4AE222BD
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 22:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571439009;
	bh=TrjMI02k+DP2jGhDn9JOnK2Zrlvr3hCiZOxRLSzptCQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KA/XWdYahzL40A2QWCOCRa6o3t+chmWCPd04V6RUFbPtvmDtk4XBJa9HndiJ9uEsV
	 Mi7dHUkgAQZTBdr6U5q+PMTixZKRgWTfqcSA7C9xqlHsoFZyl6X1zX/6/RRrF1iXtF
	 njwWX3wuzSevzbZRbPuUJmsGN8DYe3knhTM6oquQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395087AbfJRWuI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:50:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:32890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbfJRWuH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Oct 2019 18:50:07 -0400
Subject: Re: [git pull] device mapper fixes for 5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571439006;
        bh=TrjMI02k+DP2jGhDn9JOnK2Zrlvr3hCiZOxRLSzptCQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YkN5GMvPOpggIMo8WcD3x/OsHHixuTzGMf9xxrd07T1D3A065AfcUllG/q7wWdxxP
         NMT5fl2xpZqnJod2oR4sEcY6wrNd6Y8gGGQwA+Spk91424zJMu/BbJX4hTYhEN+q4y
         qIImVaklF41fdq/8nu3Ir2XbcO630pLAJhXPuz24=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191018160833.GA5763@redhat.com>
References: <20191018160833.GA5763@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191018160833.GA5763@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.4/dm-fixes
X-PR-Tracked-Commit-Id: 13bd677a472d534bf100bab2713efc3f9e3f5978
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb8527e5c13ed70057b8dfce0764ec625ec3e400
Message-Id: <157143900667.13317.911057205333721634.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Oct 2019 22:50:06 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        YueHaibing <yuehaibing@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 18 Oct 2019 12:08:33 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.4/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb8527e5c13ed70057b8dfce0764ec625ec3e400

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
