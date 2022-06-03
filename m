Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23D5CCA473
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 18:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347941AbiFCSuZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349102AbiFCSuI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 14:50:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985672870C
        for <linux-block@vger.kernel.org>; Fri,  3 Jun 2022 11:50:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB589B8246B
        for <linux-block@vger.kernel.org>; Fri,  3 Jun 2022 18:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71BC8C36AEB;
        Fri,  3 Jun 2022 18:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654282203;
        bh=FtAWmHYeVorFAqBa/QKqPa0/DQEsBrGL3Q2oMyMGHCU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rRjfK8d6KqD/FeskdyAiPN9ZY22HxD6xy9rWL83nWEMvsTHRw2LkChq0zEutkD8oF
         syhOq071biJEIQc/Mgdypd2DPZs4zNh9Ze7aK3QyZGbtho6v7a3LWXfeTX9TvFHD7z
         5wqWEqKV6qZamqwNJ+Z/zyje+f3AdqDbqxznVm5jhYrZQcmhTLTnQSrvsipu7dYnxv
         ZxcTDnAOnn2WM9U6UZ7n8dhRuJkVwFeCZZX/qCesB/9pubdtgUn1JQRtWDW1q2RyHi
         G8o6qJXQMvOzF/gvn3U8rsZVGPRe+hRWYL7O3Q5QP3Gf2q+uY7s0KIHhrNVhosi1Tx
         34+3BnkqCYfIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5DA4BF0394E;
        Fri,  3 Jun 2022 18:50:03 +0000 (UTC)
Subject: Re: [GIT PULL] Block drivers followup pull request
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c47ef1fc-eac8-5b2b-9952-6e5fcdbce590@kernel.dk>
References: <c47ef1fc-eac8-5b2b-9952-6e5fcdbce590@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c47ef1fc-eac8-5b2b-9952-6e5fcdbce590@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.19/drivers-2022-06-02
X-PR-Tracked-Commit-Id: aacae8c469f9ce4b303a2eb61593ff522c1420bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78c6499c92090d0fd1ddd1684fc3a5dc41d98c92
Message-Id: <165428220337.10974.7113657092830562879.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 18:50:03 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 2 Jun 2022 23:36:50 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.19/drivers-2022-06-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78c6499c92090d0fd1ddd1684fc3a5dc41d98c92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
