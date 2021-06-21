Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D67DC48BC2
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 10:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1BA161206
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 10:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhFUKU4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 06:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhFUKU4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 06:20:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAEEC061756
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 03:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=284/DoXBnGJsBKFN094fpGnokc/0VVOFNvD9vzIpZOE=; b=bR2opcsLo54hJwC4SrLZVFEIen
        yVwoSKiSJGzXWUBGYlto8IYLvcLrnRSS33Bg6q1EsvcEfb4sNNpuIhkWIjm70NO5PzB4dwb1UUkBR
        xagJRWJOKQEzoBsu188aT05ER+NnlAO+0vuhE+xtYHD8nhmnzRbvxuV79E3x+Kp99RzME66HoWPqT
        wApb70wgn21s0M0TTbX3yFisCp6z+R3Qd2wLK50rK0q7I+AEB1HmMwnfC96OR/BjncGW5Y1fzE3Yc
        wGDuRz+SPP5GrpEwb1QW/1HbVkFnXy9MaSWJaJ+Oi97Em9fSz9jM+GLwWxeZNoLM0qNOOpjf1aqiT
        rClzoKbg==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvH0A-00CyZn-Fi; Mon, 21 Jun 2021 10:18:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
Subject: loop cleanups
Date:   Mon, 21 Jun 2021 12:15:38 +0200
Message-Id: <20210621101547.3764003-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series contains a bunch of cleanups for the loop driver,
mostly related to probing and the control device.
