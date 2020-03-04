Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F404C3F2CE
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 19:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0212C21775
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 19:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583349307;
	bh=ujN7LpsXubpCXIrgdFQ0pT5IPtc5kT22ZAzxA30SPb4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aHFNGdAx1UwwiSA5lNyHHDScitAGHRSrukTMNm2s7PxcGh8E9kN9EoRLgT0Um9cqJ
	 Dy2n/z+FjVsitsAo6+mlDXu2bRklpRm5jAgNozpTZlp8hhJpSYohhcbreguaoKU2vC
	 LInIPMVyP5zus6rKpvGshG2BRgjRJatvk2/cM/DY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCDTPG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgCDTPG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Mar 2020 14:15:06 -0500
Subject: Re: [git pull] device mapper fixes for 5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583349305;
        bh=ujN7LpsXubpCXIrgdFQ0pT5IPtc5kT22ZAzxA30SPb4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vTyq14E0KqL4XvgG8HGXxAVfqa0Nh5uYSW8Z6ZD409glOnscH6GB8aIlJcZ4TwczW
         YaemtM5TJdzyp4T5d6/J+MHOS8g5VQU6aiU+QpckZUpm4tBajhJyrztJxuyQAu2bvb
         2pep8w4UVerpGTx1010H4KziSXZ7f+TRHeIB9H7k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200304150257.GA19885@redhat.com>
References: <20200304150257.GA19885@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200304150257.GA19885@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.6/dm-fixes
X-PR-Tracked-Commit-Id: 636be4241bdd88fec273b38723e44bad4e1c4fae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 776e49e8ddb5169e6477fd33a396e9c7b2eb7400
Message-Id: <158334930588.25458.12566074369061946037.pr-tracker-bot@kernel.org>
Date:   Wed, 04 Mar 2020 19:15:05 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Hou Tao <houtao1@huawei.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Theodore Ts'o <tytso@mit.edu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 4 Mar 2020 10:02:57 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.6/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/776e49e8ddb5169e6477fd33a396e9c7b2eb7400

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
