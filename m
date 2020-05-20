Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2A2C433E0
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 17:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23FA9206B6
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 17:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m58tSGxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgETRGk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 13:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETRGk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 13:06:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0771C061A0E
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 10:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=W4qyqt6NRD0yqV2kO85IHgwKzbmizLQPIUHsrnxgQfg=; b=m58tSGxAMILgFs0pqW6MUhW7OZ
        Nu6xQZ179Q55LNShYUUCla6ubAwwPq7fmFSnBZ4rZObsXfQ0M53BUYTVwMf0pqAxgk4AOKnxehmz4
        weOS/t8FqCjkztm4SGguZ3094TsPU29k3DTx/31TYqLqXM5sJepzEOZLBb9ZLxEgOTU/PsYpk6Rge
        dgPIR3kzPP3wM5ToTD1F6ArjsH4emoVs90h5WMAy+0zz6G7G6J50EO7fXZih0Uw4j8fozU3xHgLtR
        5tqaBGZtVc9wIxWlxNhF+0cX5aljDdF6EAw7+DFdxmNfWHja9L07IuMbxrgijPC8/sv7uNI7cCKjx
        w3wLwKng==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbSAv-000367-DC; Wed, 20 May 2020 17:06:37 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: blk-mq: improvement CPU hotplug (simplified version) v3
Date:   Wed, 20 May 2020 19:06:29 +0200
Message-Id: <20200520170635.2094101-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
o:      Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this series ensures I/O is quiesced before a cpu and thus the managed
interrupt handler is shut down.

This patchset tries to address the issue by the following approach:

 - before the last cpu in hctx->cpumask is going to offline, mark this
   hctx as inactive

 - disable preempt during allocating tag for request, and after tag is
   allocated, check if this hctx is inactive. If yes, give up the
   allocation and try remote allocation from online CPUs

 - before hctx becomes inactive, drain all allocated requests on this
   hctx

The guts of the changes are from Ming Lei, I just did a bunch of prep
cleanups so that they can fit in more nicely.  The series also depends
on my "avoid a few q_usage_counter roundtrips v3" series.

Thanks John Garry for running lots of tests on arm64 with this previous
version patches and co-working on investigating all kinds of issues.

A git tree is available here:

    git://git.infradead.org/users/hch/block.git blk-mq-hotplug.2

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-mq-hotplug.2

Changes for v3:
  - don't disable preemption and use smp calls

