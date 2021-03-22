Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E13C433C1
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 07:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554C661930
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 07:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhCVHil (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 03:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCVHiM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 03:38:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F053C061574
        for <linux-block@vger.kernel.org>; Mon, 22 Mar 2021 00:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=iWYlea68c8FzuH+4tg8qDv1Nl0eXO516A6zNqzfMHec=; b=IUo/T/VIuycDnv4C9zh3g+gFlr
        JpV+bUzBRtGfp7q9hGpG5SiqiPHsLm29rmyJoTKXrguZAttgLKY0KJM06GoqkvQNfcyKmWcrZP0CO
        eTLZJbRnmNk5y78ZkpEFK1e0uyU0cIpBd/8e5buzLEG36d7K6GD+qkil/62qJ2FuS8cW/CcJCr5yX
        kJUsaHGZ5NzTD/LjtWMLm9+Jk8iVun58aqQNBX7BVHvQC9vlLzj7yLoybBtvcivoSpRJQqA2KJkr2
        5wi/20P7WqGk0Nh857z2gPpt3DqkBiOKQ9PO262335k3eeZONdANkGdFjhP5JxVOWZwbfpegAhxX6
        +aE+1AAg==;
Received: from [2001:4bb8:180:4ea2:5b87:a441:96f6:10e9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOF7v-0089pY-BI; Mon, 22 Mar 2021 07:37:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: fix nvme-tcp and nvme-rdma controller reset hangs when using multipath
Date:   Mon, 22 Mar 2021 08:37:24 +0100
Message-Id: <20210322073726.788347-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this series attempts to fix the nvme queue freeze deadlock Sagi reported.
It needs a little help from the block layer so that we can avoid blocking
on the queue free percpu_ref without forcing the entire NOWAIT flag and
thus also not waiting for tag allocations.
