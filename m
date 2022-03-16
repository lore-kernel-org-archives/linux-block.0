Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F59C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 08:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354616AbiCPIqq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 04:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348751AbiCPIqp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 04:46:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37C264BD2
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 01:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=R4DjOf1rKH+s0DNPq30zYC/z589nlbIPkaHMNk9/LeA=; b=zoy9Cpb0FAqLlTr9oKk7qmAV9P
        YEoHtfBSn11Z+JR8HzXQA16cw/8mnIegHg8GG5dJNHuLAOxiHe93cjyEoAUTRqFkXElaHoUDpu9wF
        knPr9WbC5bSmdcvyWzqRL6mU6YuxH9lIhN5TNEkjgA7rFFoMlFxplLSALOUkW0ZgZhyAAmfSstY6y
        ZrRe82EKtiPnFdQl+MzcuOXQDGojILr65IFEcSk+JA0a7HmMtEZFjLy+OpfnR7BMupWHvOLwW1H1G
        joCj9IqS/lhrN30GyIzp+EtFEIvnxhKcBklzHrYUFtMtpFgMc2Pu1flAtv428/jQTYrr+u2g7Sgwb
        F7/nNnUw==;
Received: from [46.140.54.162] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUPHV-00CC78-Q7; Wed, 16 Mar 2022 08:45:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: yet another approach to fix the loop lock order inversions v3
Date:   Wed, 16 Mar 2022 09:45:11 +0100
Message-Id: <20220316084519.2850118-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens, hi Tetsuo,

this series uses the approach from Tetsuo to delay the destroy_workueue
call, extended by a delayed teardown of the workers to fix a potential
race window then the workqueue can be still round after finishing the
commands. 

Changes since v2:
 - rebased to the lastest block for-next tree, which has the async
   clear reverted and ->free_disk
 - impkement ->free_disk for loop to handle open vs delete races
   more gracefully
 - get rid of lo_refcnt entirely

Changes since v1:
 - add comments to document the lo_refcnt synchronization
 - fix comment typos
