Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86657C433FF
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 22:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A879217F4
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 22:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564783819;
	bh=wcMvWbtMDdPZUPoqie2n1uaDBEMGQsDfH7sitd5+kpk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BjQcUhnWA+jburkszjR+/gRRuHqvOFXRj5w6bd10Uq2XPuYXkTYPAD0SlXgknfLS2
	 aA7rYd6qVcm1zgQXdENx1qLjShBTfuo45angZljHYOX3zQNjbbE8/yLWjrYlpPh1FU
	 KRfF6GTnCQw4/9SrmIKlzA/NSs6pAbEzMAbLITzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437211AbfHBWKS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Aug 2019 18:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730974AbfHBWKO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Aug 2019 18:10:14 -0400
Subject: Re: [GIT PULL] Block fixes for 5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564783813;
        bh=wcMvWbtMDdPZUPoqie2n1uaDBEMGQsDfH7sitd5+kpk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JVXUxrQGkFRioMmSvJhVNvr5p90LFTt34y4oJFgSNkrV2OchgtqeTycevJqrI1enZ
         6GGSeF//zUfl3THlD1joPO3RqMtNbqpCmKzaF5nCzoLu0ZhLms2Jkfqjgcn2T9fY4L
         E5qpU2tBCS5V+fXc3RWdOklcsZaofkFQZZZZjjXE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b46c1b0d-4142-e6fb-5ef1-1f90a8d4200d@kernel.dk>
References: <b46c1b0d-4142-e6fb-5ef1-1f90a8d4200d@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <b46c1b0d-4142-e6fb-5ef1-1f90a8d4200d@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190802
X-PR-Tracked-Commit-Id: 41995342b40c418a47603e1321256d2c4a2ed0fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10e5ddd71fb35cfa4eb86a980b6951d4fe9f68a9
Message-Id: <156478381334.28292.7595275755245136714.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Aug 2019 22:10:13 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 2 Aug 2019 08:16:07 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190802

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10e5ddd71fb35cfa4eb86a980b6951d4fe9f68a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
