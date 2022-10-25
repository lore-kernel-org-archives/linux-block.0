Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471ECFA3740
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 14:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiJYOki (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 10:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiJYOkf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 10:40:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4117E308
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Mo0I4vEOLvvjk8gjEeiZhK4hGLEZ8BanpX5CwiA8f8A=; b=0yXLm66vIdyg2pTutXuY0BQWtY
        LFRFowUODsRHhmRh+UP6rwuJpiH4cs8c8IO5vbqk6Y8g+e96uIdY3wh6GznGM0vGpL6FAkYsyDMik
        0qWEolX1Xnts41XXiTts39Z+C/KDnufpcSbnXMBXQ6dtmELBwtZNknfuCYqY637YLVsHGhywuooOL
        EwAjMhGdoUToyoUTvobF8cTt+oievc2Vv6CfTEzu6OlZwDxiEIBKzSRbZbTJVgnqA8mV9TIvyYfyi
        65qCvBOqB3YovXr9DERpfnax6KNTtux4IvQTP1lUtoKa6zG9T4pywMq/k5nUrEzI9zqexwx4mc22d
        5dazKUlw==;
Received: from [12.47.128.130] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onL6K-005plu-JM; Tue, 25 Oct 2022 14:40:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: per-tagset SRCU struct and quiesce v2
Date:   Tue, 25 Oct 2022 07:40:03 -0700
Message-Id: <20221025144020.260458-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this series moves the SRCU struct used for quiescing to the tag_set
as the SRCU critical sections for dispatch take about the same time
on all queues anyway, and then adopts the series from Chao that provides
tagset-wide quiesce to use that infrastructure.

To do so it does a fair amount of cleanups in how nvme quiesces queues.
Even with that nvme is still a bit of a mess in how it quiesces queues,
so further work is probably needed later.

Note: testing is a bit limited as I'm travelling.  Before this proceeds
it should get surprise removal testing for nvme-pci.

Changes since v1:
 - a whole bunch of new nvme cleanups
 - use the notify version of set_capacity in blk_mark_disk_dead
 - improve the documentation for blk_mq_wait_quiesce_done
 - dynamically allocate the srcu_struct in struct blk_mq_tag_set
 - minor spelling fixes
