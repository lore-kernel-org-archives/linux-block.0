Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672E4C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 21:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1560064F0B
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 21:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbhBXVyE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 16:54:04 -0500
Received: from mout37.gn-server.de ([87.238.197.12]:53270 "EHLO
        mout37.gn-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbhBXVyE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 16:54:04 -0500
X-Greylist: delayed 1604 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Feb 2021 16:54:03 EST
Received: from mout17.gn-server.de ([87.238.194.244])
        by mout37.gn-server.de with esmtp (Exim 4.92)
        (envelope-from <lkml@mageta.org>)
        id 1lF1g5-0002Y6-0I
        for linux-block@vger.kernel.org; Wed, 24 Feb 2021 21:26:37 +0000
Received: from lc0.greatnet-hosting.de ([178.254.50.20])
        by mout17.gn-server.de with esmtp (Exim 4.92)
        (envelope-from <lkml@mageta.org>)
        id 1lF1g4-0004oC-QQ
        for linux-block@vger.kernel.org; Wed, 24 Feb 2021 21:26:36 +0000
Received: from chlorum.ategam.org (ategam.org [88.99.83.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: work@mageta.org)
        by lc0.greatnet-hosting.de (Postfix) with ESMTPSA id 9CFB13632C0F;
        Wed, 24 Feb 2021 22:26:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mageta.org; s=mail;
        t=1614201996; bh=1IRpMIfJNZ/4nKgICjDhwgsizMFM6beZk0pv7NWhmas=;
        h=Date:From:To:Subject;
        b=lPOrg/PkSzJS+wnQN19CSxJ6RumJYJjG01oHF1Zm4gd/nxoWw2K6tnd9rERztOLsd
         2XycMis9AI/YOBDMwZ1vgbUCn4Iu6qlwWD9B6PF5w8i1oaB0LG+qPf7vpkLJw5z7nX
         apYutZHHH3hvVUw2SLJ5dEXrJZcsQhNVutfLxon/KlQHRd8gp79ioy2QY2rNblesow
         n77utV+7WZrevBqVhuCanuZcC626LN50wpjGR+sVE18p8Gl0bKs8Ekhxq0GGnhJkTn
         IAqhhmStfJ4pF4KHlexxPFZjEuWi22XRcS7PelV1W9d4+cakFIIDTKo00cGKAHOWtH
         9gdoi0k8NcFdA==
Date:   Wed, 24 Feb 2021 22:26:34 +0100
From:   Benjamin Block <lkml@mageta.org>
To:     linux-block@vger.kernel.org
Subject: Can a kblockd work-item be preempted?
Message-ID: <YDbEiqCSU3lSbbpT@chlorum.ategam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at lc0
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

it might be a silly question, but anyway. I was wondering if anyone could
tell me whether a scheduled work-item on the kblockd workqueue can be
preempted by the scheduler?

So when the worker is in the middle of dispatching requests in
`__blk_mq_sched_dispatch_requests()`, can it be put to sleep by the
scheduler, so that for example an other worker on the same workqueue can
work on a hctx from a different request_queue on the same CPU?

I'd imagine so, if preemption is enabled for the kernel, but it's not
obvious to me right now.

Thanks.


best regards,
 - Benjamin
