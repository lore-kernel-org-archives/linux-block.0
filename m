Return-Path: <SRS0=/LTC=27=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FB7C282DD
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 20:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC154205F4
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 20:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578687905;
	bh=rIQnh7oIqGOv+p9GxD1lN963QHHQ2IZsGn43dWgIn1I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uO8fx/dJ58n4XqyK8RpLTbyhsaLcEKAHwzOa3RcX10tzhdN2ipp/6oEvYHkTfs+y0
	 sqw512Pae3S89nSuSROYVMauJfazvVuvNVXWhLmS+Uf6Ck1xUZgPIr6IkGBw8hAryJ
	 I9wND4JjtXX1tPGkVHzuCTo+mmwPXMsIBJepkNS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgAJUZF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:25:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgAJUZE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jan 2020 15:25:04 -0500
Subject: Re: [GIT PULL] Block fixes for 5.5-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578687904;
        bh=rIQnh7oIqGOv+p9GxD1lN963QHHQ2IZsGn43dWgIn1I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eOyCQoMSE4Dy0Hf4r/A2f7TYTs4oYrIUnxubYFF2eQGFCvo8ndxd6lT/HVTZh1KKV
         CgJWqp4DvjV5z2CfYyzxAFPjyRq+324oS8v5GFBptXM4B7ZVHxBjRmxQz55t5aQIbl
         Y6h8rSAi4q2LSofopGWDI7Kvuv9V6rzIqGckhkWc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <09fa9f3f-ca5c-f98a-d4a5-446810906107@kernel.dk>
References: <09fa9f3f-ca5c-f98a-d4a5-446810906107@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <09fa9f3f-ca5c-f98a-d4a5-446810906107@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.5-2020-01-10
X-PR-Tracked-Commit-Id: e17016f6dcb047f91a8fc9f46bbf81a21d15ca73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e4cd21c64dadc608e569a15b56e86eb85137fc9
Message-Id: <157868790432.12373.15068271717645411496.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jan 2020 20:25:04 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 10 Jan 2020 11:11:19 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.5-2020-01-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e4cd21c64dadc608e569a15b56e86eb85137fc9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
