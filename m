Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855EBC433F5
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 13:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbiA1NAc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 08:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbiA1NAa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 08:00:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4027C06173B
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 05:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=OjlBuuU+/hqo1CyavPDbFvtCKX7l6kuyRM/sJpjnsNE=; b=AjEAhRiEwlXJQqoWfO9XZQY/j0
        O0a+EJqEk8+EVSZsogNa0/OlX/j17gVGO93ABzZP99MoKRRdr3wp2E25Hcxg6w98cKcStNY3qFtvv
        1Mn1g3uL18Gbjer5z47YUcwwJj25U5WWjMdfvtAWtZoAhypxOiWJqlhu9OyxSGTuTJd178s2Qzi85
        QSJAEdraoV8qBVp+3VxkoFu3L0Z5Iqw7hOmSK7oCLycAwVuadRAZsD76wYGLs/f2x7hfYcjAkCQuE
        1LdGhSz/VfhsoAW/CtQnPFlmFT/WGyLFgd+ZbyTCf3ppqKKwz907TkN5CpCgFbVQWpmJq4CpN5tFB
        reZRgs6w==;
Received: from [2001:4bb8:180:4c4c:73e:e8c7:4199:32d7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDQrY-0028pO-IE; Fri, 28 Jan 2022 13:00:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: yet another approach to fix loop autoclear for xfstets xfs/049  v2
Date:   Fri, 28 Jan 2022 14:00:14 +0100
Message-Id: <20220128130022.1750906-1-hch@lst.de>
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

Changes since v1:
 - add comments to document the lo_refcnt synchronization
 - fix comment typos
