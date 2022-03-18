Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3656DC433F5
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 19:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbiCRTkU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Mar 2022 15:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240394AbiCRTkS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Mar 2022 15:40:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E433B10CF36
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 12:38:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D65861BCD
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 19:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFB18C340E8;
        Fri, 18 Mar 2022 19:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647632337;
        bh=tT42yMGGkAwgAYsox3saVD7DWxs3EyNO93hSJGVRZ5c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CM2glbf1u46bQ525C6XEUoPh28lbDyjp0fF+YOZ9SyuhioG/WYnWrl121D3b1P/Hp
         rpEmiO6T4MVyG5rjbVlzIrSgYP5xOfOQnbTwKQeSFB4P9DJYMuArboi2bQuZ2sYIJQ
         oRgGGD7d9pzMo7FBYQmJ4KzJ4SCUZhMK95mhdmETgfJMKHT+oBmTEPVWGmQcQSPs2H
         hUB6JAo7BDJ2sfERYF7vhHGrjFAOndI/zlvFkTYgGoRgs/0OJyWDYwI12/d7m47ukn
         od34h5HWIVFavCJRBRyK9Zt5NUv6tsxLMi8eV1CvsAuA6WHUltQ8M+SyoncpuDteUw
         sU8Ww6ENumTlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C92C1E6D44B;
        Fri, 18 Mar 2022 19:38:57 +0000 (UTC)
Subject: Re: [GIT PULL] block fixes for 5.17-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <667d556f-dc12-0cc2-2abf-5a478fd93d35@kernel.dk>
References: <667d556f-dc12-0cc2-2abf-5a478fd93d35@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <667d556f-dc12-0cc2-2abf-5a478fd93d35@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.17-2022-03-18
X-PR-Tracked-Commit-Id: f6189589fa7cc4fb6b53f2929f69f0505123202f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c4bcd8140770f8190a8e691aff0e3550069edb1
Message-Id: <164763233781.31275.1487861898654702540.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Mar 2022 19:38:57 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 18 Mar 2022 11:05:06 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.17-2022-03-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c4bcd8140770f8190a8e691aff0e3550069edb1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
