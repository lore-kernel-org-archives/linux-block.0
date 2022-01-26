Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9567EC2BA4C
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 15:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiAZPus (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 10:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbiAZPur (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 10:50:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8675C06161C
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 07:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WmrUQlFqa/JPMFsRGY+TPUXZir7UYQ0umPavxQw/XsI=; b=nXq7mhlVrAU7vgpR+FAf4liW5D
        xQ0jw6EhmzbZRCA82fo+4S3W3GAZ+CMynCZ8SR6FAanwXnv3XCABoTDa9WtCAmSBvxvCOwRn80De4
        LPyvOpfgwP5mL3o3w0daKM2eQ4v9K2xbmIe/uVwTKo8XSb/x69BSoZTeolt1OP2x/UrO5J2n2yraW
        rsFiNm1a/Cm7YvHLslQYsLs0Bp/INqUTf81J5vZ9rLEZ7zv4RI75loV5rtlxnlX+XvWBWLqZgWEkD
        /5AR9xbTOuo+fQLud1KBpmD5UklAEMFBwMS8HxFvThmexgN/T3SAP5FfC6F9bcaLtedAL5RMp0g9w
        t5JWXztw==;
Received: from [2001:4bb8:180:4c4c:c422:bb0a:5a5f:dce0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCkZH-00CQ38-1P; Wed, 26 Jan 2022 15:50:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: yet another approach to fix loop autoclear for xfstets xfs/049 
Date:   Wed, 26 Jan 2022 16:50:32 +0100
Message-Id: <20220126155040.1190842-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens, hi Tetsuo,

this series uses the approach from Tetsuo to delay the destroy_workueue
cll, extended by a delayed teardown of the workers to fix a potential
racewindow then the workqueue can be still round after finishing the
commands.  It then also removed the queue freeing in release that is
not needed to fix the dependency chain for that (which can't be
reported by lockdep) as well.
