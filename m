Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E6AC433E0
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C792089D
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AtRBJ7n/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbgE0SGy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 14:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388737AbgE0SGy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:06:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3325BC08C5C1
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 11:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ADoQYw+2O2yvpu7V0ICKILd9NFz4fUQ5QKBd1Yxcx5k=; b=AtRBJ7n/QTxCgh0kKyi+xHf+HK
        kA8VBfyI7BbrMECYvFJNEohAb/Ceh4oEm4WVqA1eiAPtLlsAdKh0i0ik6oJy8TFMT1tAGKME63pxn
        uGypzCqLyWLS4hhYYwsm7zMZAGIvI5mkWnB6FZw7g7c8Pa6Xvr4lFzCKlsxFCINRehYjyX9CjhF74
        xs5KdPpQSHsmV9TCYV9CIvF8ximGLdhcL0Hur/b/qhpCGC3OLEapiXv4bXSSTaejfuphLIqUEcc5J
        +8NL+mFBmDyVtIZug2BLXM3DtrKGW/z7Xp4IjRGfwkNKj915hd+0bqwLQkSdUSpWh3fDqjWsiAyhY
        JHAkTLLQ==;
Received: from p4fdb0aaa.dip0.t-ipconnect.de ([79.219.10.170] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1je0Rz-0004ys-QW; Wed, 27 May 2020 18:06:48 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: blk-mq: improvement CPU hotplug (simplified version) v4
Date:   Wed, 27 May 2020 20:06:36 +0200
Message-Id: <20200527180644.514302-1-hch@lst.de>
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

    git://git.infradead.org/users/hch/block.git blk-mq-hotplug.3

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-mq-hotplug.3

Changes since v3:
  - add two new patches to clean up the magic -1 tag values
  - improve a few commit messages and comments
  - cleanup the blk_mq_all_tag_iter implementation
  - add a msleep to the cpu hot unplug case in __blk_mq_alloc_request

Changes since v2:
  - don't disable preemption and use smp calls

