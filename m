Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BE5C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Dec 2021 11:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243319AbhLWLZT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 06:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbhLWLZT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 06:25:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9090C061401
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 03:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=gnZPDsjXNLMjRjuGoGPByGH0Kpxm+3uyHrfYatnAJzQ=; b=P43McsCVDPD01L8FZKY4bkqHVU
        aW9a7bU4qA3cT42Hro0LhxH0YTrFp/tPfgCjIpZv1k1Dt0y6UBEF+6jNTmToY33wuY17DdD/NRZjr
        th0Il1XXxNulUvaYh7XBrwkstGtD6jM07JZb0flXQBAWCll0rhbIbnglOLqxzVnmIvHasuE5aujQE
        mVOqdycELHjPRc542TENgS599E8Q2VVcjEp4Qv5hDjFblWbW4VRTDqxtgyn/9u44oxfpcm11Gz5L+
        PucY9S+Q1Ar5hRbhAeC7Zo4uUKefAvZqhYPZLZnlAIzdbns8RXliwh36+U2ADU/B9u4EhpviyNlMK
        dh2az9ow==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0MDg-00CZtG-Ah; Thu, 23 Dec 2021 11:25:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
Subject: fix loop autoclear for xfstets xfs/049 
Date:   Thu, 23 Dec 2021 12:25:07 +0100
Message-Id: <20211223112509.1116461-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens, hi Tetsuo,

this is a 3rd approach to fix the loop autoclean delay.  Instead of
working around the workqueue lockdep issues this switches the loop
driver to use a global workqueue and thus avoids the destroy_workqueue
call under disk->open_mutex entirely.
