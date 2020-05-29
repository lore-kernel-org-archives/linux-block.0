Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E596C433DF
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 13:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A031206A1
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 13:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y8iDr5pQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgE2NxV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 09:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2NxV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 09:53:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68193C03E969
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zR4VGn6TLGon0kEy/WMqfQoYfX94rtHHTjF1VjOxzQI=; b=Y8iDr5pQmsq+7+AFXi8rm/Ln0P
        llQKzFYHxyJXP3KMbQB5cvwMKNf8PWErXOucY4+y0Okh+JVBc2Ah73nl0VBPiOZLN0txw2uqlErBP
        MAcX7TtmWKBrMiPgeHWlPlCL2z6JpQdqzW68v06tyMpw5QyYX1tmCiaQ2TshVbr1kZTGnF0Z2TUai
        nVBCq0K6ldlNEaFbpEwZSOPjYqrxIlhCbXTT6YFgKQ2GuaAZ2AFJh1VkISZI/6omX+XM3WTBTnn2B
        P32OKntamtEbssOt/t1OnvEn5juCix46pdc4mPqiBKfFCV3CKyypM1X5Dalde7fYy7i+1Eb56Dns0
        rHHiF6ig==;
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jefRl-0000nT-NY; Fri, 29 May 2020 13:53:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: blk-mq: improvement CPU hotplug (simplified version) v4
Date:   Fri, 29 May 2020 15:53:07 +0200
Message-Id: <20200529135315.199230-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

Changes since v4:
  - move the blk_mq_all_tag_iter kerneldoc comment to make it clear what is
    documented
  - add a WARN_ON_ONCE
  - use BLK_MQ_NO_TAG in one more place instead of -1
  - remove the PF_KTHREAD special casing

Changes since v3:
  - add two new patches to clean up the magic -1 tag values
  - improve a few commit messages and comments
  - cleanup the blk_mq_all_tag_iter implementation
  - add a msleep to the cpu hot unplug case in __blk_mq_alloc_request

Changes since v2:
  - don't disable preemption and use smp calls

