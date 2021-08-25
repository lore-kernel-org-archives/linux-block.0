Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D710C4338F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 16:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2EEE610A3
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 16:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240303AbhHYQfQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbhHYQfQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 12:35:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E8AC061757
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 09:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=G65DHKLMstwkPiDtcSUQByx9gy0ElEP9CPMbq2ngRyM=; b=pHfNg9s0hEvAqhPn/rOBKd8Vfd
        vsqV2EoilE0qZSFqA78bS6wm3+n21q1cRsrQQgZgiiqmGxVyHgcEJLkFq6/t3S1t/2YpWh3BvtTCr
        AVPPWJTFzmZ1pWYzhdTbxiFlFoyExpV0igfcvgrqv2Nrnt0NYpHUde0ldq6Wdd+PpZ0Jx8OqB6wA/
        OrSU5tvlYMhrWlD2sDriGPHbfF9ic41VLaHWCqweD0uYsLDQofxg9O46kSXUe8kJxOFGAjuJv2Ii6
        1MWFFy4hv+axP/vrb0EsakRJHJNpfUP4/tGnMWZYS4W0fQhoe1aQohuu6H7AT1E5Q+6PJfJklOt5z
        7z+2TbUg==;
Received: from [2001:4bb8:193:fd10:a3f9:5689:21a4:711f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIvnx-00CTaV-Bq; Wed, 25 Aug 2021 16:33:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Xiubo Li <xiubli@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: nbd lifetimes fixes
Date:   Wed, 25 Aug 2021 18:31:02 +0200
Message-Id: <20210825163108.50713-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Josef and Jens,

this series tries to deal with the fallout of the recent lock scope
reduction as pointed out by Tetsuo and szybot and inspired by /
reused from the catchall patch by Tetsuo.  One big change is that
I finally decided to kill off the ->destroy_complete scheme entirely
because I'm pretty sure it is not needed with the various fixes and
we can just return an error for the tiny race condition where it
matters.  Xiubo, can you double check this with your nbd-runner
setup?  nbd-runner itself seems pretty generic and not directly
reproduce anything here.

Note that the syzbot reproduer still fails eventually, but in
devtmpfsd in a way that does not look related to the loop code
at all.
