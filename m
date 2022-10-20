Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F955C433FE
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 16:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJTQqb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 12:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJTQq3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 12:46:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF151C2F1B
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 09:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=XTwsWFxPSerjqqNhyUvpyPqkcjimvk+Plvaxr7RQAkI=; b=K0VZ6wBP5HGYpWmwQFOfy4Reve
        bjUMHhncLiBWkQx9f0Yvp3qTj9bgSlzAA3IzTFeuTaASbqvxSHdjqv5/FbnQVkX9XRyxwca6JiUeW
        saNxkBwdUcWVdQqQAWqWvByABnl6QwyxPgDZ/gWAzcLtRg8zdwRycljWxmUMgdgunafQHC1zGVmjl
        KTkJI7NTYbjb0AhkdE+dOJdmaIC/ftl/k4uQEndgQ27VPAgRRq/iWaoDZA9qx2ncvOVH8/S8eNKeZ
        Vt7a7TAzQ4Pse5teyqEGpf4JkawcBsEZptp7IYw65kidcXjZTjagGSxbdPLInh3UcRMQ17Bk8cctP
        qpbN0NqQ==;
Received: from [205.220.129.26] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olYgV-000WDb-7A; Thu, 20 Oct 2022 16:46:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: fix delayed holder tracking
Date:   Thu, 20 Oct 2022 09:45:59 -0700
Message-Id: <20221020164605.1764830-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this series tries to fix the delayed holder tracking that is only used by
dm by moving it into dm, where we can track the lifetimes much better.

Diffstat:
 block/genhd.c          |    8 +--
 block/holder.c         |   40 ++++------------
 drivers/md/dm.c        |  122 ++++++++++++++++++++++++++-----------------------
 include/linux/blkdev.h |    5 --
 4 files changed, 80 insertions(+), 95 deletions(-)
