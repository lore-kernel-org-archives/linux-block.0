Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59A7C433F5
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 05:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbiC3FbQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbiC3FbP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 01:31:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395D715AACC
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 22:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=R/r2J1/UolIwnStPTem0XheNOSdc4/WKmXK56uoOTmM=; b=TnbAAZSIZf8DT9VUvmjUcjlr4R
        oVvia+ZceqHSye/60UJMhtE+vtSnfZtC2OrClZSdFYD2+HUSOtVJrGmq3ApwsIo2Gzq+tofmhhCRU
        pAqstSFaSvyFPXUz5lxoW1yhTHtHxlMLhQeoQ8ENP2ZRPrv/zu2PBj1g+QOd/Dx4Xa0ea39948Jxq
        KJltydArw/IlXit79pocrO4S5KkCVJyjzX/TTIFXoJKjG6UfTglo5vIi1454rgipkRyDWneVcUsr7
        CN2IPvEVxOZT1G2h7lQlEzfczybUJywhg+2D1yo5Jo8+jAedpoRW3JzDRCPYnQMHfFCgdAfz4XYQN
        CVD5J7aw==;
Received: from 213-225-15-62.nat.highway.a1.net ([213.225.15.62] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZQtU-00EL8p-Ay; Wed, 30 Mar 2022 05:29:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: yet another approach to fix the loop lock order inversions v6
Date:   Wed, 30 Mar 2022 07:29:02 +0200
Message-Id: <20220330052917.2566582-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this series uses the approach from Tetsuo to delay the destroy_workueue
call, extended by a delayed teardown of the workers to fix a potential
race window then the workqueue can be still round after finishing the
commands. 

Changes since v5:
 - add a patch from Tesuo to move the global lock from __loop_clr_fd
   to loop_clr_fd

Changes since v4:
 - keep the (questionable) __invalidate_device call in nbd as-is for now
 - suppress uevents while reconfiguring

Changes since v3:
 - change bd_openers into a atomic_t, including a bunch of cleanups
   and fix found while adding those

Changes since v2:
 - rebased to the lastest block for-next tree, which has the async
   clear reverted and ->free_disk
 - impkement ->free_disk for loop to handle open vs delete races
   more gracefully
 - get rid of lo_refcnt entirely

Changes since v1:
 - add comments to document the lo_refcnt synchronization
 - fix comment typos
