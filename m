Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD78C433F5
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 07:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348723AbiCXHxD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 03:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348763AbiCXHxB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 03:53:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DE899682
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 00:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=acBu3tCXyEDVeYAYV28iacN7Cu33sK9G4LGzMEiquog=; b=HufQcqfqkBCZUaJmBHctMBLkD+
        ed7UwenYXKVCxq6QLh5mNxavPdu4BQmrHFa2Kob/GDWXM6em9zGco2pfsk93pVslrb0T13SKIqvL4
        pje4lgYFiYcB/8JE5sImpt4XVXZZF3OnBQcPTsutCsNsjIzM1B1iJL5/hNlVAXeQdYsrXgjbyAnD5
        +2W3UlYJiIW4sRTYy+h50SR+hMyIjGpZhK8Ky/Po00sJ9MeGU333jhTwSXj7eoT3sEz5LQyh+eEjh
        sr3fyvvTSqD+/2I7XFQ/B2rzYUiwKzveK0MzHEXOw/E1uXomQbBNhmtIGedY3c1A2uRpOxqka0EO3
        UuDiz6yg==;
Received: from [2001:4bb8:19a:b822:f71:16c0:5841:924e] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXIFd-00FzTF-0X; Thu, 24 Mar 2022 07:51:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: yet another approach to fix the loop lock order inversions v4
Date:   Thu, 24 Mar 2022 08:51:06 +0100
Message-Id: <20220324075119.1556334-1-hch@lst.de>
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
