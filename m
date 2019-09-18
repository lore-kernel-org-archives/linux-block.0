Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D33C4CECE
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 00:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891BE21855
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 00:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568766327;
	bh=7NJgUFdmTK5f/WlT4VTsG27UfcB1jkmbeYnlzcdHrqc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=f3KmcIhN0Ux9YBMEDpwg72D5p04tcrL00k7ULtVacvPl73+NhZRt536K2uouhquci
	 zuob0vT3+2B1ajFcmNcZK4rZVK6lUT1GrqiYXmFoi9M0SQwU/kpica1EVDI1LCYgry
	 jT9pZ/Myi6ymBEO4NRZu4KSrQPMES4HihbLsZwSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfIRAZ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 20:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfIRAZ0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 20:25:26 -0400
Subject: Re: [GIT PULL] libata changes for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568766326;
        bh=7NJgUFdmTK5f/WlT4VTsG27UfcB1jkmbeYnlzcdHrqc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dSdQxRNNxU9hnnhtW+KC7TvPjiVAqgHbRtmyChJDu9TT+H6+W4bt8Ivry8CSOfNAs
         2hQ3MIQBYHezkhCTTyX/JDUmy15YyLFenOlVqJ9ARFwtBfObd4JGZTQG0CLL+/87im
         /kKrO5RPR21QDpQfWreUtip3/5c27lmFkQfmE5V8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <565dc49a-4bd5-d25c-d859-1c3b103e1e22@kernel.dk>
References: <565dc49a-4bd5-d25c-d859-1c3b103e1e22@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <565dc49a-4bd5-d25c-d859-1c3b103e1e22@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.4/libata-2019-09-15
X-PR-Tracked-Commit-Id: c312ef176399e04fc5f7f2809d9a589751fbf6d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5260c2b863ef1152445ce93476c95d8c8a727eef
Message-Id: <156876632641.801.10445823909731470810.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 00:25:26 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 15 Sep 2019 17:59:08 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.4/libata-2019-09-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5260c2b863ef1152445ce93476c95d8c8a727eef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
