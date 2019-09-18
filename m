Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF10AC4CEC9
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 00:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D89206C2
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 00:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568766328;
	bh=REN6DREB+Iy6jcZq8dYrKvB47ylKXnmapBcWAK8v4hI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=n1zzL+6Q7BnslyYFoBSnVrry+kcfcV4CX3i/LTGUEObJitbrOpgl3XFGJg0CeR9tn
	 fFGWMXcQrCwDv+9D5wkQs7tLXEVjl6PEQayKAiEpnf4gQo7WK8zxU5YQFTeAuCPX63
	 Vk06J6oeenFdhJxIj1d6goJSKLm6V+LqwD13+nRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfIRAZ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 20:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfIRAZ1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 20:25:27 -0400
Subject: Re: [GIT PULL] Block changes for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568766327;
        bh=REN6DREB+Iy6jcZq8dYrKvB47ylKXnmapBcWAK8v4hI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sbZtyzlUwigv2vvTjUh1oriBruG0jF2OGNxk4lIWHKynUKvJ53faWm9hybwEd3OCd
         2RY+X/odPyW0Uf/RvfVnDRscoGpvsBOXZfHOmPktPbnDOOJ/g7Mak3dLJE5APrLTZa
         zhZYWQxu9LaUFGohCax7yFN4aTSF4DFrmJ4YQ3tE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <61b11672-f41b-9708-2486-f284a99483a8@kernel.dk>
References: <61b11672-f41b-9708-2486-f284a99483a8@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <61b11672-f41b-9708-2486-f284a99483a8@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.4/block-2019-09-16
X-PR-Tracked-Commit-Id: 9c7eddf1b080f98fed1aadb74fe784f29bf77a08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ad67ca5534ee7c958559c4ad610f05c4578e361
Message-Id: <156876632731.801.10089706031572232123.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 00:25:27 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 08:52:03 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.4/block-2019-09-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ad67ca5534ee7c958559c4ad610f05c4578e361

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
